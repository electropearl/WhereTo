import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class EventsRecord extends FirestoreRecord {
  EventsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "createdBy" field.
  DocumentReference? _createdBy;
  DocumentReference? get createdBy => _createdBy;
  bool hasCreatedBy() => _createdBy != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  bool hasTitle() => _title != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "venueId" field.
  DocumentReference? _venueId;
  DocumentReference? get venueId => _venueId;
  bool hasVenueId() => _venueId != null;

  // "startTime" field.
  DateTime? _startTime;
  DateTime? get startTime => _startTime;
  bool hasStartTime() => _startTime != null;

  // "endTime" field.
  DateTime? _endTime;
  DateTime? get endTime => _endTime;
  bool hasEndTime() => _endTime != null;

  // "capacity" field.
  int? _capacity;
  int get capacity => _capacity ?? 0;
  bool hasCapacity() => _capacity != null;

  // "attendeeIds" field.
  List<DocumentReference>? _attendeeIds;
  List<DocumentReference> get attendeeIds => _attendeeIds ?? const [];
  bool hasAttendeeIds() => _attendeeIds != null;

  // "public" field.
  bool? _public;
  bool get public => _public ?? false;
  bool hasPublic() => _public != null;

  // "isSponsored" field.
  bool? _isSponsored;
  bool get isSponsored => _isSponsored ?? false;
  bool hasIsSponsored() => _isSponsored != null;

  void _initializeFields() {
    _createdBy = snapshotData['createdBy'] as DocumentReference?;
    _title = snapshotData['title'] as String?;
    _description = snapshotData['description'] as String?;
    _venueId = snapshotData['venueId'] as DocumentReference?;
    _startTime = snapshotData['startTime'] as DateTime?;
    _endTime = snapshotData['endTime'] as DateTime?;
    _capacity = castToType<int>(snapshotData['capacity']);
    _attendeeIds = getDataList(snapshotData['attendeeIds']);
    _public = snapshotData['public'] as bool?;
    _isSponsored = snapshotData['isSponsored'] as bool?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('events');

  static Stream<EventsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => EventsRecord.fromSnapshot(s));

  static Future<EventsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => EventsRecord.fromSnapshot(s));

  static EventsRecord fromSnapshot(DocumentSnapshot snapshot) => EventsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static EventsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      EventsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'EventsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is EventsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createEventsRecordData({
  DocumentReference? createdBy,
  String? title,
  String? description,
  DocumentReference? venueId,
  DateTime? startTime,
  DateTime? endTime,
  int? capacity,
  bool? public,
  bool? isSponsored,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'createdBy': createdBy,
      'title': title,
      'description': description,
      'venueId': venueId,
      'startTime': startTime,
      'endTime': endTime,
      'capacity': capacity,
      'public': public,
      'isSponsored': isSponsored,
    }.withoutNulls,
  );

  return firestoreData;
}

class EventsRecordDocumentEquality implements Equality<EventsRecord> {
  const EventsRecordDocumentEquality();

  @override
  bool equals(EventsRecord? e1, EventsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.createdBy == e2?.createdBy &&
        e1?.title == e2?.title &&
        e1?.description == e2?.description &&
        e1?.venueId == e2?.venueId &&
        e1?.startTime == e2?.startTime &&
        e1?.endTime == e2?.endTime &&
        e1?.capacity == e2?.capacity &&
        listEquality.equals(e1?.attendeeIds, e2?.attendeeIds) &&
        e1?.public == e2?.public &&
        e1?.isSponsored == e2?.isSponsored;
  }

  @override
  int hash(EventsRecord? e) => const ListEquality().hash([
        e?.createdBy,
        e?.title,
        e?.description,
        e?.venueId,
        e?.startTime,
        e?.endTime,
        e?.capacity,
        e?.attendeeIds,
        e?.public,
        e?.isSponsored
      ]);

  @override
  bool isValidKey(Object? o) => o is EventsRecord;
}
