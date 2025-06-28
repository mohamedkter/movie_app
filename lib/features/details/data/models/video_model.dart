class VideoModel {
  final String name;
  final String key;
  final String site;
  final int size;
  final String type;

  VideoModel({
    required this.name,
    required this.key,
    required this.site,
    required this.size,
    required this.type,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      name: json['name'],
      key: json['key'],
      site: json['site'],
      size: json['size'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'key': key,
      'site': site,
      'size': size,
      'type': type,
    };
  }
}
