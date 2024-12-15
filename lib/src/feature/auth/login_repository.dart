import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:polleria_app/src/core/utils/api_client.dart';
import 'package:polleria_app/src/feature/auth/models/user_model.dart';

final loginrepository = Provider(
  (v) {
    return LoginRepository();
  },
);

class LoginRepository {
  final client = APIClient(url: "http://localhost:8000/api");

  Future<Result> login({
    required String username,
    required String password,
  }) async {
    try {
      const endPoint = "/login-user";
      final formData = {"email": username, "password": password};
      final request = await client.post(endPoint, formData);
      if (request?.statusCode != 200) {
        return const Result.failure();
      }
      final data = request?.data['user'] as Map<String, dynamic>;
      final model = UserModel.fromJson(data);
      return Result.success(model);
    } catch (e) {
      return const Result.failure();
    }
  }

  
}
