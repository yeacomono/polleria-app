import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:polleria_app/src/feature/products/repositories/products_repository.dart';

final productsRegisNotiProv =
    StateNotifierProvider<ProductsRegisNotifierProvider, ProductsRegisState>(
  (ref) {
    final repoProduct = ref.read(productsRepository);
    return ProductsRegisNotifierProvider(productsRepository: repoProduct);
  },
);

class ProductsRegisNotifierProvider extends StateNotifier<ProductsRegisState> {
  final ProductsRepository productsRepository;
  ProductsRegisNotifierProvider({required this.productsRepository})
      : super(ProductsRegisState());

  Future<void> registerProduct({
    required String name,
    required String description,
    required String price,
    required bool isCombo,
  }) async {
    state = state.copyWith(isLoading: true, status: null);
    final result = await productsRepository.registerProducts(
      form: {
        'name': name,
        'description': description,
        'price': price,
        'is_combo': isCombo,
      },
    );
    if (result.isFailure) {
      state = state.copyWith(
        isError: true,
        isLoading: false,
        status: false,
      );
      return;
    }
    state = state.copyWith(
      isError: false,
      isLoading: false,
      status: true,
    );
  }
}

class ProductsRegisState {
  final String userName;
  final String email;
  final String password;
  final int rolID;

  final bool? status;
  final bool isLoading;
  final bool isError;

  ProductsRegisState({
    this.userName = '',
    this.email = '',
    this.password = '',
    this.rolID = 0,
    this.status,
    this.isLoading = true,
    this.isError = false,
  });

  ProductsRegisState copyWith({
    bool? status,
    bool? isLoading,
    bool? isError,
    String? userName,
    String? email,
    String? password,
    int? rolID,
  }) {
    return ProductsRegisState(
      userName: userName ?? this.userName,
      email: email ?? this.email,
      password: password ?? this.password,
      rolID: rolID ?? this.rolID,
      status: status,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
    );
  }
}
