class OrderModel {
    final int? id;
    final String? customerName;
    final String? status;
    final String? total;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? user;
    final int? table;

    OrderModel({
        this.id,
        this.customerName,
        this.status,
        this.total,
        this.createdAt,
        this.updatedAt,
        this.user,
        this.table,
    });

    OrderModel copyWith({
        int? id,
        String? customerName,
        String? status,
        String? total,
        DateTime? createdAt,
        DateTime? updatedAt,
        int? user,
        int? table,
    }) => 
        OrderModel(
            id: id ?? this.id,
            customerName: customerName ?? this.customerName,
            status: status ?? this.status,
            total: total ?? this.total,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            user: user ?? this.user,
            table: table ?? this.table,
        );

    factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json["id"],
        customerName: json["customer_name"],
        status: json["status"],
        total: json["total"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        user: json["user"],
        table: json["table"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "customer_name": customerName,
        "status": status,
        "total": total,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "user": user,
        "table": table,
    };
}
