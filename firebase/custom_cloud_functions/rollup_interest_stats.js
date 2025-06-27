const functions = require("firebase-functions");
const admin = require("firebase-admin");
// To avoid deployment errors, do not call admin.initializeApp() in your code

const db = admin.firestore();

exports.rollupInterestStats = functions.pubsub
  .schedule("0 2 * * *") // Every day at 2:00 AM
  .timeZone("America/Chicago") // Adjust to your local time zone
  .onRun(async (context) => {
    const venuesSnapshot = await db.collection("venues").get();

    const now = new Date();
    const todayStart = new Date(
      now.getFullYear(),
      now.getMonth(),
      now.getDate(),
      2,
    ); // 2 AM today
    const weekStart = new Date(now);
    weekStart.setDate(now.getDate() - now.getDay() + 1); // Monday
    weekStart.setHours(0, 0, 0, 0);
    const monthStart = new Date(now.getFullYear(), now.getMonth(), 1);

    for (const venueDoc of venuesSnapshot.docs) {
      const venueRef = venueDoc.ref;

      const dailyQuery = await venueRef
        .collection("interestedDaily")
        .where("dateTime", ">=", admin.firestore.Timestamp.fromDate(todayStart))
        .orderBy("dateTime", "desc")
        .limit(1)
        .get();

      if (dailyQuery.empty) continue;

      const dailyDoc = dailyQuery.docs[0];
      const interestCount = dailyDoc.get("totalInterestToday") || 0;

      // WEEKLY
      const weeklyRef = venueRef.collection("interestWeekly");
      const weeklyQuery = await weeklyRef
        .where("dateTime", "==", admin.firestore.Timestamp.fromDate(weekStart))
        .limit(1)
        .get();

      if (!weeklyQuery.empty) {
        await weeklyQuery.docs[0].ref.update({
          numberOfInterest: admin.firestore.FieldValue.increment(interestCount),
        });
      } else {
        await weeklyRef.add({
          dateTime: admin.firestore.Timestamp.fromDate(weekStart),
          numberOfInterest: interestCount,
        });
      }

      // MONTHLY
      const monthlyRef = venueRef.collection("interestMonthly");
      const monthlyQuery = await monthlyRef
        .where("dateTime", "==", admin.firestore.Timestamp.fromDate(monthStart))
        .limit(1)
        .get();

      if (!monthlyQuery.empty) {
        await monthlyQuery.docs[0].ref.update({
          numberOfInterest: admin.firestore.FieldValue.increment(interestCount),
        });
      } else {
        await monthlyRef.add({
          dateTime: admin.firestore.Timestamp.fromDate(monthStart),
          numberOfInterest: interestCount,
        });
      }

      // NEW DAILY DOC
      await venueRef.collection("interestedDaily").add({
        dateTime: admin.firestore.Timestamp.fromDate(todayStart),
        totalInterestToday: 0,
        peopleList: [],
      });
    }

    console.log("Interest rollup complete at", new Date().toISOString());
    return null;
  });
