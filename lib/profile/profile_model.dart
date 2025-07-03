import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'profile_widget.dart' show ProfileWidget;
import 'package:flutter/material.dart';

class ProfileModel extends FlutterFlowModel<ProfileWidget> {
  ///  Local state fields for this page.

  int? current = 0;

  dynamic currentItem;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (FetchVenues)] action in Container widget.
  ApiCallResponse? apiResult24db2;
  // Stores action output result for [Backend Call - API (FetchPlaceDetails)] action in Container widget.
  ApiCallResponse? apiResultxki22;
  // Stores action output result for [Firestore Query - Query a collection] action in Container widget.
  VenuesRecord? docExist2;
  // Stores action output result for [Custom Action - convertToGeoPoint] action in Container widget.
  LatLng? locationLatLng;
  // Stores action output result for [Backend Call - Create Document] action in Container widget.
  VenuesRecord? documentID;
  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
