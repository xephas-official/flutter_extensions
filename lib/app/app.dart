import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../features/products/presentation/products_screen.dart';
import 'theme/exporter.dart';

/// Main application widget
class ShoppingCartApp extends ConsumerWidget {
  const ShoppingCartApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Flutter Extensions Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const ProductsScreen(),
    );
  }
}
