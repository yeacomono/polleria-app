import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:polleria_app/src/core/constants/over_colors.dart';
import 'package:polleria_app/src/core/constants/over_fonts.dart';
import 'package:polleria_app/src/feature/auth/login_provider.dart';
import 'package:polleria_app/src/feature/home/home_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {

  static const String name = "LoginScreen";
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();

}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  /// Input Focus
  final focusUsername = FocusNode();
  final focusPassword = FocusNode();

  /// Input Controllers
  final userController = TextEditingController();
  final passWordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final loginP = ref.watch(loginNotifier);
    final appRouter = GoRouter.of(context);
    ref.listen(
      loginNotifier,
      (previus, current) {
        if (current.status == true) {
          ref.read(userSessionProv.notifier).state = current.user!;
          appRouter.pushReplacementNamed(HomeScreen.name);
          return;
        }
        if (current.status == false) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(current.message ?? ''),
              duration: const Duration(seconds: 1),
            ),
          );
          return;
        }
      },
    );
    return GestureDetector(
      onTap: () {
        focusUsername.unfocus();
        focusPassword.unfocus();
      },
      child: GestureDetector(
        child: Scaffold(
          backgroundColor: OverColors.primaryColor,
          body: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/logo.png"),
                    const Row(
                      children: [
                        Text(
                          'Version: 0.0.1',
                          style: TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(255, 181, 179, 179),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _createLoginInput(
                      controller: userController,
                      label: 'USUARIO',
                      icon: Icons.person,
                      obscure: false,
                      currentFocus: focusUsername,
                      keyboardAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      maxLength: 50,
                      onSubmit: (value) {},
                      onChanged: (v) {
                        ref.read(loginNotifier.notifier).setUser(v);
                      },
                    ),
                    _createLoginInput(
                      controller: passWordController,
                      label: 'CONTRASEÑA',
                      icon: Icons.lock,
                      obscure: true,
                      currentFocus: focusPassword,
                      keyboardAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      maxLength: 15,
                      onSubmit: (value) {},
                      onChanged: (v) {
                        ref.read(loginNotifier.notifier).setPass(v);
                      },
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () async {
                        await ref.read(loginNotifier.notifier).loginRequest();
                      },
                      child: AnimatedContainer(
                        width: (MediaQuery.of(context).size.width * 0.8) /
                            (loginP.loading ? 2 : 1),
                        height: 60,
                        curve: Curves.fastOutSlowIn,
                        alignment: Alignment.center,
                        duration: const Duration(
                          milliseconds: 1000,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: loginP.loading
                            ? CircularProgressIndicator(
                                color: OverColors.primaryColor,
                              )
                            : const Text(
                                'INGRESAR',
                                style: OverFonts.blueLoginButton,
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _createLoginInput({
    required String label,
    required IconData icon,
    Widget? widget,
    required bool obscure,
    required TextEditingController controller,
    required FocusNode currentFocus,
    required TextInputAction keyboardAction,
    Function(String v)? onSubmit,
    Function(String v)? onChanged,
    required TextInputType keyboardType,
    required int maxLength,
  }) {
    InputBorder inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: const BorderSide(color: Colors.white),
    );

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        controller: controller,
        focusNode: currentFocus,
        textInputAction: keyboardAction,
        onChanged: onChanged,
        keyboardType: keyboardType,
        maxLength: maxLength,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.white),
          suffixIcon: widget,
          enabledBorder: inputBorder,
          border: inputBorder,
          labelText: label,
          labelStyle: OverFonts.whiteLoginInputLabel,
          focusedBorder: inputBorder,
          counterText: "",
          //suffixIcon: Icon(Icons.remove_red_eye, color: Colors.white30,)
        ),
        style: OverFonts.whiteLoginInput,
        cursorWidth: 3.0,
        cursorColor: Colors.white,
        cursorRadius: const Radius.circular(10.0),
        obscureText: obscure,
        // onFieldSubmitted: onSubmit,
      ),
    );
  }
}
