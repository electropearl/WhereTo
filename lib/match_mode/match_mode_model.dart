import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'match_mode_widget.dart' show MatchModeWidget;
import 'package:flutter/material.dart';

class MatchModeModel extends FlutterFlowModel<MatchModeWidget> {
  ///  Local state fields for this page.

  List<MatchesRecord> matches = [];
  void addToMatches(MatchesRecord item) => matches.add(item);
  void removeFromMatches(MatchesRecord item) => matches.remove(item);
  void removeAtIndexFromMatches(int index) => matches.removeAt(index);
  void insertAtIndexInMatches(int index, MatchesRecord item) =>
      matches.insert(index, item);
  void updateMatchesAtIndex(int index, Function(MatchesRecord) updateFn) =>
      matches[index] = updateFn(matches[index]);

  MatchesRecord? currentMatch;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in MatchMode widget.
  List<MatchesRecord>? yourmatches;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
