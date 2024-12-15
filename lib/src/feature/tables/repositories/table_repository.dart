import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:polleria_app/src/core/utils/api_client.dart';
import 'package:polleria_app/src/feature/products/models/products_model.dart';

final productsRepository = Provider(
  (ref) {
    return ProductsRepository();
  },
);

class ProductsRepository {
  final client = APIClient(url: "http://localhost:8000/api");

  Future<Result> listAllProducts() async {
    try {
      const endpoint = "/products";
      final request = await client.get(endpoint);
      if (request?.statusCode != 200) {
        return const Result.failure();
      }
      final data = request?.data as List;
      final listModels = data.map((v) => ProductModel.fromJson(v)).toList();
      return Result.success(listModels);
    } catch (e) {
      return const Result.failure();
    }
  }

  // Future<Result> lisAllRoles() async {
  //   try {
  //     const endpoint = "/roles";
  //     final request = await client.get(endpoint);
  //     if (request?.statusCode != 200) {
  //       return const Result.failure();
  //     }
  //     final data = request?.data as List;
  //     final listModels = data.map((v) => RoleModel.fromJson(v)).toList();
  //     return Result.success(listModels);
  //   } catch (e) {
  //     return const Result.failure();
  //   }
  // }

  Future<Result> registerProducts({required Map<String, dynamic> form}) async {
    try {
      const endpoint = "/products/";
      final formData = form;
      final request = await client.post(endpoint, formData);
      if (request?.statusCode == 201) {
        final data = request?.data as Map<String, dynamic>;
        final model = ProductModel.fromJson(data);
        return Result.success(model);
      }
      return const Result.failure();
    } catch (e) {
      return const Result.failure();
    }
  }
}
