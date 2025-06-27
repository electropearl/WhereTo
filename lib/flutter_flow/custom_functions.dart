import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/auth/firebase_auth/auth_util.dart';

List<VenuesRecord> sortVenuesByDistanceToUser(
  List<VenuesRecord> venues,
  LatLng userLocation,
  double savedDistanceMiles,
) {
  double calculateDistance(LatLng a, LatLng b) {
    const int earthRadius = 6371000;
    double radians(double degrees) => degrees * math.pi / 180;

    final double lat1 = radians(a.latitude);
    final double lat2 = radians(b.latitude);
    final double deltaLat = radians(b.latitude - a.latitude);
    final double deltaLng = radians(b.longitude - a.longitude);

    final double innerCalc = math.sin(deltaLat / 2) * math.sin(deltaLat / 2) +
        math.cos(lat1) *
            math.cos(lat2) *
            math.sin(deltaLng / 2) *
            math.sin(deltaLng / 2);

    final double c =
        2 * math.atan2(math.sqrt(innerCalc), math.sqrt(1 - innerCalc));
    return earthRadius * c;
  }

  final List<MapEntry<VenuesRecord, double>> venueWithDistances = [];

  for (final venue in venues) {
    if (venue.location == null) continue;

    final double distInMeters =
        calculateDistance(userLocation, venue.location!);
    final double distInMiles = distInMeters / 1609.34;

    if (distInMiles <= savedDistanceMiles) {
      venueWithDistances.add(MapEntry(venue, distInMiles));
    }
  }

  // Sort by distance
  venueWithDistances.sort((a, b) => a.value.compareTo(b.value));

  // Return sorted venues only
  return venueWithDistances.map((entry) => entry.key).toList();
}

String? distanceBetweenPoints(
  LatLng point1,
  LatLng point2,
) {
  const int earthRadius = 6371000;

  double radians(double degrees) {
    return degrees * math.pi / 180;
  }

  final double lat1 = radians(point1.latitude);
  final double lat2 = radians(point2.latitude);
  final double deltaLat = radians(point2.latitude - point1.latitude);
  final double deltaLng = radians(point2.longitude - point1.longitude);

  final double a = math.sin(deltaLat / 2) * math.sin(deltaLat / 2) +
      math.cos(lat1) *
          math.cos(lat2) *
          math.sin(deltaLng / 2) *
          math.sin(deltaLng / 2);
  final double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
  final double distanceInMeters = earthRadius * c;

  final double distanceInMiles = distanceInMeters / 1609.344;
  NumberFormat formatter = NumberFormat('###.## mi');
  return formatter.format(distanceInMiles);
}

DateTime startOfDay(DateTime date) {
  return DateTime(date.year, date.month, date.day, 2);
}

DateTime endOfDay(DateTime date) {
  final tomorrow = date.add(Duration(days: 1));
  return DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 1, 59, 59, 999);
}

bool ageCheck(DateTime? dateOfBirth) {
  if (dateOfBirth == null) {
    return false; // No date selected
  }

  final today = DateTime.now();
  int age = today.year - dateOfBirth.year;

  if (today.month < dateOfBirth.month ||
      (today.month == dateOfBirth.month && today.day < dateOfBirth.day)) {
    age--;
  }

  return age >= 18;
}
