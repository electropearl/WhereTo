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

import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
    as bg;
import 'package:latlong2/latlong.dart' as latlong;

Future<void> startAndTrackVenuePresence(DocumentReference userRef) async {
  final firestore = FirebaseFirestore.instance;
  final status = await bg.BackgroundGeolocation.requestPermission();

  if (status == bg.ProviderChangeEvent.AUTHORIZATION_STATUS_DENIED) {
    print('❌ Location permission denied');
    return;
  }

  bg.BackgroundGeolocation.onLocation((bg.Location location) async {
    final lat = location.coords.latitude;
    final lng = location.coords.longitude;
    final userLatLng = latlong.LatLng(lat, lng);

    final userDocSnap = await userRef.get();
    if (!userDocSnap.exists) return;
    final userData = userDocSnap.data() as Map<String, dynamic>;
    final currentVenueRef = userData['currentVenue'] as DocumentReference?;
    DocumentReference? matchedVenueRef;

    final venueSnaps = await firestore.collection('venues').get();
    for (var doc in venueSnaps.docs) {
      final venueData = doc.data();
      final venueGeo = venueData['location'] as GeoPoint?;
      if (venueGeo == null) continue;

      final venueLatLng = latlong.LatLng(venueGeo.latitude, venueGeo.longitude);
      final distance = const latlong.Distance().as(
        latlong.LengthUnit.Meter,
        userLatLng,
        venueLatLng,
      );

      if (distance <= 50) {
        matchedVenueRef = doc.reference;

        final usersHereNow = (venueData['usersHereNow'] as List?)
                ?.whereType<DocumentReference>()
                .toList() ??
            [];

        if (!usersHereNow.any((ref) => ref.id == userRef.id)) {
          usersHereNow.add(userRef);
          await doc.reference
              .set({'usersHereNow': usersHereNow}, SetOptions(merge: true));
        }

        if (currentVenueRef?.id != matchedVenueRef.id) {
          await userRef
              .set({'currentVenue': matchedVenueRef}, SetOptions(merge: true));
        }
        break;
      }
    }

    if (matchedVenueRef == null && currentVenueRef != null) {
      final prevVenueSnap = await currentVenueRef.get();
      if (prevVenueSnap.exists) {
        final prevUsers = (prevVenueSnap['usersHereNow'] as List?)
                ?.whereType<DocumentReference>()
                .toList() ??
            [];
        prevUsers.removeWhere((ref) => ref.id == userRef.id);
        await currentVenueRef.update({'usersHereNow': prevUsers});
      }
      await userRef.update({'currentVenue': FieldValue.delete()});
    }

    final groupSnaps = await firestore.collection('groups').get();
    for (var groupDoc in groupSnaps.docs) {
      final groupData = groupDoc.data();
      final memberRefs = (groupData['memberUserIds'] as List?)
              ?.whereType<DocumentReference>()
              .toList() ??
          [];
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

      await groupDoc.reference.set(
          {'MembersAtCurrentVenue': membersAtVenue}, SetOptions(merge: true));

      if (matchedVenueRef != null) {
        final venueSnap = await matchedVenueRef.get();
        if (!venueSnap.exists) continue;
        final venueGroups = (venueSnap['groupsHereNow'] as List?)
                ?.whereType<DocumentReference>()
                .toList() ??
            [];
        final groupRef = groupDoc.reference;

        if (membersAtVenue.length >= 2) {
          if (!venueGroups.any((ref) => ref.id == groupRef.id)) {
            venueGroups.add(groupRef);
            await matchedVenueRef
                .set({'groupsHereNow': venueGroups}, SetOptions(merge: true));
          }
        } else {
          if (venueGroups.any((ref) => ref.id == groupRef.id)) {
            venueGroups.removeWhere((ref) => ref.id == groupRef.id);
            await matchedVenueRef
                .set({'groupsHereNow': venueGroups}, SetOptions(merge: true));
          }
        }
      }
    }
  });

  await bg.BackgroundGeolocation.ready(bg.Config(
    desiredAccuracy: bg.Config.DESIRED_ACCURACY_HIGH,
    distanceFilter: 20,
    stopOnTerminate: false,
    startOnBoot: true,
    debug: false,
    logLevel: bg.Config.LOG_LEVEL_OFF,
    enableHeadless: true,
    showsBackgroundLocationIndicator: false,
    locationAuthorizationRequest: 'Always',
  )).then((bg.State state) {
    if (!state.enabled) {
      bg.BackgroundGeolocation.start();
    }
  });
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
