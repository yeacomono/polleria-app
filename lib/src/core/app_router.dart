import 'package:go_router/go_router.dart';
import 'package:polleria_app/src/feature/auth/login_screen.dart';
import 'package:polleria_app/src/feature/home/home_screen.dart';
import 'package:polleria_app/src/feature/orders/models/order_model.dart';
import 'package:polleria_app/src/feature/orders/screens/order_detail_screen.dart';
import 'package:polleria_app/src/feature/orders/screens/order_history_screen.dart';
import 'package:polleria_app/src/feature/orders/screens/order_screen.dart';
import 'package:polleria_app/src/feature/orders/screens/order_state_screen.dart';
import 'package:polleria_app/src/feature/products/products_screen.dart';
import 'package:polleria_app/src/feature/products/screens/register_products_screen.dart';
import 'package:polleria_app/src/feature/users/screens/register_users_screen.dart';
import 'package:polleria_app/src/feature/users/users_screen.dart';

final router = GoRouter(
  initialLocation: "/${LoginScreen.name}",
  routes: [
    GoRoute(
      builder: (context, state) => const LoginScreen(),
      path: "/${LoginScreen.name}",
      name: LoginScreen.name,
    ),
    GoRoute(
      builder: (context, state) => const HomeScreen(),
      path: "/${HomeScreen.name}",
      name: HomeScreen.name,
    ),

    /// USERS SCREENS
    GoRoute(
      builder: (context, state) => const UsersScreen(),
      path: "/${UsersScreen.name}",
      name: UsersScreen.name,
    ),
    GoRoute(
      builder: (context, state) => const RegisterUsersScreen(),
      path: "/${RegisterUsersScreen.name}",
      name: RegisterUsersScreen.name,
    ),

    /// PRODUCTS SCREENS
    GoRoute(
      builder: (context, state) => const ProductScreen(),
      path: "/${ProductScreen.name}",
      name: ProductScreen.name,
    ),
    GoRoute(
      builder: (context, state) => const RegisterProductsScreen(),
      path: "/${RegisterProductsScreen.name}",
      name: RegisterProductsScreen.name,
    ),
    GoRoute(
      builder: (context, state) => const OrderScreen(),
      path: "/${OrderScreen.name}",
      name: OrderScreen.name,
    ),

    GoRoute(
      builder: (context, state) => const OrderStateScreen(),
      path: "/${OrderStateScreen.name}",
      name: OrderStateScreen.name,
    ),
    GoRoute(
      builder: (context, state) => OrderDetailScreen(
        model: state.extra as OrderModel,
      ),
      path: "/${OrderDetailScreen.name}",
      name: OrderDetailScreen.name,
    ),
    GoRoute(
      builder: (context, state) => const OrderHistoryScreen(),
      path: "/${OrderHistoryScreen.name}",
      name: OrderHistoryScreen.name,
    ),
  ],
);
