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
import '/backend/schema/structs/index.dart';
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

  final List<VenuesRecord> filteredAndSorted = [];

  for (final venue in venues) {
    if (venue.location == null) continue;

    final double distInMeters =
        calculateDistance(userLocation, venue.location!);
    final double distInMiles = distInMeters / 1609.34;

    if (distInMiles <= savedDistanceMiles) {
      filteredAndSorted.add(venue);
    }
  }

  filteredAndSorted.sort((a, b) {
    final distA = calculateDistance(userLocation, a.location!);
    final distB = calculateDistance(userLocation, b.location!);
    return distA.compareTo(distB);
  });

  return filteredAndSorted;
}

String? distanceBetweenPoints(
  LatLng? point1,
  LatLng? point2,
) {
  String distanceBetweenPoints(LatLng point1, LatLng point2) {
    final int earthRadius = 6371000; // in meters

    // define the radians function
    double radians(double degrees) {
      return degrees * math.pi / 180;
    }

    final double lat1 = radians(point1!.latitude);
    final double lat2 = radians(point2!.latitude);
    final double deltaLat = radians(point2.latitude - point1.latitude);
    final double deltaLng = radians(point2.longitude - point1.longitude);

    final double a = math.sin(deltaLat / 2) * math.sin(deltaLat / 2) +
        math.cos(lat1) *
            math.cos(lat2) *
            math.sin(deltaLng / 2) *
            math.sin(deltaLng / 2);
    final double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    final double distanceInMeters = earthRadius * c;

    // convert the distance to miles
    final double distanceInMiles = distanceInMeters / 1609.344;

    // format the distance in miles
    NumberFormat formatter = NumberFormat('###.## mi');

    return formatter.format(distanceInMiles);
  }

  final String distanceInMiles = distanceBetweenPoints(point1!, point2!);

  return distanceInMiles;
}

DateTime startOfDay(DateTime date) {
  return DateTime(date.year, date.month, date.day, 2);
}

DateTime endOfDay(DateTime date) {
  final tomorrow = date.add(Duration(days: 1));
  return DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 1, 59, 59, 999);
}

bool ageCheck(DateTime dob) {
  final now = DateTime.now();
  final difference = now.difference(dob);
  final years = difference.inDays ~/ 365.25;

  return years >= 18;
}

double calculateBearing(
  LatLng from,
  LatLng to,
) {
  final lat1 = from.latitude * math.pi / 180;
  final lon1 = from.longitude * math.pi / 180;
  final lat2 = to.latitude * math.pi / 180;
  final lon2 = to.longitude * math.pi / 180;

  final dLon = lon2 - lon1;

  final y = math.sin(dLon) * math.cos(lat2);
  final x = math.cos(lat1) * math.sin(lat2) -
      math.sin(lat1) * math.cos(lat2) * math.cos(dLon);

  double bearing = math.atan2(y, x);
  bearing =
      (bearing * 180 / math.pi + 360) % 360; // Convert to degrees and normalize
  return bearing;
}
