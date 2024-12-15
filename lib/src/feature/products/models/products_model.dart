class ProductModel {
  final int? id;
  final String? name;
  final String? description;
  final String? price;
  final bool? isCombo;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ProductModel({
    this.id,
    this.name,
    this.description,
    this.price,
    this.isCombo,
    this.createdAt,
    this.updatedAt,
  });

  ProductModel copyWith({
    int? id,
    String? name,
    String? description,
    String? price,
    bool? isCombo,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      ProductModel(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        price: price ?? this.price,
        isCombo: isCombo ?? this.isCombo,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        isCombo: json["is_combo"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "price": price,
        "is_combo": isCombo,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
