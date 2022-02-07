import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wethepeople/globals/app_constants.dart';

Future<FCMTokenResponse> createFCMTokenState(String token) async {
  final http.Response response = await http.post(Uri.parse(Constants.baseUrl),
      body: jsonEncode({
        "func_name": "addDevice",
        "data": {
          "devicetoken": token,
          "devicetype": "android",
          "deviceid": "12321342"
        }
      }));

  if (response.statusCode == 200) {
    dynamic fcmResponse = json.decode(response.body);
    String message = fcmResponse['message'];
    // Provider.of<FCMTokenResponse>(context, listen: false).addData(data);
    debugPrint('token registration:' + message);
    return FCMTokenResponse.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to create album.');
  }
}

class FCMTokenResponse with ChangeNotifier {
  String? message;

  FCMTokenResponse([message]);

  FCMTokenResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    notifyListeners();
  }
}
