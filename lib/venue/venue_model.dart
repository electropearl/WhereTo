import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'venue_widget.dart' show VenueWidget;
import 'package:flutter/material.dart';

class VenueModel extends FlutterFlowModel<VenueWidget> {
  ///  Local state fields for this page.

  List<DocumentReference> peopleHereNow = [];
  void addToPeopleHereNow(DocumentReference item) => peopleHereNow.add(item);
  void removeFromPeopleHereNow(DocumentReference item) =>
      peopleHereNow.remove(item);
  void removeAtIndexFromPeopleHereNow(int index) =>
      peopleHereNow.removeAt(index);
  void insertAtIndexInPeopleHereNow(int index, DocumentReference item) =>
      peopleHereNow.insert(index, item);
  void updatePeopleHereNowAtIndex(
          int index, Function(DocumentReference) updateFn) =>
      peopleHereNow[index] = updateFn(peopleHereNow[index]);

  List<DocumentReference> groupsHerenow = [];
  void addToGroupsHerenow(DocumentReference item) => groupsHerenow.add(item);
  void removeFromGroupsHerenow(DocumentReference item) =>
      groupsHerenow.remove(item);
  void removeAtIndexFromGroupsHerenow(int index) =>
      groupsHerenow.removeAt(index);
  void insertAtIndexInGroupsHerenow(int index, DocumentReference item) =>
      groupsHerenow.insert(index, item);
  void updateGroupsHerenowAtIndex(
          int index, Function(DocumentReference) updateFn) =>
      groupsHerenow[index] = updateFn(groupsHerenow[index]);

  VenuesRecord? venueDetails;

  String? pageRebuild;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  InterestedDailyRecord? interstedUsers;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  List<InterestedDailyRecord>? interstedUsers2;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  InterestedDailyRecord? interestRef2;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  InterestedDailyRecord? interestRef;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  InterestedDailyRecord? interestRefOther;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  /// Action blocks.
  Future animatebutton(BuildContext context) async {
    logFirebaseEvent('animatebutton_update_page_state');
    pageRebuild = 'load';
  }
}
