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

Future<void> initializeVenueData() async {
  final firestore = FirebaseFirestore.instance;
  final venueSnaps = await firestore.collection('venues').get();

  for (final venueDoc in venueSnaps.docs) {
    final data = venueDoc.data();

    // Set default fields if they are missing
    final updates = <String, dynamic>{};

    if (!data.containsKey('location')) {
      updates['location'] = const GeoPoint(0, 0);
    }
    if (!data.containsKey('usersHereNow')) {
      updates['usersHereNow'] = <DocumentReference>[];
    }
    if (!data.containsKey('groupsHereNow')) {
      updates['groupsHereNow'] = <DocumentReference>[];
    }

    // Apply any missing field updates
    if (updates.isNotEmpty) {
      await venueDoc.reference.update(updates);
    }

    // Ensure subcollections exist
    final subcollections = [
      'interestedDaily',
      'interestWeekly',
      'interestMonthly',
      'specials'
    ];

    for (final sub in subcollections) {
      final subSnap = await venueDoc.reference.collection(sub).limit(1).get();
      if (subSnap.docs.isEmpty) {
        await venueDoc.reference.collection(sub).add({'initialized': true});
      }
    }
  }

  print('✅ Venue documents and subcollections initialized.');
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
