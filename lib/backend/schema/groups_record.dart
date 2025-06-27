import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class GroupsRecord extends FirestoreRecord {
  GroupsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "groupId" field.
  String? _groupId;
  String get groupId => _groupId ?? '';
  bool hasGroupId() => _groupId != null;

  // "memberUserIds" field.
  List<DocumentReference>? _memberUserIds;
  List<DocumentReference> get memberUserIds => _memberUserIds ?? const [];
  bool hasMemberUserIds() => _memberUserIds != null;

  // "location" field.
  LatLng? _location;
  LatLng? get location => _location;
  bool hasLocation() => _location != null;

  // "geoHash" field.
  String? _geoHash;
  String get geoHash => _geoHash ?? '';
  bool hasGeoHash() => _geoHash != null;

  // "groupSize" field.
  int? _groupSize;
  int get groupSize => _groupSize ?? 0;
  bool hasGroupSize() => _groupSize != null;

  // "dynamicLabels" field.
  List<DocumentReference>? _dynamicLabels;
  List<DocumentReference> get dynamicLabels => _dynamicLabels ?? const [];
  bool hasDynamicLabels() => _dynamicLabels != null;

  // "createdAt" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "groupVibe" field.
  List<String>? _groupVibe;
  List<String> get groupVibe => _groupVibe ?? const [];
  bool hasGroupVibe() => _groupVibe != null;

  // "groupOwner" field.
  DocumentReference? _groupOwner;
  DocumentReference? get groupOwner => _groupOwner;
  bool hasGroupOwner() => _groupOwner != null;

  // "groupName" field.
  String? _groupName;
  String get groupName => _groupName ?? '';
  bool hasGroupName() => _groupName != null;

  // "Dynamic" field.
  String? _dynamic;
  String get dynamic => _dynamic ?? '';
  bool hasDynamic() => _dynamic != null;

  // "venue" field.
  DocumentReference? _venue;
  DocumentReference? get venue => _venue;
  bool hasVenue() => _venue != null;

  void _initializeFields() {
    _groupId = snapshotData['groupId'] as String?;
    _memberUserIds = getDataList(snapshotData['memberUserIds']);
    _location = snapshotData['location'] as LatLng?;
    _geoHash = snapshotData['geoHash'] as String?;
    _groupSize = castToType<int>(snapshotData['groupSize']);
    _dynamicLabels = getDataList(snapshotData['dynamicLabels']);
    _createdAt = snapshotData['createdAt'] as DateTime?;
    _groupVibe = getDataList(snapshotData['groupVibe']);
    _groupOwner = snapshotData['groupOwner'] as DocumentReference?;
    _groupName = snapshotData['groupName'] as String?;
    _dynamic = snapshotData['Dynamic'] as String?;
    _venue = snapshotData['venue'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('groups');

  static Stream<GroupsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => GroupsRecord.fromSnapshot(s));

  static Future<GroupsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => GroupsRecord.fromSnapshot(s));

  static GroupsRecord fromSnapshot(DocumentSnapshot snapshot) => GroupsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static GroupsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      GroupsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'GroupsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is GroupsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createGroupsRecordData({
  String? groupId,
  LatLng? location,
  String? geoHash,
  int? groupSize,
  DateTime? createdAt,
  DocumentReference? groupOwner,
  String? groupName,
  String? dynamic,
  DocumentReference? venue,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'groupId': groupId,
      'location': location,
      'geoHash': geoHash,
      'groupSize': groupSize,
      'createdAt': createdAt,
      'groupOwner': groupOwner,
      'groupName': groupName,
      'Dynamic': dynamic,
      'venue': venue,
    }.withoutNulls,
  );

  return firestoreData;
}

class GroupsRecordDocumentEquality implements Equality<GroupsRecord> {
  const GroupsRecordDocumentEquality();

  @override
  bool equals(GroupsRecord? e1, GroupsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.groupId == e2?.groupId &&
        listEquality.equals(e1?.memberUserIds, e2?.memberUserIds) &&
        e1?.location == e2?.location &&
        e1?.geoHash == e2?.geoHash &&
        e1?.groupSize == e2?.groupSize &&
        listEquality.equals(e1?.dynamicLabels, e2?.dynamicLabels) &&
        e1?.createdAt == e2?.createdAt &&
        listEquality.equals(e1?.groupVibe, e2?.groupVibe) &&
        e1?.groupOwner == e2?.groupOwner &&
        e1?.groupName == e2?.groupName &&
        e1?.dynamic == e2?.dynamic &&
        e1?.venue == e2?.venue;
  }

  @override
  int hash(GroupsRecord? e) => const ListEquality().hash([
        e?.groupId,
        e?.memberUserIds,
        e?.location,
        e?.geoHash,
        e?.groupSize,
        e?.dynamicLabels,
        e?.createdAt,
        e?.groupVibe,
        e?.groupOwner,
        e?.groupName,
        e?.dynamic,
        e?.venue
      ]);

  @override
  bool isValidKey(Object? o) => o is GroupsRecord;
}
