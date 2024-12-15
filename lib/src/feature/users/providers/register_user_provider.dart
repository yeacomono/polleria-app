import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:polleria_app/src/feature/users/models/role_model.dart';
import 'package:polleria_app/src/feature/users/repositories/users_repository.dart';

final usersRegisterNotiProv =
    StateNotifierProvider<UsersRegisterNotifierProvider, UsersRegisterState>(
  (ref) {
    final repoUsers = ref.read(usersRepository);
    return UsersRegisterNotifierProvider(usersRepository: repoUsers);
  },
);

final comboRol = FutureProvider<List<RoleModel>>(
  (ref) async {
    final repoUsers = ref.read(usersRepository);
    final listModels = await repoUsers.lisAllRoles();
    return listModels.data;
  },
);

class UsersRegisterNotifierProvider extends StateNotifier<UsersRegisterState> {
  final UsersRepository usersRepository;
  UsersRegisterNotifierProvider({required this.usersRepository})
      : super(UsersRegisterState());

  void updateUserName(v) => (state = state.copyWith(userName: v));
  void updateEmail(v) => (state = state.copyWith(email: v));
  void updatePassword(v) => (state = state.copyWith(password: v));
  void updateRolID(v) => (state = state.copyWith(rolID: v));

  Future<void> registerUser() async {
    state = state.copyWith(isLoading: true, status: null);
    final result = await usersRepository.registerUser(
      form: {
        'role': state.rolID,
        'name': state.userName,
        'email': state.email,
        'password': state.password,
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

class UsersRegisterState {
  final String userName;
  final String email;
  final String password;
  final int rolID;

  final bool? status;
  final bool isLoading;
  final bool isError;

  UsersRegisterState({
    this.userName = '',
    this.email = '',
    this.password = '',
    this.rolID = 0,
    this.status,
    this.isLoading = true,
    this.isError = false,
  });

  UsersRegisterState copyWith({
    bool? status,
    bool? isLoading,
    bool? isError,
    String? userName,
    String? email,
    String? password,
    int? rolID,
  }) {
    return UsersRegisterState(
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
