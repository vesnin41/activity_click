import 'package:activity_click/models/activity_model.dart';
import 'package:activity_click/utilities/api/api_service.dart';
import 'package:flutter/foundation.dart';

class ActivityDataProvider with ChangeNotifier {
  List<ActivityModel?> listOfActivityModels = [];
  bool loading = false;
  void getData() async {
    loading = true;
    notifyListeners();
    try {
      ActivityModel? model = await ApiService().getActivity();
      listOfActivityModels.add(model);
    } catch (e) {
      print(e);
    }
    loading = false;
    notifyListeners();
  }

  void clearData() {
    listOfActivityModels.clear();
    notifyListeners();
  }

  void likeActivity(ActivityModel activity) {
    activity.likeActivity();
    notifyListeners();
  }

  void unlikeActivity(ActivityModel activity) {
    activity.unlikeActivity();
    notifyListeners();
  }

  void clearFavorites() {
    for (var element in listOfActivityModels) {
      element!.unlikeActivity();
    }
    notifyListeners();
  }

  void deleteActivity(ActivityModel activity) {
    listOfActivityModels.remove(activity);
    notifyListeners();
  }
}
