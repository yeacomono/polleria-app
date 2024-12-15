import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:polleria_app/src/feature/users/models/user_item_model.dart';
import 'package:polleria_app/src/feature/users/repositories/users_repository.dart';

final usersNotiProv = StateNotifierProvider<UsersNotifierProvider, UsersState>(
  (ref) {
    final repoUsers = ref.read(usersRepository);
    return UsersNotifierProvider(usersRepository: repoUsers);
  },
);

class UsersNotifierProvider extends StateNotifier<UsersState> {
  final UsersRepository usersRepository;
  UsersNotifierProvider({required this.usersRepository}) : super(UsersState()) {
    listUsers();
  }

  Future<void> listUsers() async {
    state = state.copyWith(isLoading: true);
    final result = await usersRepository.listAllUsers();
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
      listUsers: result.data,
    );
  }

  Future<void> deleteUsers({required int id}) async {
    state = state.copyWith(isLoading: true);
    final result = await usersRepository.deleteUsers(userId: id);
    if (result.isFailure) {
      state = state.copyWith(
        isError: true,
        isLoading: false,
        status: false,
      );
      return;
    }
    await listUsers();
  }
}

class UsersState {
  final bool status;
  final List<UserItemModel>? listUsers;
  final bool isLoading;
  final bool isError;

  UsersState({
    this.status = false,
    this.listUsers,
    this.isLoading = true,
    this.isError = false,
  });

  UsersState copyWith({
    bool? status,
    List<UserItemModel>? listUsers,
    bool? isLoading,
    bool? isError,
  }) {
    return UsersState(
      status: status ?? this.status,
      listUsers: listUsers ?? this.listUsers,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
    );
  }
}
