import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:polleria_app/src/core/utils/api_client.dart';
import 'package:polleria_app/src/feature/auth/login_provider.dart';
import 'package:polleria_app/src/feature/auth/models/user_model.dart';
import 'package:polleria_app/src/feature/orders/models/order_item_model.dart';
import 'package:polleria_app/src/feature/orders/models/order_model.dart';
import 'package:polleria_app/src/feature/tables/models/tables_model.dart';

final orderRepositories = Provider(
  (ref) {
    final user = ref.watch(userSessionProv);
    return OrderRepositories(
      user: user,
    );
  },
);

class OrderRepositories {
  OrderRepositories({required this.user});
  final UserModel user;
  final _client =
      APIClient(url: "http://localhost:8000/api");

  /// ORDERS CRUD
  Future<Result> deleteOrder({
    required String idOrder,
  }) async {
    try {
      final endpoint = "/orders/$idOrder/";
      final request = await _client.delete(endpoint);
      if (request?.statusCode == 204) {
        return const Result.success(null);
      }
      return const Result.failure();
    } catch (e) {
      return const Result.failure();
    }
  }

  Future<Result> updateOrder({
    required String idOrder,
    required Map<String, dynamic> formData,
  }) async {
    try {
      final endpoint = "/orders/$idOrder/";
      final request = await _client.put(endpoint, formData);
      if (request?.statusCode == 200) {
        return const Result.success(null);
      }
      return const Result.failure();
    } catch (e) {
      return const Result.failure();
    }
  }

  Future<Result> registerOrder({required Map<String, dynamic> formData}) async {
    try {
      const endpoint = "/orders/";
      final request = await _client.post(
        endpoint,
        {"user": user.id, ...formData},
      );
      if (request?.statusCode == 201) {
        final data = request?.data as Map<String, dynamic>;
        final model = OrderModel.fromJson(data);
        return Result.success(model);
      }
      return const Result.failure();
    } catch (e) {
      return const Result.failure();
    }
  }

  Future<Result> registerItemOrder({
    required Map<String, dynamic> formData,
  }) async {
    try {
      const endpoint = "/orders-item/";
      final request = await _client.post(
        endpoint,
        formData,
      );
      if (request?.statusCode == 200) {
        final data = request?.data as Map<String, dynamic>;
        final model = OrderItemModel.fromJson(data);
        return Result.success(model);
      }
      return const Result.failure();
    } catch (e) {
      return const Result.failure();
    }
  }

  Future<Result> deleteOrderItem({
    required String idOrder,
  }) async {
    try {
      final endpoint = "/orders-item/$idOrder/";
      final request = await _client.delete(endpoint);
      if (request?.statusCode == 204) {
        return const Result.success(null);
      }
      return const Result.failure();
    } catch (e) {
      return const Result.failure();
    }
  }

  Future<Result> listOrderItembyOrderID({
    required Map<String, dynamic> formData,
  }) async {
    try {
      const endpoint = "/orders-item/listByOrderID/";
      final request = await _client.post(
        endpoint,
        formData,
      );
      if (request?.statusCode == 200) {
        final data = request?.data as List;
        final listmodel = data.map((v) {
          return OrderItemModel.fromJson(v);
        }).toList();
        return Result.success(listmodel);
      }
      return const Result.failure();
    } catch (e) {
      return const Result.failure();
    }
  }

  Future<Result> listOrders() async {
    try {
      const endpoint = "/orders/";
      final request = await _client.get(endpoint);
      if (request?.statusCode == 200) {
        final data = request?.data as List;
        final listmodel = data.map((data) {
          return OrderModel.fromJson(data);
        }).toList();
        return Result.success(listmodel);
      }
      return const Result.failure();
    } catch (e) {
      return const Result.failure();
    }
  }

  Future<Result> getOrderByID(int id) async {
    try {
      final endpoint = "/orders/$id/";
      final request = await _client.get(endpoint);
      if (request?.statusCode == 200) {
        final data = request?.data as Map<String, dynamic>;
        return Result.success(OrderModel.fromJson(data));
      }
      return const Result.failure();
    } catch (e) {
      return const Result.failure();
    }
  }

  Future<Result> getComboTables() async {
    try {
      const endpoint = "/tables/list-combo/";
      final request = await _client.get(endpoint);
      if (request?.statusCode == 200) {
        final data = request?.data as List;
        final modelList = data.map((v) {
          return TablesModel.fromJson(v);
        }).toList();
        return Result.success(modelList);
      }
      return const Result.failure();
    } catch (e) {
      return const Result.failure();
    }
  }
}
