const admin = require("firebase-admin/app");
admin.initializeApp();

const rollupInterestStats = require("./rollup_interest_stats.js");
exports.rollupInterestStats = rollupInterestStats.rollupInterestStats;
const backupVenueImage = require("./backup_venue_image.js");
exports.backupVenueImage = backupVenueImage.backupVenueImage;
const userMatchmaking = require("./user_matchmaking.js");
exports.userMatchmaking = userMatchmaking.userMatchmaking;
const groupMatchmaking = require("./group_matchmaking.js");
exports.groupMatchmaking = groupMatchmaking.groupMatchmaking;
const userGroupFallbackMatchmaking = require("./user_group_fallback_matchmaking.js");
exports.userGroupFallbackMatchmaking =
  userGroupFallbackMatchmaking.userGroupFallbackMatchmaking;
