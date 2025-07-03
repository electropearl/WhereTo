import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'group_management_widget.dart' show GroupManagementWidget;
import 'package:flutter/material.dart';

class GroupManagementModel extends FlutterFlowModel<GroupManagementWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in groupManagement widget.
  List<GroupInvitesRecord>? newInvites;
  // Stores action output result for [Firestore Query - Query a collection] action in groupManagement widget.
  List<GroupsRecord>? groupsQuery;
  // Stores action output result for [Bottom Sheet - inviteFriend] action in Container widget.
  List<DocumentReference>? friendsAdded;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
