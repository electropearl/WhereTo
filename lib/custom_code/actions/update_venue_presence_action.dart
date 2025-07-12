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

import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart' as latlong;

Future<void> updateVenuePresenceAction(
  LatLng userLocation,
  DocumentReference userRef,
) async {
  final firestore = FirebaseFirestore.instance;

  final userDocSnap = await userRef.get();
  if (!userDocSnap.exists) return;

  final userData = userDocSnap.data() as Map<String, dynamic>;
  final currentVenueRef = userData['currentVenue'] as DocumentReference?;
  final userGeo = latlong.LatLng(userLocation.latitude, userLocation.longitude);

  final venueSnaps = await firestore.collection('venues').get();
  DocumentReference? matchedVenueRef;

  for (var doc in venueSnaps.docs) {
    final venueData = doc.data();
    final venueGeo = venueData['location']?.geoPoint;
    if (venueGeo == null) continue;

    final venueLatLng = latlong.LatLng(venueGeo.latitude, venueGeo.longitude);
    final distance = const latlong.Distance().as(
      latlong.LengthUnit.Meter,
      userGeo,
      venueLatLng,
    );

    if (distance <= 50) {
      matchedVenueRef = doc.reference;

      // Add user to venue.usersHereNow if not already
      final usersHereNow =
          List<DocumentReference>.from(venueData['usersHereNow'] ?? []);
      if (!usersHereNow.contains(userRef)) {
        usersHereNow.add(userRef);
        await doc.reference.update({'usersHereNow': usersHereNow});
      }

      // Update user's currentVenue
      if (currentVenueRef?.id != matchedVenueRef.id) {
        await userRef.update({'currentVenue': matchedVenueRef});
      }
      break;
    }
  }

  // If user left all venues
  if (matchedVenueRef == null && currentVenueRef != null) {
    final prevVenueSnap = await currentVenueRef.get();
    if (prevVenueSnap.exists) {
      final prevUsers =
          List<DocumentReference>.from(prevVenueSnap['usersHereNow'] ?? []);
      prevUsers.removeWhere((ref) => ref.id == userRef.id);
      await currentVenueRef.update({'usersHereNow': prevUsers});
    }

    await userRef.update({'currentVenue': FieldValue.delete()});
  }

  /// GROUP PRESENCE TRACKING
  final groupSnaps = await firestore.collection('groups').get();
  for (var groupDoc in groupSnaps.docs) {
    final groupData = groupDoc.data();
    final memberRefs =
        List<DocumentReference>.from(groupData['memberUserIds'] ?? []);
    final membersAtVenue = <DocumentReference>[];

    for (var memberRef in memberRefs) {
      final memberSnap = await memberRef.get();
      if (!memberSnap.exists) continue;

      final memberData = memberSnap.data() as Map<String, dynamic>;
      final venueRef = memberData['currentVenue'] as DocumentReference?;
      if (venueRef != null &&
          matchedVenueRef != null &&
          venueRef.id == matchedVenueRef.id) {
        membersAtVenue.add(memberRef);
      }
    }

    await groupDoc.reference.update({'MembersAtCurrentVenue': membersAtVenue});

    if (matchedVenueRef != null) {
      final venueSnap = await matchedVenueRef.get();
      if (!venueSnap.exists) continue;

      final venueGroups =
          List<DocumentReference>.from(venueSnap['groupsHereNow'] ?? []);
      final groupRef = groupDoc.reference;

      if (membersAtVenue.length >= 2) {
        if (!venueGroups.contains(groupRef)) {
          venueGroups.add(groupRef);
          await matchedVenueRef.update({'groupsHereNow': venueGroups});
        }
      } else {
        if (venueGroups.contains(groupRef)) {
          venueGroups.removeWhere((ref) => ref.id == groupRef.id);
          await matchedVenueRef.update({'groupsHereNow': venueGroups});
        }
      }
    }
  }
}
