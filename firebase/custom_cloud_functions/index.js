const admin = require("firebase-admin/app");
admin.initializeApp();

const rollupInterestStats = require("./rollup_interest_stats.js");
exports.rollupInterestStats = rollupInterestStats.rollupInterestStats;
const backupVenueImage = require("./backup_venue_image.js");
exports.backupVenueImage = backupVenueImage.backupVenueImage;
