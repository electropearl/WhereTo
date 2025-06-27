const functions = require("firebase-functions");
const admin = require("firebase-admin");
// To avoid deployment errors, do not call admin.initializeApp() in your code
const { v4: uuidv4 } = require("uuid");
const fetch = require("node-fetch");
const path = require("path");

const db = admin.firestore();
const storage = admin.storage();

exports.backupVenueImage = functions.firestore
  .document("venues/{venueId}")
  .onCreate(async (snap, context) => {
    const venueData = snap.data();
    const venueId = context.params.venueId;

    if (!venueData.photoUrl) {
      console.log("No photoUrl provided.");
      return null;
    }

    try {
      const response = await fetch(venueData.photoUrl);
      if (!response.ok)
        throw new Error(`Failed to fetch image: ${response.statusText}`);

      const contentType = response.headers.get("content-type");
      const ext = contentType.split("/")[1] || "jpg";
      const buffer = await response.buffer();

      const fileName = `venue_photos/${venueId}_${uuidv4()}.${ext}`;
      const file = storage.bucket().file(fileName);

      await file.save(buffer, {
        metadata: {
          contentType,
          metadata: {
            firebaseStorageDownloadTokens: uuidv4(),
          },
        },
      });

      const downloadURL = `https://firebasestorage.googleapis.com/v0/b/${file.bucket.name}/o/${encodeURIComponent(file.name)}?alt=media`;

      await db.collection("venues").doc(venueId).update({
        photoUrl: downloadURL,
      });

      console.log(`Uploaded and replaced photoUrl for venue ${venueId}`);
      return true;
    } catch (error) {
      console.error(`Failed to back up image for venue ${venueId}:`, error);
      return null;
    }
  });
