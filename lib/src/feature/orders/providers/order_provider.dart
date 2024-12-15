import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:polleria_app/src/feature/orders/models/order_model.dart';
import 'package:polleria_app/src/feature/tables/models/tables_model.dart';
import 'package:polleria_app/src/feature/orders/repositories/order_repositories.dart';

final orderNotifier =
    StateNotifierProvider.autoDispose<OrderNotifier, OrderState>(
  (ref) {
    final repo = ref.read(orderRepositories);
    return OrderNotifier(
      orderRepositories: repo,
    );
  },
);

final comboTables = FutureProvider.autoDispose<List<TablesModel>>(
  (ref) async {
    final repoOrder = ref.read(orderRepositories);
    final listModels = await repoOrder.getComboTables();
    return listModels.data;
  },
);

class OrderNotifier extends StateNotifier<OrderState> {
  final OrderRepositories orderRepositories;
  OrderNotifier({
    required this.orderRepositories,
  }) : super(OrderState());

  Future<void> inserOrder({
    required int tableId,
    required String nameClient,
  }) async {
    final formData = {
      "customer_name": nameClient,
      "total": "0",
      "status": "standby",
      "table": tableId
    };

    state = state.copyWith(isLoading: true, status: null);
    final result = await orderRepositories.registerOrder(formData: formData);
    if (result.isFailure) {
      state = state.copyWith(isLoading: false, isError: true);
      return;
    }
    state = state.copyWith(
      isLoading: false,
      status: true,
      order: result.data,
    );
  }

  Future<void> listOrders() async {
    state = state.copyWith(isLoading: true, status: null);
    await Future.delayed(const Duration(milliseconds: 500));
    final result = await orderRepositories.listOrders();
    if (result.isFailure) {
      state = state.copyWith(isLoading: false, isError: true);
      return;
    }
    state = state.copyWith(
      isLoading: false,
      status: true,
      listOrders: result.data,
    );
  }

  Future<void> removeOrder({
    required int? idOrder,
  }) async {
    state = state.copyWith(isLoading: true, status: null);
    await Future.delayed(const Duration(milliseconds: 500));
    final result = await orderRepositories.deleteOrder(
      idOrder: idOrder.toString(),
    );

    if (result.isFailure) {
      state = state.copyWith(isLoading: false, isError: true);
      return;
    }

    await listOrders();
  }

  Future<void> updateOrder({
    required OrderModel order,
  }) async {
    state = state.copyWith(isLoading: true, status: null);
    await Future.delayed(const Duration(milliseconds: 500));
    final result = await orderRepositories.updateOrder(
      idOrder: order.id.toString(),
      formData: order.toJson(),
    );

    if (result.isFailure) {
      state = state.copyWith(isLoading: false, isError: true);
      return;
    }

    await listOrders();
  }
}

class OrderState {
  final bool? status;
  final OrderModel? order;
  final List<OrderModel>? listOrders;
  final bool isLoading;
  final bool isError;

  OrderState({
    this.status,
    this.order,
    this.listOrders,
    this.isLoading = true,
    this.isError = false,
  });

  OrderState copyWith({
    bool? status,
    OrderModel? order,
    bool? isLoading,
    List<OrderModel>? listOrders,
    bool? isError,
  }) {
    return OrderState(
      status: status,
      listOrders: listOrders ?? this.listOrders,
      order: order ?? this.order,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
    );
  }
}
