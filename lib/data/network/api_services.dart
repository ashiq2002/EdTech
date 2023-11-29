import 'dart:io';

import 'package:edtech/data/exceptions/app_exception.dart';
import 'package:edtech/data/network/api_dao.dart';
import 'package:edtech/util/dev.dart';
import 'package:http/http.dart' as http;

class ApiServices extends ApiDao {
  final Map<String, String> _header = {
    "Content-Type": "application/json",
    "Accept": "application/json",
  };

  @override
  Future getApi({required String url, Map<String, String>? headerParam}) async {
    devLog(tag: "GET", message: "url: $url header: $headerParam");

    dynamic responseJson;
    try {
      final response = await http
          .get(Uri.parse(url), headers: headerParam ?? _header)
          .timeout(const Duration(seconds: 30));
      responseJson = getResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet connection");
    }
    return responseJson;
  } //get api response

  //return api response
  dynamic getResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return response.body;

      case 400:
        throw BadRequestException(response.body.toString());

      case 404:
        throw UnauthorisedException(response.body.toString());

      default:
        throw Exception(
            "Error accrued while communicating with server\nStatus code : ${response.statusCode.toString()}");
    }
  }
}
