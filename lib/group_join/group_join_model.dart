import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'group_join_widget.dart' show GroupJoinWidget;
import 'package:flutter/material.dart';

class GroupJoinModel extends FlutterFlowModel<GroupJoinWidget> {
  ///  Local state fields for this page.

  List<DocumentReference> friendsInvited = [];
  void addToFriendsInvited(DocumentReference item) => friendsInvited.add(item);
  void removeFromFriendsInvited(DocumentReference item) =>
      friendsInvited.remove(item);
  void removeAtIndexFromFriendsInvited(int index) =>
      friendsInvited.removeAt(index);
  void insertAtIndexInFriendsInvited(int index, DocumentReference item) =>
      friendsInvited.insert(index, item);
  void updateFriendsInvitedAtIndex(
          int index, Function(DocumentReference) updateFn) =>
      friendsInvited[index] = updateFn(friendsInvited[index]);

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Stores action output result for [Bottom Sheet - inviteFriend] action in Container widget.
  List<DocumentReference>? friends;
  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController;
  List<String>? get choiceChipsValues => choiceChipsValueController?.value;
  set choiceChipsValues(List<String>? val) =>
      choiceChipsValueController?.value = val;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  GroupsRecord? group;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
