import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:polleria_app/src/core/utils/api_client.dart';
import 'package:polleria_app/src/feature/auth/login_provider.dart';
import 'package:polleria_app/src/feature/auth/models/user_model.dart';
import 'package:polleria_app/src/feature/home/models/item_modules_model.dart';

final homeRepository = Provider(
  (ref) {
    final user = ref.watch(userSessionProv);
    return HomeRepository(user: user);
  },
);

class HomeRepository {
  final UserModel user;

  HomeRepository({
    required this.user,
  });
  final client = APIClient(url: "http://localhost:8000/api");

  Future<Result> listModuleByRol() async {
    try {
      const endPoint = "/modules-rol";
      final formData = {"rol_name": user.role};
      final request = await client.post(endPoint, formData);
      if (request?.statusCode != 200) {
        return const Result.failure();
      }
      final data = request?.data as List;
      final listModels = data.map((v) => ItemModuleModel.fromJson(v)).toList();
      return Result.success(listModels);
    } catch (e) {
      return const Result.failure();
    }
  }
}
