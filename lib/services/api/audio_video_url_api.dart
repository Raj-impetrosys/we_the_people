import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wethepeople/globals/app_constants.dart';

Future<AudioVideoListResponse> createAudioVideoListState() async {
  final http.Response response = await http.post(Uri.parse(Constants.baseUrl),
      body: jsonEncode({"func_name": "audiovideolist", "data": {}}));

  if (response.statusCode == 200) {
    dynamic data = json.decode(response.body);
    // Map data = adResponse['data'];
    // String message = adResponse['message'];
    // Provider.of<AudioVideoListResponse>(context, listen: false).addData(data);
    // print(message);
    return AudioVideoListResponse.fromJson(data);
  } else {
    throw Exception('Failed to create album.');
  }
}

class AudioVideoListResponse {
  String message;
  Map data = {};

  AudioVideoListResponse([this.message, this.data]);

  AudioVideoListResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'];
    // notifyListeners();
  }

  // addData(data) {
  //   this.data = data;
  //   notifyListeners();
  // }
}
