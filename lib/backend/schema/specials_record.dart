import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SpecialsRecord extends FirestoreRecord {
  SpecialsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  bool hasTitle() => _title != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "startDate" field.
  DateTime? _startDate;
  DateTime? get startDate => _startDate;
  bool hasStartDate() => _startDate != null;

  // "endDate" field.
  DateTime? _endDate;
  DateTime? get endDate => _endDate;
  bool hasEndDate() => _endDate != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _title = snapshotData['title'] as String?;
    _description = snapshotData['description'] as String?;
    _startDate = snapshotData['startDate'] as DateTime?;
    _endDate = snapshotData['endDate'] as DateTime?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('specials')
          : FirebaseFirestore.instance.collectionGroup('specials');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('specials').doc(id);

  static Stream<SpecialsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => SpecialsRecord.fromSnapshot(s));

  static Future<SpecialsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => SpecialsRecord.fromSnapshot(s));

  static SpecialsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      SpecialsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static SpecialsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      SpecialsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'SpecialsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is SpecialsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createSpecialsRecordData({
  String? title,
  String? description,
  DateTime? startDate,
  DateTime? endDate,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'title': title,
      'description': description,
      'startDate': startDate,
      'endDate': endDate,
    }.withoutNulls,
  );

  return firestoreData;
}

class SpecialsRecordDocumentEquality implements Equality<SpecialsRecord> {
  const SpecialsRecordDocumentEquality();

  @override
  bool equals(SpecialsRecord? e1, SpecialsRecord? e2) {
    return e1?.title == e2?.title &&
        e1?.description == e2?.description &&
        e1?.startDate == e2?.startDate &&
        e1?.endDate == e2?.endDate;
  }

  @override
  int hash(SpecialsRecord? e) => const ListEquality()
      .hash([e?.title, e?.description, e?.startDate, e?.endDate]);

  @override
  bool isValidKey(Object? o) => o is SpecialsRecord;
}
