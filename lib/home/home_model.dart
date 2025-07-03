import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'home_widget.dart' show HomeWidget;
import 'package:flutter/material.dart';

class HomeModel extends FlutterFlowModel<HomeWidget> {
  ///  Local state fields for this page.

  bool heart = true;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in Home widget.
  List<VenuesRecord>? venueQuery;
  // Stores action output result for [Backend Call - API (FetchVenues)] action in IconButton widget.
  ApiCallResponse? apiResult24d;
  // Stores action output result for [Backend Call - API (FetchPlaceDetails)] action in IconButton widget.
  ApiCallResponse? apiResultxki;
  // Stores action output result for [Firestore Query - Query a collection] action in IconButton widget.
  VenuesRecord? docExist;
  // Stores action output result for [Custom Action - convertToGeoPoint] action in IconButton widget.
  LatLng? locationLatLng;
  // Stores action output result for [Backend Call - Create Document] action in IconButton widget.
  VenuesRecord? documentID;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
