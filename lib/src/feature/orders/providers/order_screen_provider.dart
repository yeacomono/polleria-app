import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:polleria_app/src/feature/tables/models/tables_model.dart';
import 'package:polleria_app/src/feature/products/models/products_model.dart';

/// TEXTEDITING CONTROLLER FROM SCREEN REGISTER ORDER
final nameCustomerController = Provider(
  (ref) {
    return TextEditingController();
  },
);

/// SELECT TABLE FROM SCREEN REGISTER ORDER
final slectTable = StateProvider<TablesModel?>(
  (ref) {
    return null;
  },
);

/// COUNTER PRODUCTS ADD FROM ORDER DETAIL SCREEN
final counterProd = StateProvider<int>(
  (ref) {
    return 0;
  },
);

final selectProd = StateProvider<ProductModel?>(
  (ref) {
    return null;
  },
);
