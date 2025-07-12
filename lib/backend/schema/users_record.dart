import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UsersRecord extends FirestoreRecord {
  UsersRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "display_name" field.
  String? _displayName;
  String get displayName => _displayName ?? '';
  bool hasDisplayName() => _displayName != null;

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "phone_number" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  bool hasPhoneNumber() => _phoneNumber != null;

  // "bio" field.
  String? _bio;
  String get bio => _bio ?? '';
  bool hasBio() => _bio != null;

  // "interests" field.
  List<String>? _interests;
  List<String> get interests => _interests ?? const [];
  bool hasInterests() => _interests != null;

  // "vibePreferances" field.
  List<String>? _vibePreferances;
  List<String> get vibePreferances => _vibePreferances ?? const [];
  bool hasVibePreferances() => _vibePreferances != null;

  // "location" field.
  LatLng? _location;
  LatLng? get location => _location;
  bool hasLocation() => _location != null;

  // "geoHash" field.
  String? _geoHash;
  String get geoHash => _geoHash ?? '';
  bool hasGeoHash() => _geoHash != null;

  // "openToMatch" field.
  bool? _openToMatch;
  bool get openToMatch => _openToMatch ?? false;
  bool hasOpenToMatch() => _openToMatch != null;

  // "visibleOnMap" field.
  bool? _visibleOnMap;
  bool get visibleOnMap => _visibleOnMap ?? false;
  bool hasVisibleOnMap() => _visibleOnMap != null;

  // "friendTypeLabel" field.
  String? _friendTypeLabel;
  String get friendTypeLabel => _friendTypeLabel ?? '';
  bool hasFriendTypeLabel() => _friendTypeLabel != null;

  // "groupId" field.
  DocumentReference? _groupId;
  DocumentReference? get groupId => _groupId;
  bool hasGroupId() => _groupId != null;

  // "groupIds" field.
  List<DocumentReference>? _groupIds;
  List<DocumentReference> get groupIds => _groupIds ?? const [];
  bool hasGroupIds() => _groupIds != null;

  // "radiusSaved" field.
  double? _radiusSaved;
  double get radiusSaved => _radiusSaved ?? 0.0;
  bool hasRadiusSaved() => _radiusSaved != null;

  // "interestedInGoing" field.
  List<DocumentReference>? _interestedInGoing;
  List<DocumentReference> get interestedInGoing =>
      _interestedInGoing ?? const [];
  bool hasInterestedInGoing() => _interestedInGoing != null;

  // "friendsList" field.
  List<DocumentReference>? _friendsList;
  List<DocumentReference> get friendsList => _friendsList ?? const [];
  bool hasFriendsList() => _friendsList != null;

  // "venueFilter" field.
  List<String>? _venueFilter;
  List<String> get venueFilter => _venueFilter ?? const [];
  bool hasVenueFilter() => _venueFilter != null;

  // "owner" field.
  bool? _owner;
  bool get owner => _owner ?? false;
  bool hasOwner() => _owner != null;

  // "birthday" field.
  DateTime? _birthday;
  DateTime? get birthday => _birthday;
  bool hasBirthday() => _birthday != null;

  // "currentGroup" field.
  DocumentReference? _currentGroup;
  DocumentReference? get currentGroup => _currentGroup;
  bool hasCurrentGroup() => _currentGroup != null;

  // "geoLocation" field.
  LatLng? _geoLocation;
  LatLng? get geoLocation => _geoLocation;
  bool hasGeoLocation() => _geoLocation != null;

  // "isInGroup" field.
  bool? _isInGroup;
  bool get isInGroup => _isInGroup ?? false;
  bool hasIsInGroup() => _isInGroup != null;

  // "seekingType" field.
  List<String>? _seekingType;
  List<String> get seekingType => _seekingType ?? const [];
  bool hasSeekingType() => _seekingType != null;

  // "currentVenue" field.
  DocumentReference? _currentVenue;
  DocumentReference? get currentVenue => _currentVenue;
  bool hasCurrentVenue() => _currentVenue != null;

  // "lastMatchAttemptAt" field.
  DateTime? _lastMatchAttemptAt;
  DateTime? get lastMatchAttemptAt => _lastMatchAttemptAt;
  bool hasLastMatchAttemptAt() => _lastMatchAttemptAt != null;

  // "numOfFailedMatches" field.
  int? _numOfFailedMatches;
  int get numOfFailedMatches => _numOfFailedMatches ?? 0;
  bool hasNumOfFailedMatches() => _numOfFailedMatches != null;

  // "matchCooldownUntil" field.
  DateTime? _matchCooldownUntil;
  DateTime? get matchCooldownUntil => _matchCooldownUntil;
  bool hasMatchCooldownUntil() => _matchCooldownUntil != null;

  // "gender" field.
  String? _gender;
  String get gender => _gender ?? '';
  bool hasGender() => _gender != null;

  // "couple" field.
  bool? _couple;
  bool get couple => _couple ?? false;
  bool hasCouple() => _couple != null;

  // "coupleUserRef" field.
  DocumentReference? _coupleUserRef;
  DocumentReference? get coupleUserRef => _coupleUserRef;
  bool hasCoupleUserRef() => _coupleUserRef != null;

  // "isSubscribed" field.
  bool? _isSubscribed;
  bool get isSubscribed => _isSubscribed ?? false;
  bool hasIsSubscribed() => _isSubscribed != null;

  // "matchedUserIds" field.
  List<DocumentReference>? _matchedUserIds;
  List<DocumentReference> get matchedUserIds => _matchedUserIds ?? const [];
  bool hasMatchedUserIds() => _matchedUserIds != null;

  // "arrivedAt" field.
  DateTime? _arrivedAt;
  DateTime? get arrivedAt => _arrivedAt;
  bool hasArrivedAt() => _arrivedAt != null;

  // "profileVerificationInfo" field.
  StoreOwnerInformationStruct? _profileVerificationInfo;
  StoreOwnerInformationStruct get profileVerificationInfo =>
      _profileVerificationInfo ?? StoreOwnerInformationStruct();
  bool hasProfileVerificationInfo() => _profileVerificationInfo != null;

  // "admin" field.
  bool? _admin;
  bool get admin => _admin ?? false;
  bool hasAdmin() => _admin != null;

  // "latitude" field.
  double? _latitude;
  double get latitude => _latitude ?? 0.0;
  bool hasLatitude() => _latitude != null;

  // "longitude" field.
  double? _longitude;
  double get longitude => _longitude ?? 0.0;
  bool hasLongitude() => _longitude != null;

  // "FriendCode" field.
  String? _friendCode;
  String get friendCode => _friendCode ?? '';
  bool hasFriendCode() => _friendCode != null;

  // "fcmToken" field.
  String? _fcmToken;
  String get fcmToken => _fcmToken ?? '';
  bool hasFcmToken() => _fcmToken != null;

  void _initializeFields() {
    _email = snapshotData['email'] as String?;
    _displayName = snapshotData['display_name'] as String?;
    _photoUrl = snapshotData['photo_url'] as String?;
    _uid = snapshotData['uid'] as String?;
    _createdTime = snapshotData['created_time'] as DateTime?;
    _phoneNumber = snapshotData['phone_number'] as String?;
    _bio = snapshotData['bio'] as String?;
    _interests = getDataList(snapshotData['interests']);
    _vibePreferances = getDataList(snapshotData['vibePreferances']);
    _location = snapshotData['location'] as LatLng?;
    _geoHash = snapshotData['geoHash'] as String?;
    _openToMatch = snapshotData['openToMatch'] as bool?;
    _visibleOnMap = snapshotData['visibleOnMap'] as bool?;
    _friendTypeLabel = snapshotData['friendTypeLabel'] as String?;
    _groupId = snapshotData['groupId'] as DocumentReference?;
    _groupIds = getDataList(snapshotData['groupIds']);
    _radiusSaved = castToType<double>(snapshotData['radiusSaved']);
    _interestedInGoing = getDataList(snapshotData['interestedInGoing']);
    _friendsList = getDataList(snapshotData['friendsList']);
    _venueFilter = getDataList(snapshotData['venueFilter']);
    _owner = snapshotData['owner'] as bool?;
    _birthday = snapshotData['birthday'] as DateTime?;
    _currentGroup = snapshotData['currentGroup'] as DocumentReference?;
    _geoLocation = snapshotData['geoLocation'] as LatLng?;
    _isInGroup = snapshotData['isInGroup'] as bool?;
    _seekingType = getDataList(snapshotData['seekingType']);
    _currentVenue = snapshotData['currentVenue'] as DocumentReference?;
    _lastMatchAttemptAt = snapshotData['lastMatchAttemptAt'] as DateTime?;
    _numOfFailedMatches = castToType<int>(snapshotData['numOfFailedMatches']);
    _matchCooldownUntil = snapshotData['matchCooldownUntil'] as DateTime?;
    _gender = snapshotData['gender'] as String?;
    _couple = snapshotData['couple'] as bool?;
    _coupleUserRef = snapshotData['coupleUserRef'] as DocumentReference?;
    _isSubscribed = snapshotData['isSubscribed'] as bool?;
    _matchedUserIds = getDataList(snapshotData['matchedUserIds']);
    _arrivedAt = snapshotData['arrivedAt'] as DateTime?;
    _profileVerificationInfo =
        snapshotData['profileVerificationInfo'] is StoreOwnerInformationStruct
            ? snapshotData['profileVerificationInfo']
            : StoreOwnerInformationStruct.maybeFromMap(
                snapshotData['profileVerificationInfo']);
    _admin = snapshotData['admin'] as bool?;
    _latitude = castToType<double>(snapshotData['latitude']);
    _longitude = castToType<double>(snapshotData['longitude']);
    _friendCode = snapshotData['FriendCode'] as String?;
    _fcmToken = snapshotData['fcmToken'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('users');

  static Stream<UsersRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UsersRecord.fromSnapshot(s));

  static Future<UsersRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UsersRecord.fromSnapshot(s));

  static UsersRecord fromSnapshot(DocumentSnapshot snapshot) => UsersRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UsersRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UsersRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UsersRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UsersRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUsersRecordData({
  String? email,
  String? displayName,
  String? photoUrl,
  String? uid,
  DateTime? createdTime,
  String? phoneNumber,
  String? bio,
  LatLng? location,
  String? geoHash,
  bool? openToMatch,
  bool? visibleOnMap,
  String? friendTypeLabel,
  DocumentReference? groupId,
  double? radiusSaved,
  bool? owner,
  DateTime? birthday,
  DocumentReference? currentGroup,
  LatLng? geoLocation,
  bool? isInGroup,
  DocumentReference? currentVenue,
  DateTime? lastMatchAttemptAt,
  int? numOfFailedMatches,
  DateTime? matchCooldownUntil,
  String? gender,
  bool? couple,
  DocumentReference? coupleUserRef,
  bool? isSubscribed,
  DateTime? arrivedAt,
  StoreOwnerInformationStruct? profileVerificationInfo,
  bool? admin,
  double? latitude,
  double? longitude,
  String? friendCode,
  String? fcmToken,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'email': email,
      'display_name': displayName,
      'photo_url': photoUrl,
      'uid': uid,
      'created_time': createdTime,
      'phone_number': phoneNumber,
      'bio': bio,
      'location': location,
      'geoHash': geoHash,
      'openToMatch': openToMatch,
      'visibleOnMap': visibleOnMap,
      'friendTypeLabel': friendTypeLabel,
      'groupId': groupId,
      'radiusSaved': radiusSaved,
      'owner': owner,
      'birthday': birthday,
      'currentGroup': currentGroup,
      'geoLocation': geoLocation,
      'isInGroup': isInGroup,
      'currentVenue': currentVenue,
      'lastMatchAttemptAt': lastMatchAttemptAt,
      'numOfFailedMatches': numOfFailedMatches,
      'matchCooldownUntil': matchCooldownUntil,
      'gender': gender,
      'couple': couple,
      'coupleUserRef': coupleUserRef,
      'isSubscribed': isSubscribed,
      'arrivedAt': arrivedAt,
      'profileVerificationInfo': StoreOwnerInformationStruct().toMap(),
      'admin': admin,
      'latitude': latitude,
      'longitude': longitude,
      'FriendCode': friendCode,
      'fcmToken': fcmToken,
    }.withoutNulls,
  );

  // Handle nested data for "profileVerificationInfo" field.
  addStoreOwnerInformationStructData(
      firestoreData, profileVerificationInfo, 'profileVerificationInfo');

  return firestoreData;
}

class UsersRecordDocumentEquality implements Equality<UsersRecord> {
  const UsersRecordDocumentEquality();

  @override
  bool equals(UsersRecord? e1, UsersRecord? e2) {
    const listEquality = ListEquality();
    return e1?.email == e2?.email &&
        e1?.displayName == e2?.displayName &&
        e1?.photoUrl == e2?.photoUrl &&
        e1?.uid == e2?.uid &&
        e1?.createdTime == e2?.createdTime &&
        e1?.phoneNumber == e2?.phoneNumber &&
        e1?.bio == e2?.bio &&
        listEquality.equals(e1?.interests, e2?.interests) &&
        listEquality.equals(e1?.vibePreferances, e2?.vibePreferances) &&
        e1?.location == e2?.location &&
        e1?.geoHash == e2?.geoHash &&
        e1?.openToMatch == e2?.openToMatch &&
        e1?.visibleOnMap == e2?.visibleOnMap &&
        e1?.friendTypeLabel == e2?.friendTypeLabel &&
        e1?.groupId == e2?.groupId &&
        listEquality.equals(e1?.groupIds, e2?.groupIds) &&
        e1?.radiusSaved == e2?.radiusSaved &&
        listEquality.equals(e1?.interestedInGoing, e2?.interestedInGoing) &&
        listEquality.equals(e1?.friendsList, e2?.friendsList) &&
        listEquality.equals(e1?.venueFilter, e2?.venueFilter) &&
        e1?.owner == e2?.owner &&
        e1?.birthday == e2?.birthday &&
        e1?.currentGroup == e2?.currentGroup &&
        e1?.geoLocation == e2?.geoLocation &&
        e1?.isInGroup == e2?.isInGroup &&
        listEquality.equals(e1?.seekingType, e2?.seekingType) &&
        e1?.currentVenue == e2?.currentVenue &&
        e1?.lastMatchAttemptAt == e2?.lastMatchAttemptAt &&
        e1?.numOfFailedMatches == e2?.numOfFailedMatches &&
        e1?.matchCooldownUntil == e2?.matchCooldownUntil &&
        e1?.gender == e2?.gender &&
        e1?.couple == e2?.couple &&
        e1?.coupleUserRef == e2?.coupleUserRef &&
        e1?.isSubscribed == e2?.isSubscribed &&
        listEquality.equals(e1?.matchedUserIds, e2?.matchedUserIds) &&
        e1?.arrivedAt == e2?.arrivedAt &&
        e1?.profileVerificationInfo == e2?.profileVerificationInfo &&
        e1?.admin == e2?.admin &&
        e1?.latitude == e2?.latitude &&
        e1?.longitude == e2?.longitude &&
        e1?.friendCode == e2?.friendCode &&
        e1?.fcmToken == e2?.fcmToken;
  }

  @override
  int hash(UsersRecord? e) => const ListEquality().hash([
        e?.email,
        e?.displayName,
        e?.photoUrl,
        e?.uid,
        e?.createdTime,
        e?.phoneNumber,
        e?.bio,
        e?.interests,
        e?.vibePreferances,
        e?.location,
        e?.geoHash,
        e?.openToMatch,
        e?.visibleOnMap,
        e?.friendTypeLabel,
        e?.groupId,
        e?.groupIds,
        e?.radiusSaved,
        e?.interestedInGoing,
        e?.friendsList,
        e?.venueFilter,
        e?.owner,
        e?.birthday,
        e?.currentGroup,
        e?.geoLocation,
        e?.isInGroup,
        e?.seekingType,
        e?.currentVenue,
        e?.lastMatchAttemptAt,
        e?.numOfFailedMatches,
        e?.matchCooldownUntil,
        e?.gender,
        e?.couple,
        e?.coupleUserRef,
        e?.isSubscribed,
        e?.matchedUserIds,
        e?.arrivedAt,
        e?.profileVerificationInfo,
        e?.admin,
        e?.latitude,
        e?.longitude,
        e?.friendCode,
        e?.fcmToken
      ]);

  @override
  bool isValidKey(Object? o) => o is UsersRecord;
}
