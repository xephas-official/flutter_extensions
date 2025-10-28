# Flutter Extensions - AI Coding Agent Instructions

This is a **training/educational Flutter project** demonstrating Dart extension methods through a mini shopping cart app. The codebase prioritizes clarity and teaching patterns over production complexity.

## Code Style & Quality Standards

### Dart Best Practices
- **Concise and Declarative**: Write modern, functional, and declarative Dart code
- **Immutability**: Prefer immutable data structures; widgets (especially `StatelessWidget`) must be immutable
- **Composition over Inheritance**: Favor composition for building complex widgets and logic
- **Naming**: Use `PascalCase` for classes, `camelCase` for members/variables/functions, `snake_case` for files
- **Line Length**: Keep lines to 80 characters or fewer
- **Null Safety**: Leverage Dart's null safety features; avoid `!` unless value is guaranteed non-null
- **Functions**: Keep functions short with a single purpose (strive for <20 lines)
- **Pattern Matching**: Use pattern matching and records where they simplify code
- **Arrow Functions**: Use arrow syntax for simple one-line functions

### Flutter-Specific Guidelines
- **Const Constructors**: Use `const` constructors whenever possible to reduce rebuilds
- **Build Method Performance**: Avoid expensive operations (network calls, complex computations) in `build()` methods
- **Private Widgets**: Use small, private `Widget` classes instead of helper methods that return `Widget`
- **List Performance**: Use `ListView.builder` or `SliverList` for long lists
- **Isolates**: Use `compute()` for expensive calculations to avoid blocking UI thread

### Code Organization
- **SOLID Principles**: Apply throughout the codebase
- **Separation of Concerns**: UI logic separate from business logic
- **Meaningful Names**: Avoid abbreviations; use consistent, descriptive names
- **Comments**: Explain why, not what; use `///` for doc comments on all public APIs
- **Error Handling**: Anticipate and handle potential errors; don't fail silently

## Architecture Overview

**Feature-Driven Structure** with extension-first API design:
- `lib/core/extensions/` - **Central pattern**: All 6 extension categories (context, widget, num, list, string, color)
- `lib/features/` - Feature modules (products, cart) with Riverpod state management
- `lib/data/` - Models and repositories (no backend, uses sample data)
- `lib/app/theme/` - Centralized Material Design 3 theme configuration
- Each folder has `exporter.dart` for barrel file pattern

**Logical Layers**:
- **Presentation** (`features/*/presentation/`) - Widgets, screens
- **Domain** (not present in this simple app) - Business logic classes
- **Data** (`data/`) - Model classes, repositories
- **Core** (`core/`) - Shared utilities, extensions

**State Management**: Riverpod with `StateNotifier` pattern
- Cart state in `lib/features/cart/providers/cart_provider.dart`
- Computed providers for derived values (item count, total price)
- Use `ref.watch()` in widgets, `ref.read()` in callbacks
- Never mutate state directly - always create new objects in `StateNotifier`

## Extension Philosophy (Critical Pattern)

**This codebase demonstrates extension-based API design.** When adding UI code:

1. **Always use extensions over raw Flutter widgets** where they exist
2. **Import extensions globally**: `import '../../core/extensions/exporter.dart'`
3. **Chain methods fluently**: `Text('Hello').paddingAll(16).center.card()`
4. **Break down large `build()` methods** into smaller, reusable private Widget classes
5. **Use `const` constructors** in extension chains whenever possible for performance

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

// ✅ DO use extension chains with const where possible
const [
  Text('Title'),
  Text('Subtitle'),
].toColumn(spacing: 8).paddingAll(16)

// Context shortcuts (replaces verbose Theme.of/MediaQuery.of/Navigator.of patterns)
context.colorScheme.primary        // instead of Theme.of(context).colorScheme.primary
context.textTheme.titleMedium      // instead of Theme.of(context).textTheme.titleMedium
context.screenWidth                // instead of MediaQuery.of(context).size.width
context.showSnackBar('Message')    // instead of ScaffoldMessenger.of(context).showSnackBar()
context.push(NewScreen())          // instead of Navigator.push()
context.pop()                      // instead of Navigator.pop()

// Number utilities (reduces boilerplate for spacing and formatting)
16.heightBox                       // SizedBox(height: 16)
12.paddingAll                      // EdgeInsets.all(12)
8.borderRadius                     // BorderRadius.circular(8)
price.toCurrency                   // Formatted: '$123.45' with comma separators

// Layout helpers (automatic spacing via divide() method)
[Widget1(), Widget2()].toColumn(spacing: 8)        // Column with SizedBox spacing
[Widget1(), Widget2()].toRow(spacing: 12)          // Row with SizedBox spacing
[Widget1(), Widget2()].toListView(separator: Divider())  // ListView with dividers
```

### Widget Extension Patterns

```dart
// Padding shortcuts
widget.paddingAll(16)              // EdgeInsets.all(16)
widget.paddingSymmetric(horizontal: 16, vertical: 8)
widget.paddingOnly(left: 16, top: 8)

// Layout wrappers
widget.center                      // Center widget
widget.expanded                    // Expanded widget
widget.flexible(flex: 2)           // Flexible widget

// Material wrappers
widget.card(elevation: 4)          // Card wrapper
widget.container(width: 200, color: Colors.blue)

// Interactions
widget.onTap(() => print('Tapped'))
widget.hero('unique-tag')
widget.visible(isLoggedIn)         // Conditional rendering
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

// StateNotifier immutability pattern - ALWAYS create new lists
void updateQuantity(String productId, int quantity) {
  final index = state.indexWhere((item) => item.product.id == productId);
  if (index >= 0) {
    final updatedItem = state[index].copyWith(quantity: quantity);
    state = [
      ...state.sublist(0, index),
      updatedItem,
      ...state.sublist(index + 1),
    ];
  }
}
```

### Model Pattern
```dart
// Immutable data classes with copyWith()
class Product {
  const Product({
    required this.id,
    required this.name,
    required this.price,
  });

  final String id;
  final String name;
  final double price;

  // Factory for JSON-like data
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as String? ?? '',
      name: map['name'] as String? ?? '',
      price: (map['price'] as num?)?.toDouble() ?? 0.0,
    );
  }

  // Serialization
  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'price': price};
  }

  // Immutable updates
  Product copyWith({String? id, String? name, double? price}) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
    );
  }
}
```

### Theming Pattern
```dart
// Material Design 3 with ColorScheme.fromSeed
ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.deepPurple,
    brightness: Brightness.light,
  ),
  // Access in widgets via context.colorScheme extension
)
```

## Development Commands

```bash
# Run app (no build configuration needed)
flutter run

# Get dependencies after pubspec changes
flutter pub get

# Add a new dependency
flutter pub add <package_name>

# Add a dev dependency
flutter pub add dev:<package_name>

# Remove a dependency
flutter pub remove <package_name>

# Code generation (Riverpod generators - though not actively used)
flutter pub run build_runner build --delete-conflicting-outputs

# Format code (80 character line length)
dart format .

# Analyze code for issues
dart analyze

# Clean build artifacts
flutter clean && flutter pub get
```

## Testing (Not Implemented in This Project)

This is an educational project without tests, but if implementing:
- Use `flutter test` for unit and widget tests
- Follow Arrange-Act-Assert pattern
- Prefer `package:checks` for assertions over default matchers
- Mock dependencies with `mockito` or `mocktail` if needed
- Use `integration_test` package for end-to-end flows

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
5. **Don't exceed 80 character line length** - Format with `dart format`
6. **Don't use `!` operator carelessly** - Only use when value is guaranteed non-null
7. **Don't make helper methods that return widgets** - Create private Widget classes instead
8. **Don't perform expensive operations in `build()`** - Use `compute()` for heavy calculations
9. **Don't forget `const` constructors** - Use wherever possible for performance

## Layout Best Practices

### Building Flexible Layouts
- **`Expanded`**: Fill remaining space along main axis in Row/Column
- **`Flexible`**: Shrink to fit but not necessarily grow (don't mix with `Expanded`)
- **`Wrap`**: Auto-wrap widgets to next line when overflow occurs
- **`SingleChildScrollView`**: For fixed-size content larger than viewport
- **`ListView.builder`/`GridView.builder`**: Always use builder for long lists (performance)
- **`FittedBox`**: Scale or fit single child within parent
- **`LayoutBuilder`**: Make responsive decisions based on available space

### Responsive Design
```dart
// Use LayoutBuilder for responsive layouts
LayoutBuilder(
  builder: (context, constraints) {
    if (constraints.maxWidth > 600) {
      return WideLayout();
    }
    return NarrowLayout();
  },
)

// Or use MediaQuery via context extension
final isWideScreen = context.screenWidth > 600;
```

## Theming & Visual Design

### Color & Contrast
- **WCAG Guidelines**: Maintain 4.5:1 contrast for normal text, 3:1 for large text
- **60-30-10 Rule**: 60% primary/neutral, 30% secondary, 10% accent colors
- **ColorScheme.fromSeed**: Generate harmonious palettes from single seed color
- **Theme Extensions**: Use `ThemeExtension` for custom design tokens not in `ThemeData`

### Typography
- **Font Families**: Limit to 1-2 families; use `google_fonts` package if needed
- **Font Scale**: Define clear hierarchy (display, title, body, caption)
- **Line Height**: Use 1.4x-1.6x font size for readability
- **Line Length**: Aim for 45-75 characters per line for body text
- **Access Text Styles**: Always use `context.textTheme.bodyMedium` instead of direct TextStyle

### Material Design 3 Implementation
```dart
// Define both light and dark themes
MaterialApp(
  theme: ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      brightness: Brightness.light,
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(fontSize: 57, fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(fontSize: 14, height: 1.4),
    ),
  ),
  darkTheme: ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      brightness: Brightness.dark,
    ),
  ),
  themeMode: ThemeMode.system, // Respects system setting
)
```

## Accessibility (A11Y)

- **Color Contrast**: Ensure 4.5:1 minimum contrast ratio for text
- **Dynamic Text Scaling**: Test UI with increased system font sizes
- **Semantic Labels**: Use `Semantics` widget for screen reader support
- **Testing**: Regularly test with TalkBack (Android) and VoiceOver (iOS)
- **Touch Targets**: Maintain minimum 48x48 logical pixels for interactive elements

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

## Documentation Style

When writing documentation comments:
- **Use `///` for doc comments**: Enables documentation generation
- **Start with single-sentence summary**: Concise user-centric summary ending with period
- **Separate summary from details**: Add blank line after first sentence
- **Avoid redundancy**: Don't repeat obvious information from code context
- **Be brief and clear**: Avoid jargon, acronyms, and excessive markdown
- **Use backticks for code**: Enclose inline code and specify language in code blocks
- **Document public APIs**: Always document public classes, methods, and functions
- **Explain why, not what**: Code should be self-explanatory; comments explain reasoning

Example:
```dart
/// Converts a number to currency format with dollar sign and comma separators.
///
/// Returns a formatted string like '$1,234.56' for display purposes.
/// Uses two decimal places for cents.
String get toCurrency {
  return '\$${toStringAsFixed(2).replaceAllMapped(...)}';
}
```

## What This Project Is NOT

- Not production-ready (no error handling, API calls, persistence)
- Not demonstrating testing patterns (educational focus only)
- Not showcasing advanced architecture (intentionally simple for learning)
