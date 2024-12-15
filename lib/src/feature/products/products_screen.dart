import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:polleria_app/src/core/constants/over_colors.dart';
import 'package:polleria_app/src/core/constants/over_fonts.dart';
import 'package:polleria_app/src/feature/products/models/products_model.dart';
import 'package:polleria_app/src/feature/products/providers/products_provider.dart';
import 'package:polleria_app/src/feature/products/screens/register_products_screen.dart';

class ProductScreen extends ConsumerWidget {
  static const String name = "ProductScreen";
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final produtcNot = ref.watch(productsNotiProv);
    final productNotController = ref.watch(productsNotiProv.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'PRODUCTS',
          style: OverFonts.whiteTitle,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: false,
        titleSpacing: 0,
        backgroundColor: OverColors.primaryColor,
      ),
      body: Container(
        child: produtcNot.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                onRefresh: () async {
                  ref.watch(productsNotiProv.notifier).listProducts();
                },
                child: ListView.separated(
                  itemCount: produtcNot.listProducts?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    return ItemListProducts(
                      model: produtcNot.listProducts![index],
                      deleteCallBack: () {
                        productNotController.removeProducts(
                          idPD: produtcNot.listProducts![index].id!,
                        );
                      },
                      editCallBack: () {},
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(
                      height: 0,
                    );
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
          router.pushNamed(RegisterProductsScreen.name).then((v) {
            ref.read(productsNotiProv.notifier).listProducts();
          });
        },
      ),
    );
  }
}

class ItemListProducts extends StatelessWidget {
  final ProductModel model;
  final Function() deleteCallBack;
  final Function() editCallBack;
  const ItemListProducts({
    super.key,
    required this.model,
    required this.deleteCallBack,
    required this.editCallBack,
  });

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
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "NOMBRE: ${model.name}",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "DESCRIPCIÓN: ${model.description}",
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "PRECIO: S/.${double.parse(model.price!).toStringAsFixed(2)}",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text(
                  "COMBO: ",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
                Icon(
                  model.isCombo! ? Icons.check_circle : Icons.cancel,
                  color: model.isCombo! ? Colors.green : Colors.red,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
