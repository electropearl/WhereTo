import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MatchesRecord extends FirestoreRecord {
  MatchesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "userAId" field.
  DocumentReference? _userAId;
  DocumentReference? get userAId => _userAId;
  bool hasUserAId() => _userAId != null;

  // "userBId" field.
  DocumentReference? _userBId;
  DocumentReference? get userBId => _userBId;
  bool hasUserBId() => _userBId != null;

  // "timestamp" field.
  DateTime? _timestamp;
  DateTime? get timestamp => _timestamp;
  bool hasTimestamp() => _timestamp != null;

  // "venueId" field.
  DocumentReference? _venueId;
  DocumentReference? get venueId => _venueId;
  bool hasVenueId() => _venueId != null;

  // "compassStarted" field.
  bool? _compassStarted;
  bool get compassStarted => _compassStarted ?? false;
  bool hasCompassStarted() => _compassStarted != null;

  // "lastSafetyPingAt" field.
  DateTime? _lastSafetyPingAt;
  DateTime? get lastSafetyPingAt => _lastSafetyPingAt;
  bool hasLastSafetyPingAt() => _lastSafetyPingAt != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  // "userALoc" field.
  LatLng? _userALoc;
  LatLng? get userALoc => _userALoc;
  bool hasUserALoc() => _userALoc != null;

  // "userBLoc" field.
  LatLng? _userBLoc;
  LatLng? get userBLoc => _userBLoc;
  bool hasUserBLoc() => _userBLoc != null;

  // "userAStatus" field.
  bool? _userAStatus;
  bool get userAStatus => _userAStatus ?? false;
  bool hasUserAStatus() => _userAStatus != null;

  // "userBStatus" field.
  bool? _userBStatus;
  bool get userBStatus => _userBStatus ?? false;
  bool hasUserBStatus() => _userBStatus != null;

  // "groupAId" field.
  DocumentReference? _groupAId;
  DocumentReference? get groupAId => _groupAId;
  bool hasGroupAId() => _groupAId != null;

  // "groupBId" field.
  DocumentReference? _groupBId;
  DocumentReference? get groupBId => _groupBId;
  bool hasGroupBId() => _groupBId != null;

  // "priorityGivenTo" field.
  String? _priorityGivenTo;
  String get priorityGivenTo => _priorityGivenTo ?? '';
  bool hasPriorityGivenTo() => _priorityGivenTo != null;

  // "userAName" field.
  String? _userAName;
  String get userAName => _userAName ?? '';
  bool hasUserAName() => _userAName != null;

  // "userBName" field.
  String? _userBName;
  String get userBName => _userBName ?? '';
  bool hasUserBName() => _userBName != null;

  // "groupAName" field.
  String? _groupAName;
  String get groupAName => _groupAName ?? '';
  bool hasGroupAName() => _groupAName != null;

  // "groupBName" field.
  String? _groupBName;
  String get groupBName => _groupBName ?? '';
  bool hasGroupBName() => _groupBName != null;

  // "matchStrength" field.
  double? _matchStrength;
  double get matchStrength => _matchStrength ?? 0.0;
  bool hasMatchStrength() => _matchStrength != null;

  // "matched" field.
  bool? _matched;
  bool get matched => _matched ?? false;
  bool hasMatched() => _matched != null;

  void _initializeFields() {
    _userAId = snapshotData['userAId'] as DocumentReference?;
    _userBId = snapshotData['userBId'] as DocumentReference?;
    _timestamp = snapshotData['timestamp'] as DateTime?;
    _venueId = snapshotData['venueId'] as DocumentReference?;
    _compassStarted = snapshotData['compassStarted'] as bool?;
    _lastSafetyPingAt = snapshotData['lastSafetyPingAt'] as DateTime?;
    _status = snapshotData['status'] as String?;
    _userALoc = snapshotData['userALoc'] as LatLng?;
    _userBLoc = snapshotData['userBLoc'] as LatLng?;
    _userAStatus = snapshotData['userAStatus'] as bool?;
    _userBStatus = snapshotData['userBStatus'] as bool?;
    _groupAId = snapshotData['groupAId'] as DocumentReference?;
    _groupBId = snapshotData['groupBId'] as DocumentReference?;
    _priorityGivenTo = snapshotData['priorityGivenTo'] as String?;
    _userAName = snapshotData['userAName'] as String?;
    _userBName = snapshotData['userBName'] as String?;
    _groupAName = snapshotData['groupAName'] as String?;
    _groupBName = snapshotData['groupBName'] as String?;
    _matchStrength = castToType<double>(snapshotData['matchStrength']);
    _matched = snapshotData['matched'] as bool?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('matches');

  static Stream<MatchesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => MatchesRecord.fromSnapshot(s));

  static Future<MatchesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => MatchesRecord.fromSnapshot(s));

  static MatchesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      MatchesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static MatchesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      MatchesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'MatchesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is MatchesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createMatchesRecordData({
  DocumentReference? userAId,
  DocumentReference? userBId,
  DateTime? timestamp,
  DocumentReference? venueId,
  bool? compassStarted,
  DateTime? lastSafetyPingAt,
  String? status,
  LatLng? userALoc,
  LatLng? userBLoc,
  bool? userAStatus,
  bool? userBStatus,
  DocumentReference? groupAId,
  DocumentReference? groupBId,
  String? priorityGivenTo,
  String? userAName,
  String? userBName,
  String? groupAName,
  String? groupBName,
  double? matchStrength,
  bool? matched,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'userAId': userAId,
      'userBId': userBId,
      'timestamp': timestamp,
      'venueId': venueId,
      'compassStarted': compassStarted,
      'lastSafetyPingAt': lastSafetyPingAt,
      'status': status,
      'userALoc': userALoc,
      'userBLoc': userBLoc,
      'userAStatus': userAStatus,
      'userBStatus': userBStatus,
      'groupAId': groupAId,
      'groupBId': groupBId,
      'priorityGivenTo': priorityGivenTo,
      'userAName': userAName,
      'userBName': userBName,
      'groupAName': groupAName,
      'groupBName': groupBName,
      'matchStrength': matchStrength,
      'matched': matched,
    }.withoutNulls,
  );

  return firestoreData;
}

class MatchesRecordDocumentEquality implements Equality<MatchesRecord> {
  const MatchesRecordDocumentEquality();

  @override
  bool equals(MatchesRecord? e1, MatchesRecord? e2) {
    return e1?.userAId == e2?.userAId &&
        e1?.userBId == e2?.userBId &&
        e1?.timestamp == e2?.timestamp &&
        e1?.venueId == e2?.venueId &&
        e1?.compassStarted == e2?.compassStarted &&
        e1?.lastSafetyPingAt == e2?.lastSafetyPingAt &&
        e1?.status == e2?.status &&
        e1?.userALoc == e2?.userALoc &&
        e1?.userBLoc == e2?.userBLoc &&
        e1?.userAStatus == e2?.userAStatus &&
        e1?.userBStatus == e2?.userBStatus &&
        e1?.groupAId == e2?.groupAId &&
        e1?.groupBId == e2?.groupBId &&
        e1?.priorityGivenTo == e2?.priorityGivenTo &&
        e1?.userAName == e2?.userAName &&
        e1?.userBName == e2?.userBName &&
        e1?.groupAName == e2?.groupAName &&
        e1?.groupBName == e2?.groupBName &&
        e1?.matchStrength == e2?.matchStrength &&
        e1?.matched == e2?.matched;
  }

  @override
  int hash(MatchesRecord? e) => const ListEquality().hash([
        e?.userAId,
        e?.userBId,
        e?.timestamp,
        e?.venueId,
        e?.compassStarted,
        e?.lastSafetyPingAt,
        e?.status,
        e?.userALoc,
        e?.userBLoc,
        e?.userAStatus,
        e?.userBStatus,
        e?.groupAId,
        e?.groupBId,
        e?.priorityGivenTo,
        e?.userAName,
        e?.userBName,
        e?.groupAName,
        e?.groupBName,
        e?.matchStrength,
        e?.matched
      ]);

  @override
  bool isValidKey(Object? o) => o is MatchesRecord;
}
