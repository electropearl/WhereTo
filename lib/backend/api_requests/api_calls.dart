import 'dart:convert';
import '../cloud_functions/cloud_functions.dart';

import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall2';

class FetchVenuesCall {
  static Future<ApiCallResponse> call({
    String? location = '',
    int? radius = 100,
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'FetchVenuesCall',
        'variables': {
          'location': location,
          'radius': radius,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }

  static List? geomLocation(dynamic response) => getJsonField(
        response,
        r'''$.results[:].geometry.location''',
        true,
      ) as List?;
  static List? results(dynamic response) => getJsonField(
        response,
        r'''$.results''',
        true,
      ) as List?;
  static String? placeID(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.results[:].place_id''',
      ));
}

class FetchPlaceDetailsCall {
  static Future<ApiCallResponse> call({
    String? placeId,
  }) async {
    placeId ??= '';

    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'FetchPlaceDetailsCall',
        'variables': {
          'placeId': placeId,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }

  static String? website(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.result.website''',
      ));
  static String? phone(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.result.formatted_phone_number''',
      ));
  static String? address(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.result.formatted_address''',
      ));
  static int? ratingAmount(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.result.user_ratings_total''',
      ));
  static double? rating(dynamic response) => castToType<double>(getJsonField(
        response,
        r'''$.result.rating''',
      ));
  static List<String>? photoRef(dynamic response) => (getJsonField(
        response,
        r'''$.result.photos[:].photo_reference''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List? photo(dynamic response) => getJsonField(
        response,
        r'''$.result.photos''',
        true,
      ) as List?;
  static List<String>? weekdaytext(dynamic response) => (getJsonField(
        response,
        r'''$.result.opening_hours.weekday_text''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  if (item is DocumentReference) {
    return item.path;
  }
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}
