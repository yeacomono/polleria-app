class UserItemModel {
  final int? id;
  final String? name;
  final String? email;
  final String? password;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? role;

  UserItemModel({
    this.id,
    this.name,
    this.email,
    this.password,
    this.createdAt,
    this.updatedAt,
    this.role,
  });

  UserItemModel copyWith({
    int? id,
    String? name,
    String? email,
    String? password,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? role,
  }) =>
      UserItemModel(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        password: password ?? this.password,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        role: role ?? this.role,
      );

  factory UserItemModel.fromJson(Map<String, dynamic> json) => UserItemModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "password": password,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "role": role,
      };
}
