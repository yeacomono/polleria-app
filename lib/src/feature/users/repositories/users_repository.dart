import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:polleria_app/src/core/utils/api_client.dart';
import 'package:polleria_app/src/feature/users/models/role_model.dart';
import 'package:polleria_app/src/feature/users/models/user_item_model.dart';

final usersRepository = Provider(
  (ref) {
    return UsersRepository();
  },
);

class UsersRepository {
  final client =
      APIClient(url: "http://localhost:8000/api");

  Future<Result> listAllUsers() async {
    try {
      const endpoint = "/users";
      final request = await client.get(endpoint);
      if (request?.statusCode != 200) {
        return const Result.failure();
      }
      final data = request?.data as List;
      final listModels = data.map((v) => UserItemModel.fromJson(v)).toList();
      return Result.success(listModels);
    } catch (e) {
      return const Result.failure();
    }
  }

  Future<Result> deleteUsers({
    required int userId,
  }) async {
    try {
      final endpoint = "/users/$userId/";
      final request = await client.delete(endpoint);
      if (request?.statusCode != 204) {
        return const Result.success(null);
      }
      return const Result.failure();
    } catch (e) {
      return const Result.failure();
    }
  }

  Future<Result> lisAllRoles() async {
    try {
      const endpoint = "/roles";
      final request = await client.get(endpoint);
      if (request?.statusCode != 200) {
        return const Result.failure();
      }
      final data = request?.data as List;
      final listModels = data.map((v) => RoleModel.fromJson(v)).toList();
      return Result.success(listModels);
    } catch (e) {
      return const Result.failure();
    }
  }

  Future<Result> registerUser({required Map<String, dynamic> form}) async {
    try {
      const endpoint = "/users/";
      final formData = form;
      final request = await client.post(endpoint, formData);
      if (request?.statusCode == 201) {
        final data = request?.data as Map<String, dynamic>;
        final model = UserItemModel.fromJson(data);
        return Result.success(model);
      }
      return const Result.failure();
    } catch (e) {
      return const Result.failure();
    }
  }
}
