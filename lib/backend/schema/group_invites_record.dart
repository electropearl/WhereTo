import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class GroupInvitesRecord extends FirestoreRecord {
  GroupInvitesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "groupRef" field.
  DocumentReference? _groupRef;
  DocumentReference? get groupRef => _groupRef;
  bool hasGroupRef() => _groupRef != null;

  // "groupName" field.
  String? _groupName;
  String get groupName => _groupName ?? '';
  bool hasGroupName() => _groupName != null;

  // "senderRef" field.
  DocumentReference? _senderRef;
  DocumentReference? get senderRef => _senderRef;
  bool hasSenderRef() => _senderRef != null;

  // "recieverRef" field.
  DocumentReference? _recieverRef;
  DocumentReference? get recieverRef => _recieverRef;
  bool hasRecieverRef() => _recieverRef != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  // "timestamp" field.
  DateTime? _timestamp;
  DateTime? get timestamp => _timestamp;
  bool hasTimestamp() => _timestamp != null;

  void _initializeFields() {
    _groupRef = snapshotData['groupRef'] as DocumentReference?;
    _groupName = snapshotData['groupName'] as String?;
    _senderRef = snapshotData['senderRef'] as DocumentReference?;
    _recieverRef = snapshotData['recieverRef'] as DocumentReference?;
    _status = snapshotData['status'] as String?;
    _timestamp = snapshotData['timestamp'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('groupInvites');

  static Stream<GroupInvitesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => GroupInvitesRecord.fromSnapshot(s));

  static Future<GroupInvitesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => GroupInvitesRecord.fromSnapshot(s));

  static GroupInvitesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      GroupInvitesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static GroupInvitesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      GroupInvitesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'GroupInvitesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is GroupInvitesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createGroupInvitesRecordData({
  DocumentReference? groupRef,
  String? groupName,
  DocumentReference? senderRef,
  DocumentReference? recieverRef,
  String? status,
  DateTime? timestamp,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'groupRef': groupRef,
      'groupName': groupName,
      'senderRef': senderRef,
      'recieverRef': recieverRef,
      'status': status,
      'timestamp': timestamp,
    }.withoutNulls,
  );

  return firestoreData;
}

class GroupInvitesRecordDocumentEquality
    implements Equality<GroupInvitesRecord> {
  const GroupInvitesRecordDocumentEquality();

  @override
  bool equals(GroupInvitesRecord? e1, GroupInvitesRecord? e2) {
    return e1?.groupRef == e2?.groupRef &&
        e1?.groupName == e2?.groupName &&
        e1?.senderRef == e2?.senderRef &&
        e1?.recieverRef == e2?.recieverRef &&
        e1?.status == e2?.status &&
        e1?.timestamp == e2?.timestamp;
  }

  @override
  int hash(GroupInvitesRecord? e) => const ListEquality().hash([
        e?.groupRef,
        e?.groupName,
        e?.senderRef,
        e?.recieverRef,
        e?.status,
        e?.timestamp
      ]);

  @override
  bool isValidKey(Object? o) => o is GroupInvitesRecord;
}
