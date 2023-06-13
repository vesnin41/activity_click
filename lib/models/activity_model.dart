class ActivityModel {
  String activity;
  String type;
  int participants;
  num price;
  String link;
  String key;
  num accessibility;
  bool isFavorite = false;

  ActivityModel({
    required this.activity,
    required this.type,
    required this.participants,
    required this.price,
    required this.link,
    required this.key,
    required this.accessibility,
  });

  factory ActivityModel.fromJson(Map<String, dynamic> json) => ActivityModel(
        activity: json["activity"] ?? '',
        type: json["type"] ?? '',
        participants: json["participants"] ?? 0,
        price: json["price"] ?? 0.0,
        link: json["link"] ?? '',
        key: json["key"] ?? '',
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
