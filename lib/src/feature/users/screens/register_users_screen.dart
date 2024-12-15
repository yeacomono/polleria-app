import 'package:dropdown_flutter/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:polleria_app/src/core/constants/over_colors.dart';
import 'package:polleria_app/src/core/constants/over_fonts.dart';
import 'package:polleria_app/src/feature/users/models/role_model.dart';
import 'package:polleria_app/src/feature/users/providers/register_user_provider.dart';

class RegisterUsersScreen extends ConsumerWidget {
  static const String name = "RegisterUsersScreen";

  const RegisterUsersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final comboRolAsync = ref.watch(comboRol);
    ref.listen(
      usersRegisterNotiProv,
      (previus, current) {
        if (current.status == true) {
          GoRouter.of(context).pop();
          return;
        }
        if (current.status == false) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('No se pudo registrar correctamente'),
              duration: Duration(seconds: 1),
            ),
          );
          return;
        }
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'REGISTER USERS',
          style: OverFonts.whiteTitle,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: false,
        titleSpacing: 0,
        backgroundColor: OverColors.primaryColor,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              comboRolAsync.when(
                data: (List<RoleModel> data) {
                  return DropdownFlutter<RoleModel>(
                    decoration: CustomDropdownDecoration(
                      closedBorder: Border.all(color: Colors.grey.shade800),
                      closedBorderRadius: BorderRadius.circular(5),
                      expandedBorderRadius: BorderRadius.circular(5),
                    ),
                    hintText: 'SELECT YOUR ROLE',
                    items: data,
                    listItemBuilder: (context, item, isSelected, onItemSelect) {
                      return Text(item.name ?? '');
                    },
                    headerBuilder: (context, selectedItem, enabled) {
                      return Text(selectedItem.name ?? '');
                    },
                    onChanged: (value) {
                      ref.read(usersRegisterNotiProv.notifier).updateRolID(
                            value!.id,
                          );
                    },
                  );
                },
                error: (Object error, StackTrace stackTrace) {
                  return Text(
                    "Error fetching roles: ${error.toString()}\n$stackTrace",
                  );
                },
                loading: () {
                  return const LinearProgressIndicator();
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                onChanged: (v) {
                  ref.read(usersRegisterNotiProv.notifier).updateUserName(v);
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Username',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                onChanged: (v) {
                  ref.read(usersRegisterNotiProv.notifier).updateEmail(v);
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                onChanged: (v) {
                  ref.read(usersRegisterNotiProv.notifier).updatePassword(v);
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: OverColors.primaryColor),
                  onPressed: () {
                    ref.read(usersRegisterNotiProv.notifier).registerUser();
                  },
                  child: const Text(
                    'REGISTER',
                    style: OverFonts.whiteLoginInput,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
