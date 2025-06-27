class CastModel{
final int? id;
final String? name;
final String? profile_path;
final String? department;
final String? character;

  CastModel({required this.id, required this.name,required this.character, required this.profile_path, required this.department});
  factory CastModel.fromJson(Map<String, dynamic> json) {
    return CastModel(
      id: json['id'],
      name: json['name'],
      profile_path: json['profile_path'],
      character: json['character'],
      department: json['known_for_department'],
    );
  }
}