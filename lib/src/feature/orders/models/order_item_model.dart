class OrderItemModel {
  final int? id;
  final int? quantity;
  final String? subtotal;
  final int? order;
  final int? product;
  final String? productName;

  OrderItemModel({
    this.id,
    this.quantity,
    this.productName,
    this.subtotal,
    this.order,
    this.product,
  });

  OrderItemModel copyWith({
    int? id,
    int? quantity,
    String? subtotal,
    String? productName,
    int? order,
    int? product,
  }) =>
      OrderItemModel(
        id: id ?? this.id,
        quantity: quantity ?? this.quantity,
        subtotal: subtotal ?? this.subtotal,
        order: order ?? this.order,
        productName: productName ?? this.productName,
        product: product ?? this.product,
      );

  factory OrderItemModel.fromJson(Map<String, dynamic> json) => OrderItemModel(
        id: json["id"],
        quantity: json["quantity"],
        subtotal: json["subtotal"],
        order: json["order"],
        productName: json["product_name"]??"",
        product: json["product"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "quantity": quantity,
        "subtotal": subtotal,
        "productName": productName,
        "order": order,
        "product": product,
      };
}
