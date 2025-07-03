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

    const prevGroups = before.groupsHereNow || [];
    const currGroups = after.groupsHereNow || [];

    const newGroups = currGroups.filter((id) => !prevGroups.includes(id));
    if (newGroups.length === 0) return;

    const groupDocs = await Promise.all(
      currGroups.map((groupId) => db.doc(`groups/${groupId}`).get()),
    );

    const allGroups = groupDocs.map((doc) => ({ id: doc.id, ...doc.data() }));
    const venueSize = currGroups.length;

    for (const newGroupId of newGroups) {
      const newGroup = allGroups.find((g) => g.id === newGroupId);
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
          candidate.id !== newGroupId &&
          !candidate.matchedWith?.includes(newGroupId) &&
          !newGroup.matchedWith?.includes(candidate.id)
        );
      });

      let bestMatch = null;
      let bestScore = 0;

      for (const group of candidates) {
        const shared = newGroup.interests.filter((i) =>
          group.interests?.includes(i),
        );
        const total = new Set([
          ...newGroup.interests,
          ...(group.interests || []),
        ]).size;

        const score = shared.length / total;
        const adjustedScore =
          score +
          (group.subscription ? 0.05 : 0) +
          (newGroup.subscription ? 0.05 : 0);

        if (adjustedScore > bestScore && adjustedScore >= threshold) {
          bestScore = adjustedScore;
          bestMatch = group;
        }
      }

      if (bestMatch) {
        await db.collection("matches").add({
          groupAId: db.doc(`groups/${newGroupId}`),
          groupBId: db.doc(`groups/${bestMatch.id}`),
          venueId: db.doc(`venues/${venueId}`),
          groupAName: newGroup.name || "",
          groupBName: bestMatch.name || "",
          status: "pending",
          timestamp: admin.firestore.FieldValue.serverTimestamp(),
          matchStrength: bestScore,
          priorityGivenTo:
            newGroup.subscription && !bestMatch.subscription
              ? newGroupId
              : bestMatch.id,
        });

        await db.doc(`groups/${newGroupId}`).update({
          matchedWith: admin.firestore.FieldValue.arrayUnion(bestMatch.id),
        });
        await db.doc(`groups/${bestMatch.id}`).update({
          matchedWith: admin.firestore.FieldValue.arrayUnion(newGroupId),
        });
      }
    }

    return null;
  });
