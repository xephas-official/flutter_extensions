# 🎓 Training Guide: Dart Extensions in Flutter

## Workshop Overview

This mini shopping cart app is designed to teach developers how to effectively use Dart extensions to write cleaner, more maintainable Flutter code.

---

## 📋 Table of Contents

1. [What are Dart Extensions?](#what-are-dart-extensions)
2. [Why Use Extensions?](#why-use-extensions)
3. [Extension Examples in This App](#extension-examples-in-this-app)
4. [Code Walkthroughs](#code-walkthroughs)
5. [Best Practices](#best-practices)
6. [Exercises](#exercises)

---

## What are Dart Extensions?

Dart extensions allow you to add new functionality to existing types without modifying their original source code or creating subclasses.

### Syntax

```dart
extension ExtensionName on Type {
  // your methods here
}
```

### Example

```dart
extension StringExtensions on String {
  String get capitalize {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}

// Usage
'hello'.capitalize // Returns: 'Hello'
```

---

## Why Use Extensions?

### ✅ Benefits

1. **Cleaner Code** - More readable and expressive
2. **Reduced Boilerplate** - Write less, achieve more
3. **Better IDE Support** - Auto-complete and discoverability
4. **No Inheritance** - Extend sealed/final classes
5. **Chainable APIs** - Fluent interface design

### ❌ Before Extensions

```dart
Widget buildProductCard(Product product) {
  return Container(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(product.name),
        SizedBox(height: 8),
        Text(product.price.toStringAsFixed(2)),
        SizedBox(height: 12),
        ElevatedButton(
          onPressed: () {},
          child: Text('Add to Cart'),
        ),
      ],
    ),
  );
}
```

### ✅ After Extensions

```dart
Widget buildProductCard(Product product) {
  return [
    Text(product.name),
    Text(product.price.toCurrency),
    ElevatedButton(
      onPressed: () {},
      child: Text('Add to Cart'),
    ),
  ].toColumn(spacing: 8).paddingAll(16);
}
```

---

## Extension Examples in This App

### 1. Context Extensions (`context_extensions.dart`)

**Problem:** Accessing theme data requires verbose code

```dart
Theme.of(context).colorScheme.primary
Theme.of(context).textTheme.titleMedium
MediaQuery.of(context).size.width
```

**Solution:** Context extensions

```dart
context.colorScheme.primary
context.textTheme.titleMedium
context.screenWidth
```

**See it in action:**

- `lib/features/products/presentation/widgets/product_card.dart` - Lines using `context.colorScheme`
- `lib/features/cart/presentation/cart_screen.dart` - Lines using `context.showSnackBar()`

---

### 2. Widget Extensions (`widget_extensions.dart`)

**Problem:** Wrapping widgets creates deep nesting

```dart
Center(
  child: Padding(
    padding: EdgeInsets.all(16),
    child: Card(
      child: Text('Hello'),
    ),
  ),
)
```

**Solution:** Chainable widget extensions

```dart
Text('Hello')
  .card()
  .paddingAll(16)
  .center
```

**See it in action:**

- `lib/features/cart/presentation/widgets/cart_item_tile.dart` - `.paddingAll()`, `.container()`, `.expanded`
- `lib/features/cart/presentation/widgets/empty_cart.dart` - `.center`

---

### 3. Number Extensions (`num_extensions.dart`)

**Problem:** Creating spacing and formatting requires repetitive code

```dart
SizedBox(height: 16)
EdgeInsets.all(12)
BorderRadius.circular(8)
'\$${price.toStringAsFixed(2)}'
```

**Solution:** Number extensions

```dart
16.heightBox
12.paddingAll
8.borderRadius
price.toCurrency
```

**See it in action:**

- `lib/features/products/presentation/products_screen.dart` - `16.heightBox`, `16.paddingAll`
- `lib/features/cart/presentation/cart_screen.dart` - `totalPrice.toCurrency`

---

### 4. `List<Widget>` Extensions (`list_extensions.dart`)

**Problem:** Building layouts requires explicit Column/Row widgets

```dart
Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text('Title'),
    SizedBox(height: 8),
    Text('Subtitle'),
  ],
)
```

**Solution:** List extensions with auto-spacing

```dart
[
  Text('Title'),
  Text('Subtitle'),
].toColumn(
  crossAxisAlignment: CrossAxisAlignment.start,
  spacing: 8,
)
```

**See it in action:**

- `lib/features/cart/presentation/widgets/cart_item_tile.dart` - `.toColumn()`, `.toRow()`
- `lib/features/products/presentation/widgets/product_card.dart` - `.toColumn()` with spacing

---

### 5. String Extensions (`string_extensions.dart`)

**Problem:** Common string operations require utility functions

```dart
String toSnakeCase(String input) {
  return input.replaceAllMapped(
    RegExp('([a-z])([A-Z])'),
    (Match m) => '${m.group(1)}_${m.group(2)?.toLowerCase()}',
  );
}
```

**Solution:** String extensions

```dart
'userId'.inSnakeCase // 'user_id'
'user_id'.inCamelCase // 'userId'
'hello'.capitalize // 'Hello'
```

**See it in action:**

- `lib/data/models/product.dart` - Used for API serialization patterns

---

## Code Walkthroughs

### Walkthrough 1: Product Card Widget

**File:** `lib/features/products/presentation/widgets/product_card.dart`

**Key Extensions Used:**

1. `context.colorScheme` - Access theme colors
2. `context.textTheme` - Access text styles
3. `.paddingAll(12)` - Add padding
4. `.toColumn()` - Create vertical layout
5. `.toRow()` - Create horizontal layout
6. `product.price.toCurrency` - Format currency
7. `.hero()` - Wrap with Hero widget
8. `.onTap()` - Make widget tappable

**Exercise:**

- Remove all extensions and rewrite using traditional Flutter
- Compare the before/after code length and readability

---

### Walkthrough 2: Cart Screen

**File:** `lib/features/cart/presentation/cart_screen.dart`

**Key Extensions Used:**

1. `16.paddingAll` - EdgeInsets creation
2. `context.showSnackBar()` - Show snackbar
3. `context.pop()` - Navigate back
4. `.toColumn()` - Layout creation
5. `.container()` - Wrap in container

**Exercise:**

- Add a new extension method `showConfirmDialog()` to `ContextExtensions`
- Use it to confirm before clearing cart

---

### Walkthrough 3: Cart State Management

**File:** `lib/features/cart/data/providers/cart_provider.dart`

**Key Concepts:**

- Riverpod state management
- Provider patterns
- Derived state with computed providers

**Extensions Used:**

- List extension `.fold()` for calculations

**Exercise:**

- Create a provider that filters products by category
- Use extensions to make the filter logic more expressive

---

## Best Practices

### 1. Name Extensions Clearly

```dart
// ❌ Bad
extension Utils on String { }

// ✅ Good
extension StringExtensions on String { }
```

### 2. Keep Extensions Focused

```dart
// ❌ Bad - Too many unrelated methods
extension Everything on BuildContext {
  void navigateToCart() { }
  String formatDate(DateTime date) { }
  int calculateAge(DateTime birthDate) { }
}

// ✅ Good - Focused purpose
extension NavigationExtensions on BuildContext {
  void navigateToCart() { }
  void navigateToProducts() { }
}

extension DateExtensions on DateTime {
  String get formatted { }
  int get age { }
}
```

### 3. Document Your Extensions

```dart
/// Number extensions for common operations
extension NumExtensions on num {
  /// Converts number to currency format
  /// Example: 1234.56 -> '$1,234.56'
  String get toCurrency { }
}
```

### 4. Avoid Overusing Extensions

```dart
// ❌ Bad - Too many chained extensions
widget
  .paddingAll(8)
  .margin(12)
  .backgroundColor(Colors.red)
  .cornerRadius(4)
  .shadow(4)
  .border(Colors.black, 1)
  .opacity(0.8)

// ✅ Good - Use Container when appropriate
Container(
  padding: EdgeInsets.all(8),
  margin: EdgeInsets.all(12),
  decoration: BoxDecoration(
    color: Colors.red,
    borderRadius: BorderRadius.circular(4),
    boxShadow: [BoxShadow(blurRadius: 4)],
    border: Border.all(color: Colors.black),
  ),
  child: widget.opacity(0.8),
)
```

### 5. Consider Null Safety

```dart
extension ListExtensions<T> on List<T> {
  /// Returns first element or null if empty
  T? get firstOrNull => isEmpty ? null : first;
}
```

---

## Exercises

### Exercise 1: Create Your Own Extension

**Task:** Add a `DateTime` extension for formatting dates

```dart
extension DateTimeExtensions on DateTime {
  /// Returns formatted date string
  /// Example: DateTime.now().formatted -> 'Oct 27, 2025'
  String get formatted {
    // Your code here
  }

  /// Returns true if date is today
  bool get isToday {
    // Your code here
  }
}
```

**Where to add:** Create `lib/core/extensions/datetime_extensions.dart`

---

### Exercise 2: Extend Existing Widgets

**Task:** Add a favorite button to product cards

1. Create a provider to track favorites
2. Add a heart icon that toggles favorite status
3. Use extensions to make the code clean

**Hints:**

- Use `StateNotifierProvider<List<String>>`
- Add the icon using `.toRow()` extension
- Use `context.colorScheme` for colors

---

### Exercise 3: Third-Party Library Extension

**Task:** Extend `Riverpod`'s `WidgetRef`

```dart
extension WidgetRefExtensions on WidgetRef {
  /// Adds a product to cart
  void addToCart(Product product) {
    read(cartProvider.notifier).addProduct(product);
  }

  /// Gets current cart items
  List<CartItem> get cartItems => watch(cartProvider);
}
```

**Usage:**

```dart
// Before
ref.read(cartProvider.notifier).addProduct(product);

// After
ref.addToCart(product);
```

---

### Exercise 4: Complex Layout Extension

**Task:** Create a `responsiveGrid` extension for product lists

```dart
extension WidgetListResponsive on `List<Widget>` {
  Widget toResponsiveGrid(BuildContext context) {
    final columns = context.screenWidth > 600 ? 3 : 2;
    return GridView.count(
      crossAxisCount: columns,
      children: this,
    );
  }
}
```

---

## Discussion Questions

1. **When should you use extensions vs. utility functions?**
2. **How do extensions affect code testability?**
3. **What are the performance implications of extensions?**
4. **How do you handle naming conflicts between extensions?**
5. **Should extensions be part of your public API?**

---

## Additional Resources

### Dart Documentation

- [Extension Methods](https://dart.dev/guides/language/extension-methods)
- [Effective Dart: Design](https://dart.dev/guides/language/effective-dart/design)

### Flutter Resources

- [Flutter Widget Catalog](https://docs.flutter.dev/ui/widgets)
- [Riverpod Documentation](https://riverpod.dev)

### This Project

- `lib/core/extensions/` - All extension implementations
- `lib/features/` - Real-world usage examples

---

## Next Steps

1. **Run the app** - See extensions in action
2. **Add breakpoints** - Debug and understand the flow
3. **Modify extensions** - Experiment with your own ideas
4. **Complete exercises** - Practice makes perfect
5. **Share knowledge** - Teach others what you've learned

---

## Summary

Dart extensions are a powerful tool for:

- ✅ Writing cleaner, more expressive code
- ✅ Reducing boilerplate
- ✅ Creating fluent APIs
- ✅ Extending third-party libraries
- ✅ Improving code maintainability

**Remember:** Extensions are syntactic sugar - they don't add new capabilities, but they make your code more pleasant to write and read.

---

Happy Learning! 🎉

*Questions? Check the code examples or create an issue on GitHub.*
