const functions = require("firebase-functions");
const admin = require("firebase-admin");
const db = admin.firestore();

exports.userMatchmaking = functions.firestore
  .document("venues/{venueId}")
  .onUpdate(async (change, context) => {
    const venueId = context.params.venueId;
    const before = change.before.data();
    const after = change.after.data();

    const prevRefs = before.usersHereNow || [];
    const currRefs = after.usersHereNow || [];

    const prevPaths = prevRefs.map((ref) => ref.path);
    const currPaths = currRefs.map((ref) => ref.path);

    const newRefs = currRefs.filter((ref) => !prevPaths.includes(ref.path));
    if (newRefs.length === 0) return;

    const userDocs = await Promise.all(currRefs.map((ref) => ref.get()));

    const allUsers = userDocs.map((doc) => ({ id: doc.id, ...doc.data() }));
    const venueSize = currRefs.length;

    for (const newRef of newRefs) {
      const newUserDoc = await newRef.get();
      const newUser = { id: newUserDoc.id, ...newUserDoc.data() };
      if (!newUser || !newUser.interests || !newUser.arrivedAt) continue;

      const minutesSinceArrival =
        (Date.now() - newUser.arrivedAt.toMillis()) / 60000;

      let threshold = 0.85;
      if (venueSize < 10) threshold -= 0.05;
      if (minutesSinceArrival > 5) threshold -= 0.05;
      if (minutesSinceArrival > 10) threshold -= 0.1;
      if (newUser.subscription) threshold -= 0.05;
      threshold = Math.max(threshold, 0.2);

      const candidates = allUsers.filter((candidate) => {
        return (
          candidate.id !== newUser.id &&
          !candidate.matchedUserIds?.includes(newUser.id) &&
          !newUser.matchedUserIds?.includes(candidate.id)
        );
      });

      let bestMatch = null;
      let bestScore = 0;

      for (const candidate of candidates) {
        const shared = newUser.interests.filter((i) =>
          candidate.interests?.includes(i),
        );
        const total = new Set([
          ...newUser.interests,
          ...(candidate.interests || []),
        ]).size;

        const score = shared.length / total;
        const adjustedScore =
          score +
          (candidate.subscription ? 0.05 : 0) +
          (newUser.subscription ? 0.05 : 0);

        if (adjustedScore > bestScore && adjustedScore >= threshold) {
          bestScore = adjustedScore;
          bestMatch = candidate;
        }
      }

      if (bestMatch) {
        const matchRef = await db.collection("matches").add({
          userAId: db.doc(`users/${newUser.id}`),
          userBId: db.doc(`users/${bestMatch.id}`),
          venueId: db.doc(`venues/${venueId}`),
          userAName: newUser.displayName || "",
          userBName: bestMatch.displayName || "",
          userALoc: newUser.location || null,
          userBLoc: bestMatch.location || null,
          status: "pending",
          compassStarted: false,
          lastSafetyPingAt: null,
          timestamp: admin.firestore.FieldValue.serverTimestamp(),
          matchStrength: bestScore,
          priorityGivenTo:
            newUser.subscription && !bestMatch.subscription
              ? newUser.id
              : bestMatch.id,
        });

        await db.doc(`users/${newUser.id}`).update({
          matchedUserIds: admin.firestore.FieldValue.arrayUnion(bestMatch.id),
        });

        await db.doc(`users/${bestMatch.id}`).update({
          matchedUserIds: admin.firestore.FieldValue.arrayUnion(newUser.id),
        });

        // --- Send push notifications to both users
        const sendNotification = async (user, otherUser, matchRef) => {
          if (!user.fcmToken) return;

          const payload = {
            notification: {
              title: "It’s a Match!",
              body: `You matched with ${otherUser.displayName || "someone nearby"}!`,
            },
            data: {
              screen: "matchDecide",
              userRef: otherUser.id,
              matchRef: matchRef.id,
            },
            token: user.fcmToken,
          };

          try {
            await admin.messaging().send(payload);
          } catch (e) {
            console.error("FCM error:", e);
          }
        };

        await sendNotification(newUser, bestMatch, matchRef);
        await sendNotification(bestMatch, newUser, matchRef);
      }
    }

    return null;
  });
