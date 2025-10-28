import '../app_exporter.dart';
import '../features/products/products_screen.dart';

/// Main application widget
class ShoppingCartApp extends ConsumerWidget {
  /// Constructor
  const ShoppingCartApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appTheme = ref.watch(appThemeProvider);

    return MaterialApp(
      // -- Theme --
      color: appColor,
      theme: appTheme,

      // -- Title --
      title: appTitle,
      restorationScopeId: appId,

      // -- Debug Mode --
      debugShowCheckedModeBanner: false,

      // -- Home Screen --
      home: const ProductsScreen(),

      // -- Bouncing Scroll Behavior --
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        physics: const BouncingScrollPhysics(),
        scrollbars: false,
      ),
    );
  }
}
