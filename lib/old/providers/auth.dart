import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:loan_app/old/data/data.dart';
import 'package:loan_app/old/models/server_response.dart';
import 'package:loan_app/old/models/user.dart';

class AuthLogic with ChangeNotifier {
  final String? _uri = checkUrl();

  Future<ServerResponse> login(User user) async {
    final prefs = await SharedPreferences.getInstance();

    final fbm = FirebaseMessaging.instance;
    final devicetoken = await fbm.getToken();
    print(devicetoken);

    try {
      final response = await http.post(
        uriConverter(_uri! + '/auth/login'),
        body: jsonEncode({
          'username': user.username,
          'password': user.password,
          'devicetoken': devicetoken,
          'model': Platform.isAndroid ? 'Android' : 'iOS'
        }),
        headers: {'Content-Type': 'application/json'},
      );
      print(jsonDecode(response.body));
      final responseData = jsonDecode(response.body) as Map<String, dynamic>;

      if (responseData['status']) {
        final String userToken = responseData['type'] + responseData['token'];
        final Map<String, dynamic> extractedData =
            JwtDecoder.decode(responseData['token']);
        print(extractedData);

        await prefs.setString('userid', extractedData['userid']);
        await prefs.setString('username', extractedData['username']);
        await prefs.setString('fname', extractedData['fname']);
        await prefs.setString('lname', extractedData['lname']);
        await prefs.setString('roleuserid', extractedData['roleuserid']);
        await prefs.setString('logactivityid', extractedData['logactivityid']);
        await prefs.setString('token', userToken);
      }

      return ServerResponse(
        status: responseData['status'],
        message: responseData['message'],
      );
    } catch (e) {
      print(e);
      return ServerResponse(
        status: false,
        message: 'Something went wrong. Please try again later',
      );
    }
  }
}
