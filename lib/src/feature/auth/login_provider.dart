import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:polleria_app/src/feature/auth/login_repository.dart';
import 'package:polleria_app/src/feature/auth/models/user_model.dart';

final userSessionProv = StateProvider<UserModel>(
  (ref) {
    return UserModel();
  },
);

final loginNotifier = StateNotifierProvider<LoginNotifier, LoginState>(
  (ref) {
    final repository = ref.read(loginrepository);
    return LoginNotifier(
      loginRepository: repository,
    );
  },
);

class LoginNotifier extends StateNotifier<LoginState> {
  final LoginRepository loginRepository;
  LoginNotifier({required this.loginRepository}) : super(LoginState());

  void setUser(String v) => (state = state.copyWith(username: v));
  void setPass(String v) => (state = state.copyWith(password: v));

  Future<void> loginRequest() async {
    state = state.copyWith(loading: true, status: null);
    log("This -log status ${state.status.toString()}");
    // final version = await _getAppVersion();
    final result = await loginRepository.login(
      username: state.username ?? 'pablonius34@gmail.com',
      password: state.password ?? 'chapolinaso',
    );
    state = state.copyWith(loading: false);
    if (result.isFailure) {
      state = state.copyWith(
        status: false,
        message: result.message,
      );
      return;
    }
    state = state.copyWith(
      status: true,
      user: result.data,
    );
  }
}

class LoginState {
  final String? password;
  final String? username;
  final bool? status;
  final String? message;
  final bool loading;
  final UserModel? user;
  final bool shouldNavigate;

  LoginState({
    this.password,
    this.username,
    this.shouldNavigate = false,
    this.loading = false,
    this.status,
    this.user,
    this.message,
  });

  LoginState copyWith(
      {String? password,
      String? username,
      bool? loading,
      bool? status,
      UserModel? user,
      String? message,
      bool? shouldNavigate}) {
    return LoginState(
      password: password ?? this.password,
      message: message ?? this.message,
      shouldNavigate: shouldNavigate ?? this.shouldNavigate,
      username: username ?? this.username,
      status: status,
      loading: loading ?? this.loading,
      user: user ?? this.user,
    );
  }
}
