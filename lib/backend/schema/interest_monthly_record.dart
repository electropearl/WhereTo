import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class InterestMonthlyRecord extends FirestoreRecord {
  InterestMonthlyRecord._(
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
          ? parent.collection('interestMonthly')
          : FirebaseFirestore.instance.collectionGroup('interestMonthly');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('interestMonthly').doc(id);

  static Stream<InterestMonthlyRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => InterestMonthlyRecord.fromSnapshot(s));

  static Future<InterestMonthlyRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => InterestMonthlyRecord.fromSnapshot(s));

  static InterestMonthlyRecord fromSnapshot(DocumentSnapshot snapshot) =>
      InterestMonthlyRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static InterestMonthlyRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      InterestMonthlyRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'InterestMonthlyRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is InterestMonthlyRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createInterestMonthlyRecordData({
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

class InterestMonthlyRecordDocumentEquality
    implements Equality<InterestMonthlyRecord> {
  const InterestMonthlyRecordDocumentEquality();

  @override
  bool equals(InterestMonthlyRecord? e1, InterestMonthlyRecord? e2) {
    return e1?.dateTime == e2?.dateTime &&
        e1?.numberOfInterest == e2?.numberOfInterest;
  }

  @override
  int hash(InterestMonthlyRecord? e) =>
      const ListEquality().hash([e?.dateTime, e?.numberOfInterest]);

  @override
  bool isValidKey(Object? o) => o is InterestMonthlyRecord;
}
