import '/flutter_flow/flutter_flow_util.dart';
import 'invite_friend_widget.dart' show InviteFriendWidget;
import 'package:flutter/material.dart';

class InviteFriendModel extends FlutterFlowModel<InviteFriendWidget> {
  ///  Local state fields for this component.

  List<DocumentReference> friendsInvite = [];
  void addToFriendsInvite(DocumentReference item) => friendsInvite.add(item);
  void removeFromFriendsInvite(DocumentReference item) =>
      friendsInvite.remove(item);
  void removeAtIndexFromFriendsInvite(int index) =>
      friendsInvite.removeAt(index);
  void insertAtIndexInFriendsInvite(int index, DocumentReference item) =>
      friendsInvite.insert(index, item);
  void updateFriendsInviteAtIndex(
          int index, Function(DocumentReference) updateFn) =>
      friendsInvite[index] = updateFn(friendsInvite[index]);

  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  // State field(s) for Checkbox widget.
  Map<DocumentReference, bool> checkboxValueMap = {};
  List<DocumentReference> get checkboxCheckedItems =>
      checkboxValueMap.entries.where((e) => e.value).map((e) => e.key).toList();

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    textFieldFocusNode2?.dispose();
    textController2?.dispose();
  }
}
