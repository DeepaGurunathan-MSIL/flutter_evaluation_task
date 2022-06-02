
// Watchlist api request

import 'dart:io';
import 'dart:convert';

import 'package:flutter_evaluation_task/model/login_response.dart';
import 'package:flutter_evaluation_task/model/otp.dart';

import '../constants/constants.dart';
import '../model/watchlist.dart';

class DataApiCall {

  var client = HttpClient();

  Future <WatchList> fetchWatchlist() async {
    try {
      HttpClientRequest request = await client.getUrl(Uri.parse(Constants.watchlistUrl));
      HttpClientResponse response = await request.close();
      final stringData = await response.transform(utf8.decoder).join();
      if (response.statusCode == 200) {
        return WatchList.fromJson(json.decode(stringData));
      } else {
        throw Exception(Constants.networkError);
      }
    } finally {
      client.close();
    }
  }

  Future <Otp> fetchOTP(String number) async {
    try {
      final request = await client.postUrl(Uri.parse(Constants.otpUrl));
      request.headers.set(HttpHeaders.contentTypeHeader, "application/json; charset=UTF-8");
      request.headers.set('X-ENCRYPT', 'false');
      request.write('{"request":{"data":{"mobNo":"'+number+'"},"appID":"f79f65f1b98e116f40633dbb46fd5e21"}}');
      HttpClientResponse response = await request.close();
      final stringData = await response.transform(utf8.decoder).join();
      if (response.statusCode == 200) {
        return Otp.fromJson(json.decode(stringData));
      } else {
        throw Exception(Constants.networkError);
      }
    } finally {
      client.close();
    }
  }

  Future <LoginResponse> fetchLoginResponse(String otp,String number) async {
    try {
      final request = await client.postUrl(Uri.parse(Constants.loginUrl));
      request.headers.set(HttpHeaders.contentTypeHeader, "application/json; charset=UTF-8");
      request.headers.set('X-ENCRYPT', 'false');
      request.write('{"request":{"data":{"mobNo":"'+number+'","userType":"virtual","otp":"'+otp+'"},"appID":"f79f65f1b98e116f40633dbb46fd5e21"}}');
      HttpClientResponse response = await request.close();
      final stringData = await response.transform(utf8.decoder).join();
      if (response.statusCode == 200) {
        return LoginResponse.fromJson(json.decode(stringData));
      } else {
        throw Exception(Constants.networkError);
      }
    } finally {
      client.close();
    }
  }

}