// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class StoreOwnerInformationStruct extends FFFirebaseStruct {
  StoreOwnerInformationStruct({
    String? storeName,
    String? storeAddress,
    String? businessPhone,
    String? businessEmail,
    String? businessLicenseDocUrl,
    String? utilityBillOrLeaseDocUrl,
    String? onlineDashboardScreenshotUrl,
    String? storePhotoUrl,
    DateTime? submissionDate,
    String? verificationStatus,
    DocumentReference? placeID,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _storeName = storeName,
        _storeAddress = storeAddress,
        _businessPhone = businessPhone,
        _businessEmail = businessEmail,
        _businessLicenseDocUrl = businessLicenseDocUrl,
        _utilityBillOrLeaseDocUrl = utilityBillOrLeaseDocUrl,
        _onlineDashboardScreenshotUrl = onlineDashboardScreenshotUrl,
        _storePhotoUrl = storePhotoUrl,
        _submissionDate = submissionDate,
        _verificationStatus = verificationStatus,
        _placeID = placeID,
        super(firestoreUtilData);

  // "storeName" field.
  String? _storeName;
  String get storeName => _storeName ?? '';
  set storeName(String? val) => _storeName = val;

  bool hasStoreName() => _storeName != null;

  // "storeAddress" field.
  String? _storeAddress;
  String get storeAddress => _storeAddress ?? '';
  set storeAddress(String? val) => _storeAddress = val;

  bool hasStoreAddress() => _storeAddress != null;

  // "businessPhone" field.
  String? _businessPhone;
  String get businessPhone => _businessPhone ?? '';
  set businessPhone(String? val) => _businessPhone = val;

  bool hasBusinessPhone() => _businessPhone != null;

  // "businessEmail" field.
  String? _businessEmail;
  String get businessEmail => _businessEmail ?? '';
  set businessEmail(String? val) => _businessEmail = val;

  bool hasBusinessEmail() => _businessEmail != null;

  // "businessLicenseDocUrl" field.
  String? _businessLicenseDocUrl;
  String get businessLicenseDocUrl => _businessLicenseDocUrl ?? '';
  set businessLicenseDocUrl(String? val) => _businessLicenseDocUrl = val;

  bool hasBusinessLicenseDocUrl() => _businessLicenseDocUrl != null;

  // "utilityBillOrLeaseDocUrl" field.
  String? _utilityBillOrLeaseDocUrl;
  String get utilityBillOrLeaseDocUrl => _utilityBillOrLeaseDocUrl ?? '';
  set utilityBillOrLeaseDocUrl(String? val) => _utilityBillOrLeaseDocUrl = val;

  bool hasUtilityBillOrLeaseDocUrl() => _utilityBillOrLeaseDocUrl != null;

  // "onlineDashboardScreenshotUrl" field.
  String? _onlineDashboardScreenshotUrl;
  String get onlineDashboardScreenshotUrl =>
      _onlineDashboardScreenshotUrl ?? '';
  set onlineDashboardScreenshotUrl(String? val) =>
      _onlineDashboardScreenshotUrl = val;

  bool hasOnlineDashboardScreenshotUrl() =>
      _onlineDashboardScreenshotUrl != null;

  // "storePhotoUrl" field.
  String? _storePhotoUrl;
  String get storePhotoUrl => _storePhotoUrl ?? '';
  set storePhotoUrl(String? val) => _storePhotoUrl = val;

  bool hasStorePhotoUrl() => _storePhotoUrl != null;

  // "submissionDate" field.
  DateTime? _submissionDate;
  DateTime? get submissionDate => _submissionDate;
  set submissionDate(DateTime? val) => _submissionDate = val;

  bool hasSubmissionDate() => _submissionDate != null;

  // "verificationStatus" field.
  String? _verificationStatus;
  String get verificationStatus => _verificationStatus ?? '';
  set verificationStatus(String? val) => _verificationStatus = val;

  bool hasVerificationStatus() => _verificationStatus != null;

  // "PlaceID" field.
  DocumentReference? _placeID;
  DocumentReference? get placeID => _placeID;
  set placeID(DocumentReference? val) => _placeID = val;

  bool hasPlaceID() => _placeID != null;

  static StoreOwnerInformationStruct fromMap(Map<String, dynamic> data) =>
      StoreOwnerInformationStruct(
        storeName: data['storeName'] as String?,
        storeAddress: data['storeAddress'] as String?,
        businessPhone: data['businessPhone'] as String?,
        businessEmail: data['businessEmail'] as String?,
        businessLicenseDocUrl: data['businessLicenseDocUrl'] as String?,
        utilityBillOrLeaseDocUrl: data['utilityBillOrLeaseDocUrl'] as String?,
        onlineDashboardScreenshotUrl:
            data['onlineDashboardScreenshotUrl'] as String?,
        storePhotoUrl: data['storePhotoUrl'] as String?,
        submissionDate: data['submissionDate'] as DateTime?,
        verificationStatus: data['verificationStatus'] as String?,
        placeID: data['PlaceID'] as DocumentReference?,
      );

  static StoreOwnerInformationStruct? maybeFromMap(dynamic data) => data is Map
      ? StoreOwnerInformationStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'storeName': _storeName,
        'storeAddress': _storeAddress,
        'businessPhone': _businessPhone,
        'businessEmail': _businessEmail,
        'businessLicenseDocUrl': _businessLicenseDocUrl,
        'utilityBillOrLeaseDocUrl': _utilityBillOrLeaseDocUrl,
        'onlineDashboardScreenshotUrl': _onlineDashboardScreenshotUrl,
        'storePhotoUrl': _storePhotoUrl,
        'submissionDate': _submissionDate,
        'verificationStatus': _verificationStatus,
        'PlaceID': _placeID,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'storeName': serializeParam(
          _storeName,
          ParamType.String,
        ),
        'storeAddress': serializeParam(
          _storeAddress,
          ParamType.String,
        ),
        'businessPhone': serializeParam(
          _businessPhone,
          ParamType.String,
        ),
        'businessEmail': serializeParam(
          _businessEmail,
          ParamType.String,
        ),
        'businessLicenseDocUrl': serializeParam(
          _businessLicenseDocUrl,
          ParamType.String,
        ),
        'utilityBillOrLeaseDocUrl': serializeParam(
          _utilityBillOrLeaseDocUrl,
          ParamType.String,
        ),
        'onlineDashboardScreenshotUrl': serializeParam(
          _onlineDashboardScreenshotUrl,
          ParamType.String,
        ),
        'storePhotoUrl': serializeParam(
          _storePhotoUrl,
          ParamType.String,
        ),
        'submissionDate': serializeParam(
          _submissionDate,
          ParamType.DateTime,
        ),
        'verificationStatus': serializeParam(
          _verificationStatus,
          ParamType.String,
        ),
        'PlaceID': serializeParam(
          _placeID,
          ParamType.DocumentReference,
        ),
      }.withoutNulls;

  static StoreOwnerInformationStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      StoreOwnerInformationStruct(
        storeName: deserializeParam(
          data['storeName'],
          ParamType.String,
          false,
        ),
        storeAddress: deserializeParam(
          data['storeAddress'],
          ParamType.String,
          false,
        ),
        businessPhone: deserializeParam(
          data['businessPhone'],
          ParamType.String,
          false,
        ),
        businessEmail: deserializeParam(
          data['businessEmail'],
          ParamType.String,
          false,
        ),
        businessLicenseDocUrl: deserializeParam(
          data['businessLicenseDocUrl'],
          ParamType.String,
          false,
        ),
        utilityBillOrLeaseDocUrl: deserializeParam(
          data['utilityBillOrLeaseDocUrl'],
          ParamType.String,
          false,
        ),
        onlineDashboardScreenshotUrl: deserializeParam(
          data['onlineDashboardScreenshotUrl'],
          ParamType.String,
          false,
        ),
        storePhotoUrl: deserializeParam(
          data['storePhotoUrl'],
          ParamType.String,
          false,
        ),
        submissionDate: deserializeParam(
          data['submissionDate'],
          ParamType.DateTime,
          false,
        ),
        verificationStatus: deserializeParam(
          data['verificationStatus'],
          ParamType.String,
          false,
        ),
        placeID: deserializeParam(
          data['PlaceID'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['venues'],
        ),
      );

  @override
  String toString() => 'StoreOwnerInformationStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is StoreOwnerInformationStruct &&
        storeName == other.storeName &&
        storeAddress == other.storeAddress &&
        businessPhone == other.businessPhone &&
        businessEmail == other.businessEmail &&
        businessLicenseDocUrl == other.businessLicenseDocUrl &&
        utilityBillOrLeaseDocUrl == other.utilityBillOrLeaseDocUrl &&
        onlineDashboardScreenshotUrl == other.onlineDashboardScreenshotUrl &&
        storePhotoUrl == other.storePhotoUrl &&
        submissionDate == other.submissionDate &&
        verificationStatus == other.verificationStatus &&
        placeID == other.placeID;
  }

  @override
  int get hashCode => const ListEquality().hash([
        storeName,
        storeAddress,
        businessPhone,
        businessEmail,
        businessLicenseDocUrl,
        utilityBillOrLeaseDocUrl,
        onlineDashboardScreenshotUrl,
        storePhotoUrl,
        submissionDate,
        verificationStatus,
        placeID
      ]);
}

StoreOwnerInformationStruct createStoreOwnerInformationStruct({
  String? storeName,
  String? storeAddress,
  String? businessPhone,
  String? businessEmail,
  String? businessLicenseDocUrl,
  String? utilityBillOrLeaseDocUrl,
  String? onlineDashboardScreenshotUrl,
  String? storePhotoUrl,
  DateTime? submissionDate,
  String? verificationStatus,
  DocumentReference? placeID,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    StoreOwnerInformationStruct(
      storeName: storeName,
      storeAddress: storeAddress,
      businessPhone: businessPhone,
      businessEmail: businessEmail,
      businessLicenseDocUrl: businessLicenseDocUrl,
      utilityBillOrLeaseDocUrl: utilityBillOrLeaseDocUrl,
      onlineDashboardScreenshotUrl: onlineDashboardScreenshotUrl,
      storePhotoUrl: storePhotoUrl,
      submissionDate: submissionDate,
      verificationStatus: verificationStatus,
      placeID: placeID,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

StoreOwnerInformationStruct? updateStoreOwnerInformationStruct(
  StoreOwnerInformationStruct? storeOwnerInformation, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    storeOwnerInformation
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addStoreOwnerInformationStructData(
  Map<String, dynamic> firestoreData,
  StoreOwnerInformationStruct? storeOwnerInformation,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (storeOwnerInformation == null) {
    return;
  }
  if (storeOwnerInformation.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields = !forFieldValue &&
      storeOwnerInformation.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final storeOwnerInformationData = getStoreOwnerInformationFirestoreData(
      storeOwnerInformation, forFieldValue);
  final nestedData =
      storeOwnerInformationData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      storeOwnerInformation.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getStoreOwnerInformationFirestoreData(
  StoreOwnerInformationStruct? storeOwnerInformation, [
  bool forFieldValue = false,
]) {
  if (storeOwnerInformation == null) {
    return {};
  }
  final firestoreData = mapToFirestore(storeOwnerInformation.toMap());

  // Add any Firestore field values
  storeOwnerInformation.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getStoreOwnerInformationListFirestoreData(
  List<StoreOwnerInformationStruct>? storeOwnerInformations,
) =>
    storeOwnerInformations
        ?.map((e) => getStoreOwnerInformationFirestoreData(e, true))
        .toList() ??
    [];
