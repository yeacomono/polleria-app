import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:polleria_app/src/feature/home/home_repository.dart';
import 'package:polleria_app/src/feature/home/models/item_modules_model.dart';

final homeNotifier =
    StateNotifierProvider.autoDispose<HomeNotierProvider, HomeState>(
  (ref) {
    final homerepo = ref.read(homeRepository);
    return HomeNotierProvider(
      repository: homerepo,
    );
  },
);

class HomeNotierProvider extends StateNotifier<HomeState> {
  HomeRepository repository;
  HomeNotierProvider({required this.repository}) : super(HomeState()) {
    loadModulesByRol();
  }

  Future<void> loadModulesByRol() async {
    state = state.copyWith(isLoading: true);
    final result = await repository.listModuleByRol();
    if (result.isFailure) {
      state = state.copyWith(
        isLoading: false,
        isError: true,
      );
      return;
    }
    state = state.copyWith(
      status: true,
      isLoading: false,
      menuList: result.data,
    );
  }
}

class HomeState {
  final bool status;
  final List<ItemModuleModel>? menuList;
  final bool isLoading;
  final bool isError;

  HomeState({
    this.status = false,
    this.menuList,
    this.isLoading = true,
    this.isError = false,
  });

  HomeState copyWith({
    bool? status,
    List<ItemModuleModel>? menuList,
    bool? isLoading,
    bool? isError,
  }) {
    return HomeState(
      status: status ?? this.status,
      menuList: menuList ?? this.menuList,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
    );
  }
}
