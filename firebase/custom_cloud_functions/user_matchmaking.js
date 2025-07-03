const functions = require("firebase-functions");
const admin = require("firebase-admin");
// To avoid deployment errors, do not call admin.initializeApp() in your code
const db = admin.firestore();

exports.userMatchmaking = functions.firestore
  .document("venues/{venueId}")
  .onUpdate(async (change, context) => {
    const venueId = context.params.venueId;
    const before = change.before.data();
    const after = change.after.data();

    const prevUsers = before.usersHereNow || [];
    const currUsers = after.usersHereNow || [];

    const newUsers = currUsers.filter((uid) => !prevUsers.includes(uid));
    if (newUsers.length === 0) return;

    const userDocs = await Promise.all(
      currUsers.map((uid) => db.doc(`users/${uid}`).get()),
    );

    const allUsers = userDocs.map((doc) => ({ id: doc.id, ...doc.data() }));
    const venueSize = currUsers.length;

    for (const newUserId of newUsers) {
      const newUser = allUsers.find((u) => u.id === newUserId);
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
          candidate.id !== newUserId &&
          !candidate.matchedWith?.includes(newUserId) &&
          !newUser.matchedWith?.includes(candidate.id)
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
        await db.collection("matches").add({
          userAId: db.doc(`users/${newUserId}`),
          userBId: db.doc(`users/${bestMatch.id}`),
          venueId: db.doc(`venues/${venueId}`),
          userAName: newUser.displayName || "",
          userBName: bestMatch.displayName || "",
          userALoc: newUser.geoLocation || null,
          userBLoc: bestMatch.geoLocation || null,
          status: "pending",
          compassStarted: false,
          lastSafetyPingAt: null,
          timestamp: admin.firestore.FieldValue.serverTimestamp(),
          matchStrength: bestScore,
          priorityGivenTo:
            newUser.subscription && !bestMatch.subscription
              ? newUserId
              : bestMatch.id,
        });

        await db.doc(`users/${newUserId}`).update({
          matchedWith: admin.firestore.FieldValue.arrayUnion(bestMatch.id),
        });
        await db.doc(`users/${bestMatch.id}`).update({
          matchedWith: admin.firestore.FieldValue.arrayUnion(newUserId),
        });
      }
    }

    return null;
  });
