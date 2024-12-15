import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:polleria_app/src/core/core.dart';
import 'package:polleria_app/src/feature/orders/models/order_model.dart';
import 'package:polleria_app/src/feature/orders/providers/order_provider.dart';
import 'package:polleria_app/src/feature/orders/screens/order_detail_screen.dart';

class OrderStateScreen extends ConsumerStatefulWidget {
  static const String name = "OrderStateScreen";
  const OrderStateScreen({super.key});

  @override
  ConsumerState<OrderStateScreen> createState() => _OrderStateScreenState();
}

class _OrderStateScreenState extends ConsumerState<OrderStateScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((v) {
      ref.read(orderNotifier.notifier).listOrders();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderNotier = ref.watch(orderNotifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ESTADOS DE LAS ORDENES',
          style: OverFonts.whiteTitle,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: false,
        titleSpacing: 0,
        backgroundColor: OverColors.primaryColor,
      ),
      body: SizedBox(
        child: orderNotier.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                onRefresh: () async {
                  await ref.read(orderNotifier.notifier).listOrders();
                },
                child: ListView.separated(
                  itemBuilder: (BuildContext context, int index) {
                    return ItemListOrders(
                      removeCallBack: () {
                        ref.read(orderNotifier.notifier).removeOrder(
                              idOrder: orderNotier.listOrders?[index].id,
                            );
                      },
                      model: orderNotier.listOrders?[index],
                      onTapOrder: () {
                        final router = GoRouter.of(context);
                        router
                            .pushNamed(
                          OrderDetailScreen.name,
                          extra: orderNotier.listOrders?[index],
                        )
                            .then((v) {
                          ref.read(orderNotifier.notifier).listOrders();
                        });
                      },
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(
                      height: 0,
                    );
                  },
                  itemCount: orderNotier.listOrders?.length ?? 0,
                ),
              ),
      ),
    );
  }
}

class ItemListOrders extends StatelessWidget {
  final OrderModel? model;
  final Function()? onTapOrder;
  final Function()? removeCallBack;
  final bool showDelete;

  const ItemListOrders({
    super.key,
    required this.model,
    this.showDelete = true,
    required this.removeCallBack,
    this.onTapOrder,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapOrder,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Nombre Cliente: ${model?.customerName ?? ''}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Número de Mesa: ${model?.table}",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Estado: ${model?.status?.toUpperCase()}",
                  style: TextStyle(
                    fontSize: 14,
                    color: model?.status == "delivered"
                        ? Colors.green
                        : model?.status == "pending"
                            ? Colors.orange
                            : Colors.red,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Total Precio: S/.${(double.parse(model?.total ?? "0.00")).toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade700,
                  ),
                ),
              ],
            ),
            const Expanded(
              child: SizedBox(),
            ),
            Visibility(
              visible: showDelete,
              child: InkWell(
                onTap: removeCallBack,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Column(
                    children: [
                      Icon(
                        Icons.delete,
                        size: 20,
                        color: Colors.white,
                      ),
                      Text(
                        "Eliminar",
                        style: OverFonts.whiteLoginInputLabel,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
