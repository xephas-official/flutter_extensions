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
- `lib/global/extensions/` - **Central pattern**: All 6 extension categories (context, widget, num, list, string, color)
- `lib/global/constants/` - Centralized constants (spacing, border_radius, colors, durations, text_styles)
- `lib/global/widgets/` - Reusable widgets (Spacing with gap package, ValueChip, EmptySpace)
- `lib/features/` - Feature modules (products, cart) with Riverpod state management
- `lib/data/` - Models and repositories (no backend, uses sample data)
- `lib/app/theme/` - Material Design 3 theme configuration
- Each folder has `exporter.dart` for barrel file pattern

**Logical Layers**:
- **Presentation** (`features/*/presentation/` or `features/*/widgets/`) - Widgets, screens
- **Domain** (not present in this simple app) - Business logic classes
- **Data** (`data/`) - Model classes, repositories
- **Global** (`global/`) - Shared utilities, extensions, constants, reusable widgets

**State Management**: Riverpod with `StateNotifier` pattern
- Cart state in `lib/features/cart/providers/cart_provider.dart`
- Computed providers for derived values (item count, total price)
- Use `ref.watch()` in widgets, `ref.read()` in callbacks
- Never mutate state directly - always create new objects in `StateNotifier`

## Extension Philosophy (Critical Pattern)

**This codebase demonstrates extension-based API design.** When adding UI code:

1. **Always use extensions over raw Flutter widgets** where they exist
2. **Import globally via app_exporter**: `import '../../app_exporter.dart'` (includes extensions, constants, widgets)
3. **Use constants over magic numbers**: `borderRadius12`, `spacing16`, `appGreen` instead of inline values
4. **Use Spacing widget**: `Spacing(of: 12)` instead of `SizedBox` - auto-adapts to Column/Row direction
5. **Chain methods fluently**: `Text('Hello').paddingAll(16).center.card()`
6. **Break down large `build()` methods** into smaller, reusable private Widget classes
7. **Use `const` constructors** in extension chains whenever possible for performance

### Quick Reference (Use These Patterns)

```dart
// ❌ DON'T write traditional Flutter code
Container(
  padding: EdgeInsets.all(16),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(12),
    color: Colors.blue,
  ),
  child: Column(
    children: [
      Text('Title'),
      SizedBox(height: 8),
      Text('Subtitle'),
    ],
  ),
)

// ✅ DO use constants, extensions, and Spacing widget
Column(
  children: [
    const Text('Title'),
    const Spacing(of: spacing8),  // gap package - auto-adapts to Column/Row
    const Text('Subtitle'),
  ],
).paddingAll(spacing16)
 .container(color: blue, borderRadius: borderRadius12)

// Context shortcuts (replaces verbose Theme.of/MediaQuery.of/Navigator.of patterns)
context.colorScheme.primary        // instead of Theme.of(context).colorScheme.primary
context.textTheme.titleMedium      // instead of Theme.of(context).textTheme.titleMedium
context.screenWidth                // instead of MediaQuery.of(context).size.width
context.showSnackBar('Message')    // instead of ScaffoldMessenger.of(context).showSnackBar()
context.push(NewScreen())          // instead of Navigator.push()
context.pop()                      // instead of Navigator.pop()

// Constants (in lib/global/constants/)
spacing8, spacing12, spacing16     // Spacing values
borderRadius4, borderRadius12      // Border radius values
blue, appGreen, white, black       // Color values
halfSecond, oneSecond              // Duration values

// Number utilities (reduces boilerplate for spacing and formatting)
16.heightBox                       // SizedBox(height: 16) - DEPRECATED: use Spacing widget instead
12.paddingAll                      // EdgeInsets.all(12)
8.borderRadius                     // BorderRadius.circular(8) - DEPRECATED: use borderRadius8 constant

// Currency formatting (using intl package)
price.toUSD                        // '$1,234.56' - US Dollar format
price.toKES                        // 'KES 1,234.56' - Kenyan Shilling
price.toUGX                        // 'UGX 1,234' - Ugandan Shilling (no decimals)
price.toEUR                        // '€1,234.56' - Euro
price.toGBP                        // '£1,234.56' - British Pound

// Number formatting
amount.formatWithCommas            // '1,234,567' - thousand separators
amount.formatCompact               // '1.2K', '3.4M', '5.6B' - compact notation
amount.format                      // Smart: compact for >9999, commas otherwise
amount.toDecimal(2)                // '123.45' - specific decimal places
amount.toPercent                   // '45.5%' - percentage format

// Discount & pricing shortcuts (for cart app)
price.discount20                   // Apply 20% off: 100 → 80.0
price.discount30                   // Apply 30% off: 100 → 70.0
price.discount50                   // Apply 50% off: 100 → 50.0
price.markup20                     // Add 20% markup: 100 → 120.0
price.discountAmount20             // Get savings: 100 → 20.0

// Validation helpers
quantity.isZero / isNotZero        // Check zero values
amount.isPositive / isNegative     // Sign checking
price.isValidPrice                 // 0 < price < 1,000,000
quantity.isValidQuantity           // Positive whole number

// TextLabel conversion (for demo UIs)
price.toTextLabels                 // All 20 format variations
price.toCurrencyLabels             // All 5 currency formats
price.toDiscountLabels             // All discount variations
price.toFormatLabels               // All number formats

// Spacing widget (gap package - preferred over SizedBox)
const Spacing(of: 12)              // Auto-adapts: vertical in Column, horizontal in Row
const SliverSpacing(of: 16)        // For CustomScrollView
const EmptySpace()                 // SizedBox.shrink()

// Layout helpers (automatic spacing via divide() method)
[Widget1(), Widget2()].toColumn(spacing: 8)        // Column with spacing
[Widget1(), Widget2()].toRow(spacing: 12)          // Row with spacing
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

### Extension Categories (lib/global/extensions/)
- **context_extensions.dart** - Theme, MediaQuery, navigation shortcuts
- **widget_extensions.dart** - Padding, layout wrappers, card/container builders
- **num_extensions.dart** - Currency (toUSD, toKES, toUGX, toEUR, toGBP), number formatting (formatWithCommas, formatCompact), discounts (discount20/30/50), validation (isValidPrice, isValidQuantity), TextLabel conversion
- **list_extensions.dart** - toColumn/toRow/toListView with auto-spacing via `divide(separator)`
- **string_extensions.dart** - Case conversion (camelCase, snake_case, PascalCase, etc.), validation (isValidEmail), TextLabel conversion
- **color_extensions.dart** - Color manipulation utilities

### Constants (lib/global/constants/)
- **spacing.dart** - spacing2, spacing4, spacing8, spacing12, spacing16, spacing20, spacing24, spacing32, spacing48, spacing64
- **border_radius.dart** - borderRadius2, borderRadius4, borderRadius8, borderRadius12, borderRadius16, borderRadius200
- **colors.dart** - blue, white, black, appGreen, backgroundColor, navyBlue
- **durations.dart** - halfSecond, oneSecond, twoSeconds, etc.
- **text_styles.dart** - boldTextStyle, regularTextStyle, baseFont

### Widgets (lib/global/widgets/)
- **spacing.dart** - `Spacing(of: double)` using gap package, `SliverSpacing`, `EmptySpace`
- **value_chip.dart** - Chip widget for displaying category badges

### TextLabel Utility (lib/global/utils/)
- **text_label.dart** - Simple class for label/value pairs used in demo UIs
- Pattern: Extensions provide `toTextLabels` getters that return `List<TextLabel>` for all format variations
- Used by `num_extensions.dart` and `string_extensions.dart` to demonstrate all formatting options
- Example: `price.toTextLabels` returns all 20 number format variations for UI display

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

**Always use app_exporter.dart** for global access:
```dart
import '../../app_exporter.dart';  // Includes: extensions, constants, widgets, models, providers, theme
```

This single import provides access to:
- All extensions (context, widget, num, list, string, color)
- All constants (spacing, borderRadius, colors, durations, textStyles)
- All global widgets (Spacing, ValueChip, EmptySpace)
- All models and providers
- Flutter/Riverpod/GoogleFonts packages

**Never import individual files** - use exporter.dart pattern for clean dependencies.

## Common Mistakes to Avoid

1. **Don't write vanilla Flutter when extensions exist** - Check `lib/global/extensions/` first
2. **Don't use magic numbers** - Use constants from `lib/global/constants/` (spacing16, borderRadius12, etc.)
3. **Don't use SizedBox for spacing** - Use `Spacing(of: x)` widget (gap package, auto-adapts)
4. **Don't use inline BorderRadius.circular()** - Use borderRadius constants (borderRadius4, borderRadius12, etc.)
5. **Don't use absolute imports** - Import `../../app_exporter.dart` for everything
6. **Don't mutate Riverpod state directly** - Always create new lists/objects in StateNotifier
7. **Don't forget ProviderScope** - Already wrapped in `main.dart`, don't re-wrap
8. **Don't exceed 80 character line length** - Format with `dart format`
9. **Don't use `!` operator carelessly** - Only use when value is guaranteed non-null
10. **Don't make helper methods that return widgets** - Create private Widget classes instead
11. **Don't perform expensive operations in `build()`** - Use `compute()` for heavy calculations
12. **Don't forget `const` constructors** - Use wherever possible for performance

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

1. **New extensions**: Add to appropriate `lib/global/extensions/*.dart`, update `exporter.dart`
2. **New constants**: Add to `lib/global/constants/*.dart` (spacing, colors, borderRadius, etc.), update `exporter.dart`
3. **New reusable widgets**: Add to `lib/global/widgets/*.dart`, update `exporter.dart`
4. **New feature module**: Create folder in `lib/features/` with `providers/` and `widgets/` subfolders
5. **New models**: Add to `lib/data/models/`, update exporter
6. **Sample data**: Add to `ProductRepository.getSampleProducts()` in `lib/data/repositories/product_repository.dart`

## Key Packages

- **flutter_riverpod** (^2.6.1) - State management
- **google_fonts** (^6.2.1) - Raleway font family
- **uuid** (^4.5.1) - Unique ID generation
- **gap** (^3.0.1) - Spacing widgets that adapt to parent direction (Column/Row)
- **intl** (^0.20.2) - Internationalization and number/currency formatting

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
