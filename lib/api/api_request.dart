import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:crypto_flutter/api/api.dart';
import 'package:crypto_flutter/shared/constants/constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'api_exception.dart';

Future fetch(
    {url = '',
    method = 1,
    Map<String, String>? headers,
    body,
    newUrl,
    needKey = false,
    needAutoHeader = true,
    Map<String, dynamic>? queryParams,
    bool needReturnErrorCode = false}) async {
  var storage = Get.find<SharedPreferences>();
  var defaultsUrl = ApiConstans.baseUrl;
  if (url != '' && url.indexOf('http://') < 0 && url.indexOf('https://') < 0) {
    defaultsUrl = ApiConstans.baseUrl;
  }
  if (newUrl != null) {
    defaultsUrl = newUrl;
  }
  headers ??= {};
  if (headers['Content-Type'] == null) {
    headers['Content-Type'] = 'application/json';
  }
  if (!needKey) {
    headers = {
      'X-CMC_PRO_API_KEY': ApiConstans.keyId,
      "Accept": "application/json",
    };
  }
  if (needAutoHeader && headers['authorization'] == null) {
    try {
      headers['authorization'] =
          (storage.getString(SharePreferencesConstants.token))!;
    } catch (err) {
      print(err);
    }
  }
  // print("fetch to url " + baseUrl + url + ' headers=' + jsonEncode(headers));
  try {
    if (method == 1) {
      // post
      http.Response response = await http
          .post(Uri.parse(defaultsUrl + url),
              headers: headers, body: body != null ? jsonEncode(body) : '')
          .timeout(const Duration(milliseconds: 7000), onTimeout: () {
        return http.Response('time out', 400);
      });

      if (response.statusCode == 200) {
        // print('body 200 ' + response.body + ' from url ' + url);
        return jsonDecode(response.body);
      } else {
        if (response.statusCode == 400) {
          print('body 400 ' + response.body + ' from url ' + url);
          if (needReturnErrorCode) {
            return jsonDecode(response.body);
          }
        }
        print('print $headers');
        throw Exception('Failed to load data from ' + url);
      }
    } else if (method == 3) {
      // path
      http.Response response = await http.patch(Uri.parse(defaultsUrl + url),
          headers: headers, body: body);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to patch');
      }
    } else if (method == 4) {
      // delete
      var request = http.Request('DELETE', Uri.parse(defaultsUrl + url));
      request.body = body;
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        return response.stream;
      } else {
        throw Exception('Failed to load data from ' + url);
      }
    } else {
      // get

      Uri uri = Uri.parse(defaultsUrl + url);
      final finalUri = uri.replace(queryParameters: queryParams);
      
      http.Response response = await http
          .get(
        finalUri,
        headers: headers,
      )
          .timeout(const Duration(milliseconds: 7000), onTimeout: () {
        return http.Response('time out', 400);
      });
      var responseJson = _response(response);

      return responseJson;
    }
  } on TimeoutException catch (e) {
    print('Timeout Error: $e');
  } on SocketException {
    throw FetchDataException('No Internet connection');
  } on Error catch (e) {
    print('General Error: $e');
  }
}

dynamic _response(http.Response response) {
  switch (response.statusCode) {
    case 200:
      return jsonDecode(response.body);
    case 404:
      throw BadRequestException(response.body.toString());
    case 400:
      print('debugging');
      throw TimeOutException("");
    case 403:
      throw UnauthorisedException(response.body.toString());
    case 500:
    default:
      throw FetchDataException(
          'Error occured while Communication with Server with StatusCode: ${response.statusCode}');
  }
}
