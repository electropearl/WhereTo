// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
    as bg;

Future<void> startListeningToGeofenceEventsWithGroupSupport() async {
  bg.BackgroundGeolocation.onGeofence((bg.GeofenceEvent event) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    final venueId = event.identifier;
    final userRef = FirebaseFirestore.instance.doc('users/$userId');
    final venueRef = FirebaseFirestore.instance.doc('venues/$venueId');

    final userDoc = await userRef.get();
    final groupRef = userDoc.data()?['currentGroup'] as DocumentReference?;

    if (event.action == 'ENTER') {
      await userRef.update({
        'currentVenue': venueRef,
        'arrivedAt': FieldValue.serverTimestamp(),
      });

      await venueRef.update({
        'usersHereNow': FieldValue.arrayUnion([userRef]),
      });

      if (groupRef != null) {
        final groupDoc = await groupRef.get();
        final groupData = groupDoc.data() as Map<String, dynamic>?;
        final List<dynamic> memberIds = groupData?['memberUserIds'] ?? [];

        bool allAtVenue = true;
        for (final memberId in memberIds) {
          final memberDoc =
              await FirebaseFirestore.instance.doc('users/$memberId').get();
          final memberData = memberDoc.data();
          final memberVenue = memberData?['currentVenue'] as DocumentReference?;
          if (memberVenue?.id != venueId) {
            allAtVenue = false;
            break;
          }
        }

        if (allAtVenue) {
          await venueRef.update({
            'groupsHereNow': FieldValue.arrayUnion([groupRef]),
          });
        }
      }
    }

    if (event.action == 'EXIT') {
      await userRef.update({
        'currentVenue': null,
      });

      await venueRef.update({
        'usersHereNow': FieldValue.arrayRemove([userRef]),
      });

      if (groupRef != null) {
        final groupDoc = await groupRef.get();
        final groupData = groupDoc.data() as Map<String, dynamic>?;
        final List<dynamic> memberIds = groupData?['memberUserIds'] ?? [];

        bool stillAtVenue = false;
        for (final memberId in memberIds) {
          final memberDoc =
              await FirebaseFirestore.instance.doc('users/$memberId').get();
          final memberData = memberDoc.data();
          final memberVenue = memberData?['currentVenue'] as DocumentReference?;
          if (memberVenue?.id == venueId) {
            stillAtVenue = true;
            break;
          }
        }

        if (!stillAtVenue) {
          await venueRef.update({
            'groupsHereNow': FieldValue.arrayRemove([groupRef]),
          });
        }
      }
    }
  });
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
