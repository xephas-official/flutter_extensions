# Flutter Extensions - AI Coding Agent Instructions

This is a **training/educational Flutter project** demonstrating Dart extension methods through a mini shopping cart app. The codebase prioritizes clarity and teaching patterns over production complexity.

## Architecture Overview

**Feature-Driven Structure** with extension-first API design:
- `lib/core/extensions/` - **Central pattern**: All 6 extension categories (context, widget, num, list, string, color)
- `lib/features/` - Feature modules (products, cart) with Riverpod state management
- `lib/data/` - Models and repositories (no backend, uses sample data)
- Each folder has `exporter.dart` for barrel file pattern

**State Management**: Riverpod with `StateNotifier` pattern
- Cart state in `lib/features/cart/providers/cart_provider.dart`
- Computed providers for derived values (item count, total price)
- Use `ref.watch()` in widgets, `ref.read()` in callbacks

## Extension Philosophy (Critical Pattern)

**This codebase demonstrates extension-based API design.** When adding UI code:

1. **Always use extensions over raw Flutter widgets** where they exist
2. **Import extensions globally**: `import '../../core/extensions/exporter.dart'`
3. **Chain methods fluently**: `Text('Hello').paddingAll(16).center.card()`

### Quick Reference (Use These Patterns)

```dart
// ❌ DON'T write traditional Flutter code
Container(
  padding: EdgeInsets.all(16),
  child: Column(
    children: [
      Text('Title'),
      SizedBox(height: 8),
      Text('Subtitle'),
    ],
  ),
)

// ✅ DO use extension chains
[
  Text('Title'),
  Text('Subtitle'),
].toColumn(spacing: 8).paddingAll(16)

// Context shortcuts
context.colorScheme.primary        // instead of Theme.of(context).colorScheme.primary
context.screenWidth                // instead of MediaQuery.of(context).size.width
context.showSnackBar('Message')    // instead of ScaffoldMessenger.of(context).showSnackBar()
context.push(NewScreen())          // instead of Navigator.push()

// Number utilities
16.heightBox                       // SizedBox(height: 16)
12.paddingAll                      // EdgeInsets.all(12)
8.borderRadius                     // BorderRadius.circular(8)
price.toCurrency                   // Formatted: '$123.45'
```

## Key Files & Patterns

### Extension Categories (lib/core/extensions/)
- **context_extensions.dart** - Theme, MediaQuery, navigation shortcuts
- **widget_extensions.dart** - Padding, layout wrappers, card/container builders
- **num_extensions.dart** - Spacing (heightBox/widthBox), padding, currency formatting
- **list_extensions.dart** - toColumn/toRow/toListView with auto-spacing via `divide(separator)`
- **string_extensions.dart** - Case conversion, validation
- **color_extensions.dart** - Color manipulation utilities

### State Management Pattern
```dart
// Provider definition (in lib/features/*/providers/)
final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  return CartNotifier();
});

// Derived provider (computed state)
final cartItemCountProvider = Provider<int>((ref) {
  final cart = ref.watch(cartProvider);
  return cart.fold(0, (sum, item) => sum + item.quantity);
});

// Widget consumption
final itemCount = ref.watch(cartItemCountProvider);  // in build()
ref.read(cartProvider.notifier).addProduct(product); // in callbacks
```

### Model Pattern
- Immutable classes with `copyWith()` methods
- Factory constructors: `fromMap()` for JSON-like data
- `toMap()` for serialization (though no backend here)

## Development Commands

```bash
# Run app (no build configuration needed)
flutter run

# Get dependencies after pubspec changes
flutter pub get

# Code generation (Riverpod generators - though not actively used)
flutter pub run build_runner build --delete-conflicting-outputs

# Clean build artifacts
flutter clean && flutter pub get
```

## Import Conventions

**Always use relative imports** with barrel exports:
```dart
import '../../core/extensions/exporter.dart';        // Extensions
import '../../data/models/exporter.dart';            // Models
import '../cart/providers/exporter.dart';            // Providers
```

**Never import individual files** - use exporter.dart to maintain clean dependencies.

## Common Mistakes to Avoid

1. **Don't write vanilla Flutter when extensions exist** - Check `lib/core/extensions/` first
2. **Don't use absolute imports** - Use relative paths with exporters
3. **Don't mutate Riverpod state directly** - Always create new lists/objects in StateNotifier
4. **Don't forget ProviderScope** - Already wrapped in `main.dart`, don't re-wrap

## Adding New Features

1. **New extensions**: Add to appropriate `lib/core/extensions/*.dart`, update `exporter.dart`
2. **New feature module**: Create folder in `lib/features/` with `providers/` and `presentation/` subfolders
3. **New models**: Add to `lib/data/models/`, update exporter
4. **Sample data**: Add to `ProductRepository.getSampleProducts()` in `lib/data/repositories/product_repository.dart`

## Documentation References

- `docs/EXTENSION_CHEATSHEET.md` - All extension examples with before/after comparisons
- `docs/TRAINING_GUIDE.md` - Educational context and best practices
- `docs/PROJECT_SUMMARY.md` - Architecture overview and feature list
- `README.md` - Quick start and feature showcase

## What This Project Is NOT

- Not production-ready (no error handling, API calls, persistence)
- Not demonstrating testing patterns (educational focus only)
- Not showcasing advanced architecture (intentionally simple for learning)
