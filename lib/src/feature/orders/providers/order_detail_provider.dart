import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:polleria_app/src/feature/orders/models/order_item_model.dart';
import 'package:polleria_app/src/feature/orders/models/order_model.dart';
import 'package:polleria_app/src/feature/orders/repositories/order_repositories.dart';
import 'package:polleria_app/src/feature/products/models/products_model.dart';
import 'package:polleria_app/src/feature/products/repositories/products_repository.dart';

final orderDetailNotifier =
    StateNotifierProvider.autoDispose<OrderDetailNotifier, OrderDetailSate>(
  (ref) {
    final repoOrder = ref.read(orderRepositories);
    return OrderDetailNotifier(
      orderRepositories: repoOrder,
    );
  },
);

final productsCombo = FutureProvider<List<ProductModel>>(
  (ref) async {
    final repo = ref.read(productsRepository);
    final result = await repo.listAllProducts();
    return result.data;
  },
);

class OrderDetailNotifier extends StateNotifier<OrderDetailSate> {
  final OrderRepositories orderRepositories;
  OrderDetailNotifier({required this.orderRepositories})
      : super(OrderDetailSate());

  @override
  void dispose() {
    state = state.copyWith(orderModel: null);
    super.dispose();
  }

  Future<void> insertOrderItem(
      {required ProductModel product,
      required int orderID,
      required int quantity}) async {
    final formData = {
      "quantity": quantity,
      "subtotal": quantity * double.parse(product.price ?? "0.0"),
      "order": orderID,
      "product": product.id,
    };
    state = state.copyWith(
      isLoading: true,
      isLoadingListOrders: true,
      status: null,
    );
    await Future.delayed(const Duration(milliseconds: 500));
    final result = await orderRepositories.registerItemOrder(
      formData: formData,
    );
    if (result.isFailure) {
      state = state.copyWith(
        isLoading: false,
        isLoadingListOrders: false,
        isError: true,
        status: false,
      );
      return;
    }
    state = state.copyWith(
        isLoading: false,
        isLoadingListOrders: false,
        isError: false,
        status: true,
        order: result.data,
        listOrders: [
          result.data,
          ...state.listOrders ?? [],
        ]);
    return;
  }

  Future<void> deleteOrderItem({
    required int orderID,
    required int orderItemID,
  }) async {
    state = state.copyWith(isLoading: true, status: null);
    await Future.delayed(const Duration(milliseconds: 500));
    final result = await orderRepositories.deleteOrderItem(
        idOrder: orderItemID.toString());
    if (result.isFailure) {
      state = state.copyWith(
        isLoading: false,
        isError: true,
        status: false,
      );
      return;
    }
    await getOrderById(orderID: orderID);
    await listOrderItembyOrderID(orderID: orderID);
    return;
  }

  Future<void> getOrderById({
    required int orderID,
  }) async {
    state = state.copyWith(isLoadingOrder: true, status: null);
    final result = await orderRepositories.getOrderByID(orderID);
    if (result.isFailure) {
      state = state.copyWith(isLoadingOrder: false);
      return;
    }
    state = state.copyWith(isLoadingOrder: false, orderModel: result.data);
    return;
  }

  void updateOrderModelTotalCount(OrderModel orderModel) {
    state = state.copyWith(orderModel: orderModel);
  }

  Future<void> listOrderItembyOrderID({
    required int orderID,
  }) async {
    final formData = {
      "order_id": orderID,
    };
    state = state.copyWith(isLoadingListOrders: true, status: null);
    await Future.delayed(const Duration(milliseconds: 500));
    final result = await orderRepositories.listOrderItembyOrderID(
      formData: formData,
    );
    if (result.isFailure) {
      state = state.copyWith(
        isLoadingListOrders: false,
        isError: true,
        status: false,
      );
      return;
    }
    state = state.copyWith(
      isLoadingListOrders: false,
      isError: false,
      status: true,
      listOrders: result.data,
    );
    return;
  }
}

class OrderDetailSate {
  final bool? status;
  final List<OrderItemModel>? listOrders;
  final OrderItemModel? order;
  final OrderModel? orderModel;
  final bool isLoading;
  final bool isLoadingListOrders;
  final bool isError;
  final bool isLoadingOrder;

  OrderDetailSate({
    this.status,
    this.order,
    this.listOrders,
    this.orderModel,
    this.isLoading = true,
    this.isLoadingListOrders = true,
    this.isLoadingOrder = true,
    this.isError = false,
  });

  OrderDetailSate copyWith({
    bool? status,
    OrderItemModel? order,
    bool? isLoading,
    OrderModel? orderModel,
    List<OrderItemModel>? listOrders,
    bool? isLoadingListOrders,
    bool? isLoadingOrder,
    bool? isError,
  }) {
    return OrderDetailSate(
      status: status,
      order: order ?? this.order,
      listOrders: listOrders ?? this.listOrders,
      isLoadingListOrders: isLoadingListOrders ?? this.isLoadingListOrders,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      isLoadingOrder: isLoadingOrder ?? this.isLoadingOrder,
      orderModel: orderModel ?? this.orderModel,
    );
  }
}
