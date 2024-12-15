import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
            : ListView.separated(
                itemCount: produtcNot.listProducts?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  return ItemListProducts(
                    model: produtcNot.listProducts![index],
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider();
                },
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
  const ItemListProducts({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("NOMBRE:  ${model.name}"),
          Text("DESCRPCIÓN: ${model.description}"),
          Text("PRECIO: ${model.price}"),
          Text("ES COMBO?: ${model.isCombo}"),
        ],
      ),
    );
  }
}
