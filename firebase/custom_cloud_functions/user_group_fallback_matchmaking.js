const functions = require("firebase-functions");
const admin = require("firebase-admin");
// To avoid deployment errors, do not call admin.initializeApp() in your code
const db = admin.firestore();

exports.userGroupFallbackMatchmaking = functions.firestore
  .document("venues/{venueId}")
  .onUpdate(async (change, context) => {
    const venueId = context.params.venueId;
    const before = change.before.data();
    const after = change.after.data();

    const prevUserRefs = before.usersHereNow || [];
    const currUserRefs = after.usersHereNow || [];

    const prevGroupRefs = before.groupsHereNow || [];
    const currGroupRefs = after.groupsHereNow || [];

    const prevUserPaths = prevUserRefs.map((ref) => ref.path);
    const currUserPaths = currUserRefs.map((ref) => ref.path);

    const prevGroupPaths = prevGroupRefs.map((ref) => ref.path);
    const currGroupPaths = currGroupRefs.map((ref) => ref.path);

    const newUserRefs = currUserRefs.filter(
      (ref) => !prevUserPaths.includes(ref.path),
    );
    const newGroupRefs = currGroupRefs.filter(
      (ref) => !prevGroupPaths.includes(ref.path),
    );

    if (newUserRefs.length === 0 && newGroupRefs.length === 0) return;

    const [userDocs, groupDocs] = await Promise.all([
      Promise.all(currUserRefs.map((ref) => ref.get())),
      Promise.all(currGroupRefs.map((ref) => ref.get())),
    ]);

    const allUsers = userDocs.map((doc) => ({ id: doc.id, ...doc.data() }));
    const allGroups = groupDocs.map((doc) => ({ id: doc.id, ...doc.data() }));

    for (const user of allUsers) {
      if (!user.interests || !user.arrivedAt || user.isInGroup) continue;

      const userWaitMinutes = (Date.now() - user.arrivedAt.toMillis()) / 60000;

      let userThreshold = 0.75;
      if (currUserRefs.length < 5) userThreshold -= 0.05;
      if (userWaitMinutes > 5) userThreshold -= 0.05;
      if (userWaitMinutes > 10) userThreshold -= 0.1;
      if (user.subscription) userThreshold -= 0.05;
      userThreshold = Math.max(userThreshold, 0.2);

      let bestGroup = null;
      let bestScore = 0;

      for (const group of allGroups) {
        if (
          !group.interests ||
          group.matchedWith?.includes(user.id) ||
          group.memberUserIds?.includes(user.id)
        )
          continue;

        const groupWaitMinutes =
          (Date.now() - group.createdAt.toMillis()) / 60000;

        let groupThreshold = 0.75;
        if (currGroupRefs.length < 5) groupThreshold -= 0.05;
        if (groupWaitMinutes > 5) groupThreshold -= 0.05;
        if (groupWaitMinutes > 10) groupThreshold -= 0.1;
        if (group.subscription) groupThreshold -= 0.05;
        groupThreshold = Math.max(groupThreshold, 0.2);

        const threshold = Math.min(userThreshold, groupThreshold);

        const shared = user.interests.filter((i) =>
          group.interests.includes(i),
        );
        const total = new Set([...user.interests, ...group.interests]).size;
        const score = shared.length / total;

        const adjustedScore =
          score +
          (user.subscription ? 0.05 : 0) +
          (group.subscription ? 0.05 : 0);

        if (adjustedScore > bestScore && adjustedScore >= threshold) {
          bestScore = adjustedScore;
          bestGroup = group;
        }
      }

      if (bestGroup) {
        await db.collection("matches").add({
          userId: db.doc(`users/${user.id}`),
          groupId: db.doc(`groups/${bestGroup.id}`),
          venueId: db.doc(`venues/${venueId}`),
          userName: user.displayName || "",
          groupName: bestGroup.name || "",
          status: "pending",
          timestamp: admin.firestore.FieldValue.serverTimestamp(),
          matchStrength: bestScore,
          fallback: true,
        });

        await db.doc(`users/${user.id}`).update({
          matchedWith: admin.firestore.FieldValue.arrayUnion(bestGroup.id),
        });
        await db.doc(`groups/${bestGroup.id}`).update({
          matchedWith: admin.firestore.FieldValue.arrayUnion(user.id),
        });
      }
    }

    return null;
  });
