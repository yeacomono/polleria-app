import 'package:dropdown_flutter/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:polleria_app/src/core/constants/over_colors.dart';
import 'package:polleria_app/src/core/constants/over_fonts.dart';
import 'package:polleria_app/src/feature/orders/screens/order_detail_screen.dart';
import 'package:polleria_app/src/feature/tables/models/tables_model.dart';
import 'package:polleria_app/src/feature/orders/providers/order_provider.dart';
import 'package:polleria_app/src/feature/orders/providers/order_screen_provider.dart';

class OrderScreen extends ConsumerWidget {
  static const String name = "OrderScreen";
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final comboTableAsync = ref.watch(comboTables);
    ref.listen(
      orderNotifier,
      (previus, current) {
        if (current.status == true) {
          final router = GoRouter.of(context);
          router.pushReplacementNamed(
            OrderDetailScreen.name,
            extra: current.order,
          );
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
          'REGISTRAR ORDEN',
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
              const Text(
                'SELECCIONES NUMERO DE MESA',
                textAlign: TextAlign.start,
                style: OverFonts.blackDrawerItem,
              ),
              const SizedBox(
                height: 10,
              ),
              comboTableAsync.when(
                data: (List<TablesModel> data) {
                  return DropdownFlutter<TablesModel>(
                    decoration: CustomDropdownDecoration(
                      closedBorder: Border.all(color: Colors.grey.shade800),
                      closedBorderRadius: BorderRadius.circular(5),
                      expandedBorderRadius: BorderRadius.circular(5),
                    ),
                    hintText: 'Selecciona la mesa',
                    items: data,
                    listItemBuilder: (context, item, isSelected, onItemSelect) {
                      return Text(item.tableNumber ?? '');
                    },
                    headerBuilder: (context, selectedItem, enabled) {
                      return Text(selectedItem.tableNumber ?? '');
                    },
                    onChanged: (value) {
                      ref.read(slectTable.notifier).state = value;
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
                controller: ref.read(nameCustomerController),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nombre del cliente',
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
                    if (ref.read(slectTable) == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Por favort selecciona una mesa'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                      return;
                    }
                    if (ref.read(nameCustomerController).text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Por favor ingrese el cliente'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                      return;
                    }
                    ref.read(orderNotifier.notifier).inserOrder(
                          nameClient: ref.read(nameCustomerController).text,
                          tableId: ref.read(slectTable)!.id!,
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
