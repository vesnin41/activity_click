import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:activity_click/utilities/api/constans.dart';
import 'package:activity_click/models/activity_model.dart';

class ApiService {
  Future<ActivityModel?> getActivity() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.usersEndpoint);
      var response = await http.get(url);

      if (response.statusCode == 200) {
        ActivityModel model =
            ActivityModel.fromJson(json.decode(response.body));
        print(json.decode(response.body));
        return model;
      } else {
        throw Exception('Failed to load');
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
