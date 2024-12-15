class UserModel {
  final int? id;
  final String? name;
  final String? email;
  final String? role;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.role,
  });

  UserModel copyWith({
    int? id,
    String? name,
    String? email,
    String? role,
  }) =>
      UserModel(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        role: role ?? this.role,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "role": role,
      };
}
