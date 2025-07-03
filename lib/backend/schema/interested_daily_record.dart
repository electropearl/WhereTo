import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class InterestedDailyRecord extends FirestoreRecord {
  InterestedDailyRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "dateTime" field.
  DateTime? _dateTime;
  DateTime? get dateTime => _dateTime;
  bool hasDateTime() => _dateTime != null;

  // "totalInterestToday" field.
  int? _totalInterestToday;
  int get totalInterestToday => _totalInterestToday ?? 0;
  bool hasTotalInterestToday() => _totalInterestToday != null;

  // "peopleList" field.
  List<DocumentReference>? _peopleList;
  List<DocumentReference> get peopleList => _peopleList ?? const [];
  bool hasPeopleList() => _peopleList != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _dateTime = snapshotData['dateTime'] as DateTime?;
    _totalInterestToday = castToType<int>(snapshotData['totalInterestToday']);
    _peopleList = getDataList(snapshotData['peopleList']);
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('interestedDaily')
          : FirebaseFirestore.instance.collectionGroup('interestedDaily');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('interestedDaily').doc(id);

  static Stream<InterestedDailyRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => InterestedDailyRecord.fromSnapshot(s));

  static Future<InterestedDailyRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => InterestedDailyRecord.fromSnapshot(s));

  static InterestedDailyRecord fromSnapshot(DocumentSnapshot snapshot) =>
      InterestedDailyRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static InterestedDailyRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      InterestedDailyRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'InterestedDailyRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is InterestedDailyRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createInterestedDailyRecordData({
  DateTime? dateTime,
  int? totalInterestToday,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'dateTime': dateTime,
      'totalInterestToday': totalInterestToday,
    }.withoutNulls,
  );

  return firestoreData;
}

class InterestedDailyRecordDocumentEquality
    implements Equality<InterestedDailyRecord> {
  const InterestedDailyRecordDocumentEquality();

  @override
  bool equals(InterestedDailyRecord? e1, InterestedDailyRecord? e2) {
    const listEquality = ListEquality();
    return e1?.dateTime == e2?.dateTime &&
        e1?.totalInterestToday == e2?.totalInterestToday &&
        listEquality.equals(e1?.peopleList, e2?.peopleList);
  }

  @override
  int hash(InterestedDailyRecord? e) => const ListEquality()
      .hash([e?.dateTime, e?.totalInterestToday, e?.peopleList]);

  @override
  bool isValidKey(Object? o) => o is InterestedDailyRecord;
}
