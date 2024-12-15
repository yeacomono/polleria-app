import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:polleria_app/src/core/constants/over_colors.dart';
import 'package:polleria_app/src/core/constants/over_fonts.dart';
import 'package:polleria_app/src/feature/products/providers/register_products_provider.dart';

final nameController = Provider((ref) => TextEditingController());
final descriptionController = Provider((ref) => TextEditingController());
final priceController = Provider((ref) => TextEditingController());
final isCombo = StateProvider<bool>((ref) => false);

class RegisterProductsScreen extends ConsumerWidget {
  static const String name = "RegisterProductsScreen";
  const RegisterProductsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      productsRegisNotiProv,
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
          'REGISTER PRODUCTS',
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                onChanged: (v) {},
                controller: ref.read(nameController),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'DESCRIPTION',
                textAlign: TextAlign.start,
                style: OverFonts.blackDrawerItem,
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: ref.read(descriptionController),
                onChanged: (v) {},
                maxLines: 3,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: ref.read(priceController),
                onChanged: (v) {},
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'PRICE',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 0,
                  vertical: 0,
                ),
                title: const Text('¿ES UN COMBO?'),
                leading: Checkbox(
                  value: ref.watch(isCombo),
                  onChanged: (bool? value) {
                    ref.read(isCombo.notifier).state = value ?? false;
                  },
                ),
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
                    ref.read(productsRegisNotiProv.notifier).registerProduct(
                          description: ref.read(descriptionController).text,
                          name: ref.read(nameController).text,
                          isCombo: ref.read(isCombo),
                          price: ref.read(priceController).text,
                        );
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
