import 'package:hive/hive.dart';
part 'activity_model.g.dart';

@HiveType(typeId: 0)
class ActivityModel extends HiveObject {
  @HiveField(0)
  String activity;
  @HiveField(1)
  String type;
  @HiveField(2)
  int participants;
  @HiveField(3)
  num price;
  @HiveField(4)
  String link;
  @HiveField(5)
  String akey;
  @HiveField(6)
  num accessibility;
  @HiveField(7)
  bool isFavorite = false;

  ActivityModel({
    required this.activity,
    required this.type,
    required this.participants,
    required this.price,
    required this.link,
    required this.akey,
    required this.accessibility,
  });

  factory ActivityModel.fromJson(Map<String, dynamic> json) => ActivityModel(
        activity: json["activity"] ?? '',
        type: json["type"] ?? '',
        participants: json["participants"] ?? 0,
        price: json["price"] ?? 0.0,
        link: json["link"] ?? '',
        akey: json["key"] ?? '',
        accessibility: json["accessibility"] ?? 0.0,
      );

  Map<String, dynamic> toJson() => {
        "activity": activity,
        "type": type,
        "participants": participants,
        "price": price,
        "link": link,
        "key": key,
        "accessibility": accessibility,
      };

  void likeActivity() {
    isFavorite = true;
  }

  void unlikeActivity() {
    isFavorite = false;
  }
}
