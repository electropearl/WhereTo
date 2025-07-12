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

Future<void> startBackgroundLocationServices(
  DocumentReference userRef,
  Future Function(LatLng userLatLng, DocumentReference userRef)
      updateVenuePresenceAction,
) async {
  // Add your function code here!
  bg.BackgroundGeolocation.onLocation((bg.Location location) async {
    final lat = location.coords.latitude;
    final lng = location.coords.longitude;
    final userLatLng = latlong.LatLng(lat, lng);

    // 🔁 Call the passed-in Firestore logic
    await updateVenuePresenceAction(
      userLatLng as LatLng,
      userRef,
    );
  });

  // Configure and start background location tracking
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
