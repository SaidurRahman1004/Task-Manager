import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class Networkcaller {
  // GET Request
  static Future<NetworkResponse> getRequest(String url) async {
    try {
      Uri uri = Uri.parse(url); // Parse the URL
      _logRequest(url); // Log the request

      Response response = await get(
        uri,
      ); // Send GET request and await for response
      _logResponse(url, response); // Log the response

      final decodedData = jsonDecode(response.body); // Decode JSON response
      if (response.statusCode == 200) {
        return NetworkResponse(
          isSuuccess: true,
          responseCode: response.statusCode,
          body: decodedData,
        );
      } else {
        return NetworkResponse(
          isSuuccess: false,
          responseCode: response.statusCode,
          errorMassage: decodedData['data'],
        ); // If error occurs, the 'data' field from decodedData is being taken as errorMessage
      }
    } catch (e) {
      return NetworkResponse(
        isSuuccess: false,
        responseCode: -1,
        errorMassage: e.toString(),
      ); // In case of exception, return -1 as response code and exception message as errorMessage
    }
  }

  // POST Request with optional body Arguments
  static Future<NetworkResponse> postRequest(
    String url, {
    Map<String, dynamic>? body,
  }) async {
    try {
      Uri uri = Uri.parse(url);
      _logRequest(url, body: body); // Log the request with body
      Response response = await post(
        uri,
        headers: {'Content-Type': 'application/json'},
        // Set content type to JSON
        body: jsonEncode(body), // Encode body to JSON
      );
      _logResponse(url, response); // Log the response

      final decodedData = jsonDecode(response.body); // Decode JSON response
      if (response.statusCode == 200) {
        return NetworkResponse(
          isSuuccess: true,
          responseCode: response.statusCode,
          body: decodedData,
        );
      } else {
        return NetworkResponse(
          isSuuccess: false,
          responseCode: response.statusCode,
          errorMassage: decodedData['data'],
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuuccess: false,
        responseCode: -1,
        errorMassage: e.toString(),
      );
    }
  }

  // Logging function Request for debugging only For Testing Purpose
  static void _logRequest(String url,{ Map<String, dynamic>? body}){
    debugPrint(
      'Url: $url\n'
          'Body: $body'
    );
  }

  static void _logResponse(String url, Response response){
    debugPrint(
      'URL: $url\n'
          'Status Code: ${response.statusCode}\n'
          'Body: ${response.body}',
    );
  }
}

//Model class
class NetworkResponse {
  final bool isSuuccess; // To check if request is success or failed
  final int responseCode; // HTTP Response code
  final dynamic body; //Data from Server if seccess
  final String errorMassage;

  NetworkResponse({
    required this.isSuuccess,
    required this.responseCode,
    this.body,
    this.errorMassage = "Something went wrong!", // Default error message
  });
}
