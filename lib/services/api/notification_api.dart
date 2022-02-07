import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wethepeople/globals/app_constants.dart';

Future<NotificationListResponse> createNotificationListState(context) async {
  final http.Response response = await http.post(
    Uri.parse(Constants.baseUrl),
    body: jsonEncode({"func_name": "notificationList", "data": {}}),
  );

  if (response.statusCode == 200) {
    Map<String, dynamic> notificationResponse = json.decode(response.body);
    print(notificationResponse);
    return NotificationListResponse.fromJson(notificationResponse);
  } else {
    throw Exception('Failed to create album.');
  }
}

class NotificationListResponse {
  String message = "";
  List data = [];

  NotificationListResponse([message, data]);

  NotificationListResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'];
  }
}
