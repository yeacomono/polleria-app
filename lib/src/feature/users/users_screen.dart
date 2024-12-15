import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:polleria_app/src/core/constants/over_colors.dart';
import 'package:polleria_app/src/core/constants/over_fonts.dart';
import 'package:polleria_app/src/feature/users/models/user_item_model.dart';
import 'package:polleria_app/src/feature/users/providers/users_provider.dart';
import 'package:polleria_app/src/feature/users/screens/register_users_screen.dart';

class UsersScreen extends ConsumerWidget {
  static const String name = "UserScreen";
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersProv = ref.watch(usersNotiProv);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'USERS',
          style: OverFonts.whiteTitle,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: false,
        titleSpacing: 0,
        backgroundColor: OverColors.primaryColor,
      ),
      body: Container(
        child: usersProv.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                onRefresh: () async {
                  ref.read(usersNotiProv.notifier).listUsers();
                },
                child: ListView.separated(
                  itemCount: usersProv.listUsers?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    return ItemListUsers(
                      model: usersProv.listUsers![index],
                      deleteCallBack: () {
                        ref.read(usersNotiProv.notifier).deleteUsers(
                              id: usersProv.listUsers![index].id!,
                            );
                      },
                      editCallBack: () {},
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider();
                  },
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: OverColors.primaryColor,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          final router = GoRouter.of(context);
          router.pushNamed(RegisterUsersScreen.name).then((v) {
            ref.read(usersNotiProv.notifier).listUsers();
          });
        },
      ),
    );
  }
}

class ItemListUsers extends StatelessWidget {
  final UserItemModel? model;
  final Function() deleteCallBack;
  final Function() editCallBack;

  const ItemListUsers({
    super.key,
    required this.model,
    required this.deleteCallBack,
    required this.editCallBack,
  });
  String roleName(int id) {
    if (id == 1) {
      return "Admin";
    }
    if (id == 2) {
      return "Mesero";
    }
    if (id == 4) {
      return "Cocinero";
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        extentRatio: 0.6,
        key: const ValueKey(0),
        motion: const ScrollMotion(),
        children: [
          CustomSlidableAction(
            onPressed: (_) => {},
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.edit,
                  size: 40,
                ),
                Text("Editar"),
              ],
            ),
          ),
          CustomSlidableAction(
            onPressed: (_) => {deleteCallBack()},
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.delete,
                  size: 40,
                ),
                Text("Eliminar"),
              ],
            ),
          ),
        ],
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Rol: ${roleName(model!.role!)}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Text(
                    "Nombre: ${model?.name}",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Correo: ${model?.email}",
                  style: const TextStyle(fontSize: 14, color: Colors.orange),
                ),
              ],
            ),
            const Expanded(
              child: SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
