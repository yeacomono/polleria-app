import 'package:dropdown_flutter/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:polleria_app/src/core/core.dart';
import 'package:polleria_app/src/feature/orders/models/order_item_model.dart';
import 'package:polleria_app/src/feature/orders/models/order_model.dart';
import 'package:polleria_app/src/feature/orders/providers/order_detail_provider.dart';
import 'package:polleria_app/src/feature/orders/providers/order_screen_provider.dart';
import 'package:polleria_app/src/feature/products/models/products_model.dart';

class OrderDetailScreen extends ConsumerStatefulWidget {
  static const String name = "OrderDetailScreen";
  final OrderModel model;
  const OrderDetailScreen({required this.model, super.key});

  @override
  ConsumerState<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends ConsumerState<OrderDetailScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (v) {
        ref.read(orderDetailNotifier.notifier).listOrderItembyOrderID(
              orderID: widget.model.id!,
            );
        ref
            .read(orderDetailNotifier.notifier)
            .updateOrderModelTotalCount(widget.model);
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final comboProdAsync = ref.watch(productsCombo);
    final orderdetailProv = ref.watch(orderDetailNotifier);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          (widget.model.customerName ?? '${widget.model.total}').toUpperCase(),
          style: OverFonts.whiteTitle,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: false,
        titleSpacing: 0,
        backgroundColor: OverColors.primaryColor,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.amber.shade900,
                  borderRadius: BorderRadius.circular(20)),
              child: Center(
                child: Text(
                  "Total: ${orderdetailProv.orderModel?.total ?? '0.0'}",
                  style: OverFonts.whiteTitle,
                ),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'PRODUCTO',
              textAlign: TextAlign.start,
              style: OverFonts.blackDrawerItem,
            ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    child: comboProdAsync.when(
                      data: (List<ProductModel> data) {
                        return SizedBox(
                          child: DropdownFlutter<ProductModel>.search(
                            decoration: CustomDropdownDecoration(
                              closedBorder:
                                  Border.all(color: Colors.grey.shade800),
                              closedBorderRadius: BorderRadius.circular(5),
                              expandedBorderRadius: BorderRadius.circular(5),
                            ),
                            items: data,
                            listItemBuilder:
                                (context, item, isSelected, onItemSelect) {
                              return Text(item.name ?? '');
                            },
                            headerBuilder: (context, selectedItem, enabled) {
                              return Text(selectedItem.name ?? '');
                            },
                            onChanged: (value) {
                              ref.read(selectProd.notifier).state = value;
                            },
                          ),
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
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: IconButton(
                          color: Colors.white,
                          onPressed: () {
                            ref.read(counterProd.notifier).state--;
                            if (ref.read(counterProd) < 0) {
                              ref.read(counterProd.notifier).state = 0;
                              return;
                            }
                          },
                          icon: const Icon(Icons.remove),
                        ),
                      ),
                      Container(
                        width: 70,
                        height: 45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: Colors.grey,
                          ),
                        ),
                        child: Builder(builder: (context) {
                          final counter = ref.watch(counterProd);
                          return Center(
                            child: Text(
                              "$counter",
                              style: const TextStyle(fontSize: 18),
                            ),
                          );
                        }),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: IconButton(
                          onPressed: () {
                            ref.read(counterProd.notifier).state++;
                          },
                          icon: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: InkWell(
                    onTap: () async {
                      if (ref.read(selectProd) == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Por favor selecciona un producto'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                        return;
                      }
                      await ref
                          .read(orderDetailNotifier.notifier)
                          .insertOrderItem(
                            quantity: ref.read(counterProd),
                            product: ref.read(selectProd)!,
                            orderID: widget.model.id!,
                          );
                      await ref
                          .read(orderDetailNotifier.notifier)
                          .getOrderById(orderID: widget.model.id!);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.15,
                      decoration: BoxDecoration(
                        color: OverColors.secondaryColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.all(15),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "AGREGAR",
                            style: OverFonts.whiteLoginInput,
                          ),
                          Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            orderdetailProv.isLoadingListOrders
                ? const Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: CircularProgressIndicator(),
                        )
                      ],
                    ),
                  )
                : Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        await ref
                            .read(orderDetailNotifier.notifier)
                            .listOrderItembyOrderID(
                              orderID: widget.model.id!,
                            );
                      },
                      child: ListView.separated(
                        itemBuilder: (BuildContext context, int index) {
                          return ItemListOrderItems(
                            ordermodel: widget.model,
                            model: orderdetailProv.listOrders![index],
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider();
                        },
                        itemCount: orderdetailProv.listOrders?.length ?? 0,
                      ),
                    ),
                  ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: OverColors.primaryColor,
        onPressed: () {},
        label: const Text(
          "CERRAR CUENTA",
          style: OverFonts.whiteLoginInput,
        ),
      ),
    );
  }
}

class ItemListOrderItems extends ConsumerWidget {
  final OrderItemModel model;
  final OrderModel ordermodel;
  const ItemListOrderItems({
    super.key,
    required this.model,
    required this.ordermodel,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
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
                "Producto: ${model.productName ?? ''}",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Cantidad: ${model.quantity}",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "SubTotal: ${model.subtotal}",
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const Expanded(child: SizedBox()),
          InkWell(
            onTap: () async {
              await ref.read(orderDetailNotifier.notifier).deleteOrderItem(
                    orderID: ordermodel.id!,
                    orderItemID: model.id!,
                  );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
              decoration: BoxDecoration(
                  color: Colors.red.shade400,
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
        ],
      ),
    );
  }
}
