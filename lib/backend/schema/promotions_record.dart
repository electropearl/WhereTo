import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PromotionsRecord extends FirestoreRecord {
  PromotionsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "venueId" field.
  DocumentReference? _venueId;
  DocumentReference? get venueId => _venueId;
  bool hasVenueId() => _venueId != null;

  // "boostType" field.
  String? _boostType;
  String get boostType => _boostType ?? '';
  bool hasBoostType() => _boostType != null;

  // "createdBy" field.
  DocumentReference? _createdBy;
  DocumentReference? get createdBy => _createdBy;
  bool hasCreatedBy() => _createdBy != null;

  // "startDate" field.
  DateTime? _startDate;
  DateTime? get startDate => _startDate;
  bool hasStartDate() => _startDate != null;

  // "endDate" field.
  DateTime? _endDate;
  DateTime? get endDate => _endDate;
  bool hasEndDate() => _endDate != null;

  // "paidAmount" field.
  double? _paidAmount;
  double get paidAmount => _paidAmount ?? 0.0;
  bool hasPaidAmount() => _paidAmount != null;

  // "boostRadius" field.
  double? _boostRadius;
  double get boostRadius => _boostRadius ?? 0.0;
  bool hasBoostRadius() => _boostRadius != null;

  void _initializeFields() {
    _venueId = snapshotData['venueId'] as DocumentReference?;
    _boostType = snapshotData['boostType'] as String?;
    _createdBy = snapshotData['createdBy'] as DocumentReference?;
    _startDate = snapshotData['startDate'] as DateTime?;
    _endDate = snapshotData['endDate'] as DateTime?;
    _paidAmount = castToType<double>(snapshotData['paidAmount']);
    _boostRadius = castToType<double>(snapshotData['boostRadius']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('promotions');

  static Stream<PromotionsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => PromotionsRecord.fromSnapshot(s));

  static Future<PromotionsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => PromotionsRecord.fromSnapshot(s));

  static PromotionsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      PromotionsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static PromotionsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      PromotionsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'PromotionsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is PromotionsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createPromotionsRecordData({
  DocumentReference? venueId,
  String? boostType,
  DocumentReference? createdBy,
  DateTime? startDate,
  DateTime? endDate,
  double? paidAmount,
  double? boostRadius,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'venueId': venueId,
      'boostType': boostType,
      'createdBy': createdBy,
      'startDate': startDate,
      'endDate': endDate,
      'paidAmount': paidAmount,
      'boostRadius': boostRadius,
    }.withoutNulls,
  );

  return firestoreData;
}

class PromotionsRecordDocumentEquality implements Equality<PromotionsRecord> {
  const PromotionsRecordDocumentEquality();

  @override
  bool equals(PromotionsRecord? e1, PromotionsRecord? e2) {
    return e1?.venueId == e2?.venueId &&
        e1?.boostType == e2?.boostType &&
        e1?.createdBy == e2?.createdBy &&
        e1?.startDate == e2?.startDate &&
        e1?.endDate == e2?.endDate &&
        e1?.paidAmount == e2?.paidAmount &&
        e1?.boostRadius == e2?.boostRadius;
  }

  @override
  int hash(PromotionsRecord? e) => const ListEquality().hash([
        e?.venueId,
        e?.boostType,
        e?.createdBy,
        e?.startDate,
        e?.endDate,
        e?.paidAmount,
        e?.boostRadius
      ]);

  @override
  bool isValidKey(Object? o) => o is PromotionsRecord;
}
