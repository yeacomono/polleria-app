class RoleModel {
  final int? id;
  final String? name;
  final String? description;

  RoleModel({
    this.id,
    this.name,
    this.description,
  });

  RoleModel copyWith({
    int? id,
    String? name,
    String? description,
  }) =>
      RoleModel(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
      );

  factory RoleModel.fromJson(Map<String, dynamic> json) => RoleModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
      };
}
