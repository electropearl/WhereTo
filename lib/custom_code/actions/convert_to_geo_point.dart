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

Future<LatLng> convertToGeoPoint(
  String? latitude,
  String? longitude,
) async {
  // Add your function code here!
  // Check if latitude or longitude is null
  if (latitude == null || longitude == null) {
    throw Exception("Latitude or Longitude cannot be null");
  }

  // Convert String to double
  double? lat = double.tryParse(latitude);
  double? lng = double.tryParse(longitude);

  // Validate conversion success
  if (lat == null || lng == null) {
    throw Exception("Invalid latitude or longitude values");
  }

  // Return LatLng object
  return LatLng(lat, lng);
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
