import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:polleria_app/src/core/constants/over_colors.dart';
import 'package:polleria_app/src/core/constants/over_fonts.dart';
import 'package:polleria_app/src/feature/home/home_provider.dart';
import 'package:polleria_app/src/feature/home/widgets/drawer_menu.dart';

class HomeScreen extends ConsumerWidget {
  static const String name = "HomeScreen";
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeNot = ref.watch(homeNotifier);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: OverColors.primaryColor,
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('HOME', style: OverFonts.whiteTitle),
      ),
      drawer: const DrawerMenu(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: homeNot.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // number of items in each row
                  mainAxisSpacing: 8.0, // spacing between rows
                  crossAxisSpacing: 8.0, // spacing between columns
                ),
                itemCount: homeNot.menuList?.length,
                itemBuilder: (BuildContext context, int index) {
                  return ItemModule(
                    name: homeNot.menuList?[index].name ?? '',
                    onTap: () {
                      final router = GoRouter.of(context);
                      router.pushNamed(homeNot.menuList?[index].router ?? '');
                    },
                  );
                },
              ),
      ),
    );
  }
}

class ItemModule extends StatelessWidget {
  final String name;
  final Function() onTap;
  const ItemModule({
    super.key,
    required this.name,
    required this.onTap,
  });
  Color generateRandomColor() {
    const baseColor = 0xFF494CAF; // Color base
    final random = Random();

    // Variar ligeramente el color (modificando los valores de rojo, verde o azul)
    final red = ((baseColor >> 16) & 0xFF) + random.nextInt(40) - 20; // +/- 20
    final green = ((baseColor >> 8) & 0xFF) + random.nextInt(40) - 20; // +/- 20
    final blue = (baseColor & 0xFF) + random.nextInt(40) - 20; // +/- 20

    // Asegurarse de que los valores estén dentro del rango válido (0-255)
    return Color.fromARGB(
      255,
      red.clamp(0, 255),
      green.clamp(0, 255),
      blue.clamp(0, 255),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onTap,
      child: Container(
        decoration: BoxDecoration(
            color: generateRandomColor(),
            borderRadius: BorderRadius.circular(15)),
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.add_home_outlined,
              size: 30,
              color: Colors.white,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
