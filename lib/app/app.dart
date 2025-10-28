import '../app_exporter.dart';
import '../features/products/products_screen.dart';
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
      themeMode: ThemeMode.system,
      home: const ProductsScreen(),
    );
  }
}
