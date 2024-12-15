import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:polleria_app/src/feature/products/models/products_model.dart';
import 'package:polleria_app/src/feature/products/repositories/products_repository.dart';

final productsNotiProv =
    StateNotifierProvider<ProductNotifierProvider, ProductState>(
  (ref) {
    final repoProduct = ref.read(productsRepository);
    return ProductNotifierProvider(productsRepository: repoProduct);
  },
);

class ProductNotifierProvider extends StateNotifier<ProductState> {
  final ProductsRepository productsRepository;
  ProductNotifierProvider({required this.productsRepository})
      : super(ProductState()) {
    listProducts();
  }

  Future<void> listProducts() async {
    state = state.copyWith(isLoading: true, status: null);
    final result = await productsRepository.listAllProducts();
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
      listProducts: result.data,
    );
  }

  Future<void> removeProducts({required int idPD}) async {
    state = state.copyWith(isLoading: true, status: null);
    final result = await productsRepository.removeProducts(idPD: idPD);
    if (result.isFailure) {
      state = state.copyWith(
        isError: true,
        isLoading: false,
        status: false,
      );
      return;
    }
    await listProducts();
  }
}

class ProductState {
  final bool? status;
  final List<ProductModel>? listProducts;
  final bool isLoading;
  final bool isError;

  ProductState({
    this.status,
    this.listProducts,
    this.isLoading = true,
    this.isError = false,
  });

  ProductState copyWith({
    bool? status,
    List<ProductModel>? listProducts,
    bool? isLoading,
    bool? isError,
  }) {
    return ProductState(
      status: status,
      listProducts: listProducts ?? this.listProducts,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
    );
  }
}
