import '../../app_exporter.dart';

/// app bar on the detail screen
class ProductAppBar extends StatelessWidget {
  /// constructor
  const ProductAppBar({
    required this.product,
    super.key,
  });

  /// product
  final Product product;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 300,
      pinned: true,
      backgroundColor: context.colorScheme.primary,
      foregroundColor: white,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          product.name,
          style: boldTextStyle.copyWith(
            color: white,
          ),
        ),
        background: Hero(
          tag: 'product_${product.id}',
          child: Material(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    context.colorScheme.primary,
                    context.colorScheme.secondary,
                  ],
                ),
              ),
              child: Center(
                child: Text(
                  product.imageUrl,
                  style: baseFont.copyWith(fontSize: 120),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
