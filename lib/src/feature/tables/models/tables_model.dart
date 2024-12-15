class TablesModel {
    final int? id;
    final String? tableNumber;
    final int? capacity;
    final String? status;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    TablesModel({
        this.id,
        this.tableNumber,
        this.capacity,
        this.status,
        this.createdAt,
        this.updatedAt,
    });

    TablesModel copyWith({
        int? id,
        String? tableNumber,
        int? capacity,
        String? status,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) => 
        TablesModel(
            id: id ?? this.id,
            tableNumber: tableNumber ?? this.tableNumber,
            capacity: capacity ?? this.capacity,
            status: status ?? this.status,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );

    factory TablesModel.fromJson(Map<String, dynamic> json) => TablesModel(
        id: json["id"],
        tableNumber: json["table_number"],
        capacity: json["capacity"],
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "table_number": tableNumber,
        "capacity": capacity,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
