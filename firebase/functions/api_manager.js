const axios = require("axios").default;
const qs = require("qs");

async function _fetchVenuesCall(context, ffVariables) {
  var location = ffVariables["location"];
  var radius = ffVariables["radius"];

  var url = `https://maps.googleapis.com/maps/api/place/nearbysearch/json`;
  var headers = {};
  var params = {
    location: location,
    radius: radius,
    type: `bar`,
    keyword: `live music`,
    key: `AIzaSyCmChbqubBkmA0O_ikMHT0yH5i_Jx_LnlU`,
  };
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "get",
    url,
    headers,
    params,
    returnBody: true,
    isStreamingApi: false,
  });
}
async function _fetchPlaceDetailsCall(context, ffVariables) {
  var placeId = ffVariables["placeId"];

  var url = `https://maps.googleapis.com/maps/api/place/details/json?&fields=name,formatted_address,formatted_phone_number,website,opening_hours,rating,user_ratings_total,photo,business_status&key=AIzaSyCmChbqubBkmA0O_ikMHT0yH5i_Jx_LnlU`;
  var headers = {};
  var params = { place_id: placeId };
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "get",
    url,
    headers,
    params,
    returnBody: true,
    isStreamingApi: false,
  });
}

/// Helper functions to route to the appropriate API Call.

async function makeApiCall(context, data) {
  var callName = data["callName"] || "";
  var variables = data["variables"] || {};

  const callMap = {
    FetchVenuesCall: _fetchVenuesCall,
    FetchPlaceDetailsCall: _fetchPlaceDetailsCall,
  };

  if (!(callName in callMap)) {
    return {
      statusCode: 400,
      error: `API Call "${callName}" not defined as private API.`,
    };
  }

  var apiCall = callMap[callName];
  var response = await apiCall(context, variables);
  return response;
}

async function makeApiRequest({
  method,
  url,
  headers,
  params,
  body,
  returnBody,
  isStreamingApi,
}) {
  return axios
    .request({
      method: method,
      url: url,
      headers: headers,
      params: params,
      responseType: isStreamingApi ? "stream" : "json",
      ...(body && { data: body }),
    })
    .then((response) => {
      return {
        statusCode: response.status,
        headers: response.headers,
        ...(returnBody && { body: response.data }),
        isStreamingApi: isStreamingApi,
      };
    })
    .catch(function (error) {
      return {
        statusCode: error.response.status,
        headers: error.response.headers,
        ...(returnBody && { body: error.response.data }),
        error: error.message,
      };
    });
}

const _unauthenticatedResponse = {
  statusCode: 401,
  headers: {},
  error: "API call requires authentication",
};

function createBody({ headers, params, body, bodyType }) {
  switch (bodyType) {
    case "JSON":
      headers["Content-Type"] = "application/json";
      return body;
    case "TEXT":
      headers["Content-Type"] = "text/plain";
      return body;
    case "X_WWW_FORM_URL_ENCODED":
      headers["Content-Type"] = "application/x-www-form-urlencoded";
      return qs.stringify(params);
  }
}

module.exports = { makeApiCall };
