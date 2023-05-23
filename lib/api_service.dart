import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:activity_click/constans.dart';
import 'package:activity_click/activity_model.dart';

class ApiService {
  Future<ActivityModel?> getActivity() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.usersEndpoint);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        ActivityModel model =
            ActivityModel.fromJson(json.decode(response.body));
        return model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
