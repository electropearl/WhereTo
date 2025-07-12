const functions = require("firebase-functions");
const admin = require("firebase-admin");
// To avoid deployment errors, do not call admin.initializeApp() in your code

const db = admin.firestore();

exports.groupMatchmaking = functions.firestore
  .document("venues/{venueId}")
  .onUpdate(async (change, context) => {
    const venueId = context.params.venueId;
    const before = change.before.data();
    const after = change.after.data();

    const prevRefs = before.groupsHereNow || [];
    const currRefs = after.groupsHereNow || [];

    const prevPaths = prevRefs.map((ref) => ref.path);
    const currPaths = currRefs.map((ref) => ref.path);

    const newRefs = currRefs.filter((ref) => !prevPaths.includes(ref.path));
    if (newRefs.length === 0) return;

    const groupDocs = await Promise.all(currRefs.map((ref) => ref.get()));

    const allGroups = groupDocs.map((doc) => ({ id: doc.id, ...doc.data() }));
    const venueSize = currRefs.length;

    for (const newRef of newRefs) {
      const newGroupDoc = await newRef.get();
      const newGroup = { id: newGroupDoc.id, ...newGroupDoc.data() };
      if (!newGroup || !newGroup.interests || !newGroup.createdAt) continue;

      const minutesSinceArrival =
        (Date.now() - newGroup.createdAt.toMillis()) / 60000;

      let threshold = 0.75;
      if (venueSize < 6) threshold -= 0.05;
      if (minutesSinceArrival > 5) threshold -= 0.05;
      if (minutesSinceArrival > 10) threshold -= 0.1;
      if (newGroup.subscription) threshold -= 0.05;
      threshold = Math.max(threshold, 0.2);

      const candidates = allGroups.filter((candidate) => {
        return (
          candidate.id !== newGroup.id &&
          !candidate.matchedWith?.includes(newGroup.id) &&
          !newGroup.matchedWith?.includes(candidate.id)
        );
      });

      let bestMatch = null;
      let bestScore = 0;

      for (const candidate of candidates) {
        const shared = newGroup.interests.filter((i) =>
          candidate.interests?.includes(i),
        );
        const total = new Set([
          ...newGroup.interests,
          ...(candidate.interests || []),
        ]).size;

        const score = shared.length / total;
        const adjustedScore =
          score +
          (candidate.subscription ? 0.05 : 0) +
          (newGroup.subscription ? 0.05 : 0);

        if (adjustedScore > bestScore && adjustedScore >= threshold) {
          bestScore = adjustedScore;
          bestMatch = candidate;
        }
      }

      if (bestMatch) {
        await db.collection("matches").add({
          groupAId: db.doc(`groups/${newGroup.id}`),
          groupBId: db.doc(`groups/${bestMatch.id}`),
          venueId: db.doc(`venues/${venueId}`),
          groupAName: newGroup.name || "",
          groupBName: bestMatch.name || "",
          status: "pending",
          timestamp: admin.firestore.FieldValue.serverTimestamp(),
          matchStrength: bestScore,
          priorityGivenTo:
            newGroup.subscription && !bestMatch.subscription
              ? newGroup.id
              : bestMatch.id,
        });

        await db.doc(`groups/${newGroup.id}`).update({
          matchedWith: admin.firestore.FieldValue.arrayUnion(bestMatch.id),
        });
        await db.doc(`groups/${bestMatch.id}`).update({
          matchedWith: admin.firestore.FieldValue.arrayUnion(newGroup.id),
        });
      }
    }

    return null;
  });
