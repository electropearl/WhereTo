import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class InterestWeeklyRecord extends FirestoreRecord {
  InterestWeeklyRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "dateTime" field.
  DateTime? _dateTime;
  DateTime? get dateTime => _dateTime;
  bool hasDateTime() => _dateTime != null;

  // "numberOfInterest" field.
  int? _numberOfInterest;
  int get numberOfInterest => _numberOfInterest ?? 0;
  bool hasNumberOfInterest() => _numberOfInterest != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _dateTime = snapshotData['dateTime'] as DateTime?;
    _numberOfInterest = castToType<int>(snapshotData['numberOfInterest']);
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('interestWeekly')
          : FirebaseFirestore.instance.collectionGroup('interestWeekly');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('interestWeekly').doc(id);

  static Stream<InterestWeeklyRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => InterestWeeklyRecord.fromSnapshot(s));

  static Future<InterestWeeklyRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => InterestWeeklyRecord.fromSnapshot(s));

  static InterestWeeklyRecord fromSnapshot(DocumentSnapshot snapshot) =>
      InterestWeeklyRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static InterestWeeklyRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      InterestWeeklyRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'InterestWeeklyRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is InterestWeeklyRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createInterestWeeklyRecordData({
  DateTime? dateTime,
  int? numberOfInterest,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'dateTime': dateTime,
      'numberOfInterest': numberOfInterest,
    }.withoutNulls,
  );

  return firestoreData;
}

class InterestWeeklyRecordDocumentEquality
    implements Equality<InterestWeeklyRecord> {
  const InterestWeeklyRecordDocumentEquality();

  @override
  bool equals(InterestWeeklyRecord? e1, InterestWeeklyRecord? e2) {
    return e1?.dateTime == e2?.dateTime &&
        e1?.numberOfInterest == e2?.numberOfInterest;
  }

  @override
  int hash(InterestWeeklyRecord? e) =>
      const ListEquality().hash([e?.dateTime, e?.numberOfInterest]);

  @override
  bool isValidKey(Object? o) => o is InterestWeeklyRecord;
}
