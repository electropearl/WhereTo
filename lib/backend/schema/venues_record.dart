import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class VenuesRecord extends FirestoreRecord {
  VenuesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "address" field.
  String? _address;
  String get address => _address ?? '';
  bool hasAddress() => _address != null;

  // "location" field.
  LatLng? _location;
  LatLng? get location => _location;
  bool hasLocation() => _location != null;

  // "geoHash" field.
  String? _geoHash;
  String get geoHash => _geoHash ?? '';
  bool hasGeoHash() => _geoHash != null;

  // "types" field.
  List<String>? _types;
  List<String> get types => _types ?? const [];
  bool hasTypes() => _types != null;

  // "photoUrl" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  // "ownerId" field.
  DocumentReference? _ownerId;
  DocumentReference? get ownerId => _ownerId;
  bool hasOwnerId() => _ownerId != null;

  // "isClaimed" field.
  bool? _isClaimed;
  bool get isClaimed => _isClaimed ?? false;
  bool hasIsClaimed() => _isClaimed != null;

  // "promoted" field.
  bool? _promoted;
  bool get promoted => _promoted ?? false;
  bool hasPromoted() => _promoted != null;

  // "boostRadius" field.
  double? _boostRadius;
  double get boostRadius => _boostRadius ?? 0.0;
  bool hasBoostRadius() => _boostRadius != null;

  // "promotionExpiresAt" field.
  DateTime? _promotionExpiresAt;
  DateTime? get promotionExpiresAt => _promotionExpiresAt;
  bool hasPromotionExpiresAt() => _promotionExpiresAt != null;

  // "usersHereNow" field.
  List<DocumentReference>? _usersHereNow;
  List<DocumentReference> get usersHereNow => _usersHereNow ?? const [];
  bool hasUsersHereNow() => _usersHereNow != null;

  // "trending" field.
  bool? _trending;
  bool get trending => _trending ?? false;
  bool hasTrending() => _trending != null;

  // "weekday_text" field.
  List<String>? _weekdayText;
  List<String> get weekdayText => _weekdayText ?? const [];
  bool hasWeekdayText() => _weekdayText != null;

  // "joinedVenueAt" field.
  DateTime? _joinedVenueAt;
  DateTime? get joinedVenueAt => _joinedVenueAt;
  bool hasJoinedVenueAt() => _joinedVenueAt != null;

  // "groupsHereNow" field.
  List<DocumentReference>? _groupsHereNow;
  List<DocumentReference> get groupsHereNow => _groupsHereNow ?? const [];
  bool hasGroupsHereNow() => _groupsHereNow != null;

  // "place_id" field.
  String? _placeId;
  String get placeId => _placeId ?? '';
  bool hasPlaceId() => _placeId != null;

  // "phone" field.
  String? _phone;
  String get phone => _phone ?? '';
  bool hasPhone() => _phone != null;

  // "website" field.
  String? _website;
  String get website => _website ?? '';
  bool hasWebsite() => _website != null;

  // "createdAt" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
    _address = snapshotData['address'] as String?;
    _location = snapshotData['location'] as LatLng?;
    _geoHash = snapshotData['geoHash'] as String?;
    _types = getDataList(snapshotData['types']);
    _photoUrl = snapshotData['photoUrl'] as String?;
    _ownerId = snapshotData['ownerId'] as DocumentReference?;
    _isClaimed = snapshotData['isClaimed'] as bool?;
    _promoted = snapshotData['promoted'] as bool?;
    _boostRadius = castToType<double>(snapshotData['boostRadius']);
    _promotionExpiresAt = snapshotData['promotionExpiresAt'] as DateTime?;
    _usersHereNow = getDataList(snapshotData['usersHereNow']);
    _trending = snapshotData['trending'] as bool?;
    _weekdayText = getDataList(snapshotData['weekday_text']);
    _joinedVenueAt = snapshotData['joinedVenueAt'] as DateTime?;
    _groupsHereNow = getDataList(snapshotData['groupsHereNow']);
    _placeId = snapshotData['place_id'] as String?;
    _phone = snapshotData['phone'] as String?;
    _website = snapshotData['website'] as String?;
    _createdAt = snapshotData['createdAt'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('venues');

  static Stream<VenuesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => VenuesRecord.fromSnapshot(s));

  static Future<VenuesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => VenuesRecord.fromSnapshot(s));

  static VenuesRecord fromSnapshot(DocumentSnapshot snapshot) => VenuesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static VenuesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      VenuesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'VenuesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is VenuesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createVenuesRecordData({
  String? name,
  String? address,
  LatLng? location,
  String? geoHash,
  String? photoUrl,
  DocumentReference? ownerId,
  bool? isClaimed,
  bool? promoted,
  double? boostRadius,
  DateTime? promotionExpiresAt,
  bool? trending,
  DateTime? joinedVenueAt,
  String? placeId,
  String? phone,
  String? website,
  DateTime? createdAt,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
      'address': address,
      'location': location,
      'geoHash': geoHash,
      'photoUrl': photoUrl,
      'ownerId': ownerId,
      'isClaimed': isClaimed,
      'promoted': promoted,
      'boostRadius': boostRadius,
      'promotionExpiresAt': promotionExpiresAt,
      'trending': trending,
      'joinedVenueAt': joinedVenueAt,
      'place_id': placeId,
      'phone': phone,
      'website': website,
      'createdAt': createdAt,
    }.withoutNulls,
  );

  return firestoreData;
}

class VenuesRecordDocumentEquality implements Equality<VenuesRecord> {
  const VenuesRecordDocumentEquality();

  @override
  bool equals(VenuesRecord? e1, VenuesRecord? e2) {
    const listEquality = ListEquality();
    return e1?.name == e2?.name &&
        e1?.address == e2?.address &&
        e1?.location == e2?.location &&
        e1?.geoHash == e2?.geoHash &&
        listEquality.equals(e1?.types, e2?.types) &&
        e1?.photoUrl == e2?.photoUrl &&
        e1?.ownerId == e2?.ownerId &&
        e1?.isClaimed == e2?.isClaimed &&
        e1?.promoted == e2?.promoted &&
        e1?.boostRadius == e2?.boostRadius &&
        e1?.promotionExpiresAt == e2?.promotionExpiresAt &&
        listEquality.equals(e1?.usersHereNow, e2?.usersHereNow) &&
        e1?.trending == e2?.trending &&
        listEquality.equals(e1?.weekdayText, e2?.weekdayText) &&
        e1?.joinedVenueAt == e2?.joinedVenueAt &&
        listEquality.equals(e1?.groupsHereNow, e2?.groupsHereNow) &&
        e1?.placeId == e2?.placeId &&
        e1?.phone == e2?.phone &&
        e1?.website == e2?.website &&
        e1?.createdAt == e2?.createdAt;
  }

  @override
  int hash(VenuesRecord? e) => const ListEquality().hash([
        e?.name,
        e?.address,
        e?.location,
        e?.geoHash,
        e?.types,
        e?.photoUrl,
        e?.ownerId,
        e?.isClaimed,
        e?.promoted,
        e?.boostRadius,
        e?.promotionExpiresAt,
        e?.usersHereNow,
        e?.trending,
        e?.weekdayText,
        e?.joinedVenueAt,
        e?.groupsHereNow,
        e?.placeId,
        e?.phone,
        e?.website,
        e?.createdAt
      ]);

  @override
  bool isValidKey(Object? o) => o is VenuesRecord;
}
