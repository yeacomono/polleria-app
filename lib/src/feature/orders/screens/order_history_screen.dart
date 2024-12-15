import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:polleria_app/src/core/core.dart';
import 'package:polleria_app/src/feature/auth/login_provider.dart';
import 'package:polleria_app/src/feature/orders/models/order_model.dart';
import 'package:polleria_app/src/feature/orders/providers/order_provider.dart';
import 'package:polleria_app/src/feature/orders/screens/order_detail_screen.dart';
import 'package:polleria_app/src/feature/orders/screens/order_state_screen.dart';

class OrderHistoryScreen extends ConsumerStatefulWidget {
  static const String name = "OrderHistoryScreen";
  const OrderHistoryScreen({super.key});

  @override
  ConsumerState<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends ConsumerState<OrderHistoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Estados para el filtro
  List<String> statuses = [
    "standby",
    "pending",
    "preparing",
    "ready",
    "delivered",
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((v) {
      if (ref.read(userSessionProv).role == "Cocinero") {
        statuses = [
          "pending",
          "preparing",
          "ready",
        ];
      }
      ref.read(orderNotifier.notifier).listOrders();
      _tabController.addListener(
        () {
          ref.read(orderNotifier.notifier).listOrders();
        },
      );
    });
    _tabController = TabController(length: statuses.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Método para obtener el texto del estado en español
  String _getStatusText(String status) {
    switch (status) {
      case "pending":
        return "Pendiente";
      case "preparing":
        return "Preparando";
      case "ready":
        return "Listo";
      case "delivered":
        return "Entregado";
      case "standby":
        return "En espera";
      default:
        return "Desconocido";
    }
  }

  String _getStatusTextUpdate(String status) {
    switch (status) {
      case "standby":
        return "pending";
      case "pending":
        return "preparing";
      case "preparing":
        return "ready";
      case "ready":
        return "delivered";
      default:
        return "";
    }
  }

  // Método para filtrar órdenes según el estado
  List<OrderModel> _getOrdersByStatus(String status, List<OrderModel> orders) {
    return orders.where((order) => order.status == status).toList();
  }

  void goToNextPage(TabController tabController) {
    if (tabController.index < tabController.length - 1) {
      tabController.animateTo(
        tabController.index + 1,
        duration: const Duration(milliseconds: 300), // Duración de la animación
        curve: Curves.easeInOut, // Curva de animación
      );
    }
  }

  bool enableAction(OrderModel order) {
    final role = ref.read(userSessionProv).role;
    if (role == "Cocinero") {
      if (order.status == "pending" || order.status == "preparing") {
        return true;
      }
      return false;
    }
    if (order.status == "pending" ||
        order.status == "preparing" ||
        order.status == "delivered") {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final orderNitProv = ref.watch(orderNotifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "HISTORIAL DE ÓRDENES",
          style: OverFonts.whiteTitle,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: false,
        backgroundColor: OverColors.primaryColor,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          tabAlignment: TabAlignment.start,
          tabs: statuses
              .map(
                (status) => Tab(
                  text: _getStatusText(status),
                  icon: const Icon(
                    Icons.add_card_rounded,
                    size: 40,
                  ),
                ),
              )
              .toList(),
        ),
      ),
      body: orderNitProv.isLoading
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(
              controller: _tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: statuses.map(
                (status) {
                  final filteredOrders =
                      _getOrdersByStatus(status, orderNitProv.listOrders ?? []);
                  return filteredOrders.isEmpty
                      ? const Center(
                          child: Text("No hay órdenes en este estado."))
                      : RefreshIndicator(
                          onRefresh: () async {
                            ref.read(orderNotifier.notifier).listOrders();
                          },
                          child: ListView.separated(
                            itemCount: filteredOrders.length,
                            itemBuilder: (context, index) {
                              final order = filteredOrders[index];
                              return Slidable(
                                key: const ValueKey(0),
                                enabled: enableAction(order),
                                endActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  children: [
                                    CustomSlidableAction(
                                      onPressed: (_) async {
                                        final status = _getStatusTextUpdate(
                                          order.status ?? '',
                                        );
                                        await ref
                                            .read(orderNotifier.notifier)
                                            .updateOrder(
                                                order: order.copyWith(
                                                    status: status));
                                        goToNextPage(_tabController);
                                      },
                                      backgroundColor: OverColors.primaryColor,
                                      foregroundColor: Colors.white,
                                      child: const Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.navigate_next_rounded,
                                            size: 50,
                                          ),
                                          Text("SIQUIENTE ESTADO"),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                child: ItemListOrders(
                                  model: order,
                                  showDelete: false,
                                  onTapOrder: () {
                                    final role = ref.read(userSessionProv).role;
                                    if (role == "Cocinero") {
                                      return;
                                    }
                                    final router = GoRouter.of(context);
                                    router.pushNamed(
                                      OrderDetailScreen.name,
                                      extra: orderNitProv.listOrders?[index],
                                    );
                                  },
                                  removeCallBack: () {
                                    ref
                                        .read(orderNotifier.notifier)
                                        .removeOrder(
                                          idOrder: order.id,
                                        );
                                  },
                                ),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const Divider(
                                height: 0,
                                color: Colors.grey,
                              );
                            },
                          ),
                        );
                },
              ).toList(),
            ),
    );
  }
}
