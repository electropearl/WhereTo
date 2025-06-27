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

  void _initializeFields() {
    _userAId = snapshotData['userAId'] as DocumentReference?;
    _userBId = snapshotData['userBId'] as DocumentReference?;
    _timestamp = snapshotData['timestamp'] as DateTime?;
    _venueId = snapshotData['venueId'] as DocumentReference?;
    _compassStarted = snapshotData['compassStarted'] as bool?;
    _lastSafetyPingAt = snapshotData['lastSafetyPingAt'] as DateTime?;
    _status = snapshotData['status'] as String?;
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
        e1?.status == e2?.status;
  }

  @override
  int hash(MatchesRecord? e) => const ListEquality().hash([
        e?.userAId,
        e?.userBId,
        e?.timestamp,
        e?.venueId,
        e?.compassStarted,
        e?.lastSafetyPingAt,
        e?.status
      ]);

  @override
  bool isValidKey(Object? o) => o is MatchesRecord;
}
