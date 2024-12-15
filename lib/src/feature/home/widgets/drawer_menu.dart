import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:polleria_app/src/core/constants/over_colors.dart';
import 'package:polleria_app/src/core/constants/over_fonts.dart';
import 'package:polleria_app/src/feature/auth/login_provider.dart';
import 'package:polleria_app/src/feature/auth/login_screen.dart';

class DrawerMenu extends ConsumerWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userSessionProv);
    return Drawer(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: OverColors.primaryColor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "${user.name}",
                  style: OverFonts.whiteTitle,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                HeaderDrawerWidget(
                  label: "Email: ",
                  content: user.email ?? '',
                ),
                HeaderDrawerWidget(
                  label: "Rol: ",
                  content: user.role ?? '',
                )
              ],
            ),
          ),
          ListTile(
            title: const Text('INICIO'),
            trailing: const Icon(Icons.arrow_right),
            onTap: () {
              final router = GoRouter.of(context);
              router.pop();
            },
          ),
          ListTile(
            title: const Text('SETTING'),
            trailing: const Icon(Icons.arrow_right),
            onTap: () {
              final router = GoRouter.of(context);
              router.pop();
            },
          ),
          ListTile(
            title: const Text('CERRAR CESION'),
            trailing: const Icon(Icons.arrow_right),
            onTap: () {
              final router = GoRouter.of(context);
              router.pushReplacementNamed(LoginScreen.name);
            },
          ),
        ],
      ),
    );
  }
}

class HeaderDrawerWidget extends StatelessWidget {
  final String label;
  final String content;
  const HeaderDrawerWidget({
    super.key,
    required this.label,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle drawerHeaderTitleStyle = const TextStyle(
        fontFamily: 'arial',
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w800);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          label,
          style: drawerHeaderTitleStyle,
        ),
        Expanded(
          child: Text(
            content,
            overflow: TextOverflow.ellipsis,
            style: drawerHeaderTitleStyle,
            textAlign: TextAlign.right,
          ),
        )
      ],
    );
  }
}
