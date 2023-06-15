import 'dart:collection';

import 'package:activity_click/models/activity_model.dart';
import 'package:activity_click/utilities/api/api_service.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

class ActivityDataProvider with ChangeNotifier {
  List<ActivityModel?> _listOfActivityModels = [];
  List<ActivityModel?> _listOfFavoriteActivities = [];

  ActivityModel? _model;

  List<ActivityModel?> get listOfActivityModels {
    return _listOfActivityModels;
  }

  List<ActivityModel?> get listOfFavoriteActivities {
    return _listOfFavoriteActivities;
  }

  ActivityModel? get model {
    return _model;
  }

  final String activityDataHiveBox = 'activity-box';
  bool loading = false;

  Future<void> getData() async {
    loading = true;
    notifyListeners();
    Box<ActivityModel?> box =
        await Hive.openBox<ActivityModel>(activityDataHiveBox);
    try {
      _model = await ApiService().getActivity();
      await box.add(_model);
      _listOfActivityModels.add(_model);
      _listOfActivityModels = box.values.toList();
    } catch (e) {
      print(e);
    }
    loading = false;
    notifyListeners();
  }

  Future<void> getActivitiesDB() async {
    Box<ActivityModel?> box =
        await Hive.openBox<ActivityModel>(activityDataHiveBox);
    _listOfActivityModels = box.values.toList();
    notifyListeners();
  }

  Future<void> getFavoriteActivitiesDB() async {
    Box<ActivityModel?> box =
        await Hive.openBox<ActivityModel>(activityDataHiveBox);

    _listOfFavoriteActivities =
        box.values.where((element) => element!.isFavorite == true).toList();
    notifyListeners();
  }

  Future<void> clearData() async {
    Box<ActivityModel?> box =
        await Hive.openBox<ActivityModel>(activityDataHiveBox);
    await box.clear();
    _listOfActivityModels = box.values.toList();
    _model = null;
    notifyListeners();
  }

  Future<void> likeActivity(ActivityModel activity) async {
    Box<ActivityModel?> box =
        await Hive.openBox<ActivityModel>(activityDataHiveBox);
    activity.likeActivity();
    await box.put(activity.key, activity);
    notifyListeners();
  }

  Future<void> unlikeActivity(ActivityModel activity) async {
    Box<ActivityModel?> box =
        await Hive.openBox<ActivityModel>(activityDataHiveBox);
    activity.unlikeActivity();
    await box.put(activity.key, activity);
    notifyListeners();
  }

  Future<void> clearFavorites() async {
    Box<ActivityModel?> box =
        await Hive.openBox<ActivityModel>(activityDataHiveBox);
    for (var activity in _listOfActivityModels) {
      activity!.unlikeActivity();
      await box.put(activity.key, activity);
    }
    notifyListeners();
  }

  Future<void> deleteActivity(ActivityModel activity) async {
    Box<ActivityModel?> box =
        await Hive.openBox<ActivityModel>(activityDataHiveBox);
    await box.delete(activity.key);
    _listOfActivityModels = box.values.toList();
    notifyListeners();
  }
}
