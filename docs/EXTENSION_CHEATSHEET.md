# Extension Methods Quick Reference

> **Comprehensive cheat sheet for all extension methods in this project**

This guide shows **before/after** examples demonstrating how extensions simplify Flutter code.

---

## � Table of Contents

1. [Context Extensions](#context-extensions)
2. [Widget Extensions](#widget-extensions)
3. [Number Extensions](#number-extensions)
4. [List Extensions](#list-extensions)
5. [String Extensions](#string-extensions)
6. [Color Extensions](#color-extensions)

---

## Context Extensions

Extensions that make accessing theme, MediaQuery, and navigation easier.

### Theme Access

```dart
// ❌ Before
final primaryColor = Theme.of(context).colorScheme.primary;
final textStyle = Theme.of(context).textTheme.titleMedium;

// ✅ After
final primaryColor = context.colorScheme.primary;
final textStyle = context.textTheme.titleMedium;
```

### Screen Dimensions

```dart
// ❌ Before
final width = MediaQuery.of(context).size.width;
final height = MediaQuery.of(context).size.height;
final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

// ✅ After
final width = context.screenWidth;
final height = context.screenHeight;
final isPortrait = context.isPortrait;
```

### Navigation

```dart
// ❌ Before
Navigator.of(context).push(
  MaterialPageRoute(builder: (_) => DetailScreen()),
);
Navigator.of(context).pop();
Navigator.of(context).pop('result');

// ✅ After
context.push(DetailScreen());
context.pop();
context.pop<String>('result');
```

### User Feedback

```dart
// ❌ Before
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Text('Item added to cart'),
    duration: Duration(seconds: 2),
  ),
);

// ✅ After
context.showSnackBar('Item added to cart');
context.showSnackBar('Custom duration', duration: Duration(seconds: 5));
```

**Available Methods:**

- `context.theme` - Full ThemeData
- `context.colorScheme` - ColorScheme shortcut
- `context.textTheme` - TextTheme shortcut
- `context.screenSize` - Full Size object
- `context.screenWidth` - Width only
- `context.screenHeight` - Height only
- `context.isLandscape` - Orientation check
- `context.isPortrait` - Orientation check
- `context.push()` - Navigate forward
- `context.pop()` - Navigate back
- `context.showSnackBar()` - Show snackbar
- `context.showBanner()` - Show material banner

---

## Widget Extensions

Fluent API for widget composition and styling.

### Padding

```dart
// ❌ Before
Padding(
  padding: EdgeInsets.all(16),
  child: widget,
)

Padding(
  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  child: widget,
)

Padding(
  padding: EdgeInsets.only(left: 8, top: 4),
  child: widget,
)

// ✅ After
widget.paddingAll(16)

widget.paddingSymmetric(horizontal: 20, vertical: 10)

widget.paddingOnly(left: 8, top: 4)
```

### Layout Wrappers

```dart
// ❌ Before
Center(child: widget)
Expanded(child: widget)
Flexible(flex: 2, child: widget)

// ✅ After
widget.center
widget.expanded
widget.flexible(flex: 2)
```

### Container

```dart
// ❌ Before
Container(
  width: 200,
  height: 100,
  color: Colors.blue,
  child: widget,
)

// ✅ After
widget.container(width: 200, height: 100, color: Colors.blue)
```

### Card

```dart
// ❌ Before
Card(
  elevation: 4,
  margin: EdgeInsets.all(8),
  child: widget,
)

// ✅ After
widget.card(elevation: 4, margin: 8.paddingAll)
```

### Interactions

```dart
// ❌ Before
InkWell(
  onTap: () => print('Tapped'),
  borderRadius: BorderRadius.circular(12),
  child: widget,
)

GestureDetector(
  onTap: () => handleTap(),
  child: widget,
)

// ✅ After
widget.onTap(() => print('Tapped'), borderRadius: 12.borderRadius)

widget.onTap(() => handleTap())
```

### Hero Animation

```dart
// ❌ Before
Hero(
  tag: 'product-123',
  child: widget,
)

// ✅ After
widget.hero('product-123')
```

### Conditional Visibility

```dart
// ❌ Before
isLoggedIn ? widget : SizedBox.shrink()

hasData ? widget : CircularProgressIndicator()

// ✅ After
widget.visible(isLoggedIn)

widget.showIf(hasData, fallback: CircularProgressIndicator())
```

**Available Methods:**

- `.paddingAll(double)` - Uniform padding
- `.paddingSymmetric()` - Horizontal/vertical padding
- `.paddingOnly()` - Specific sides
- `.center` - Center widget
- `.expanded` - Expanded widget
- `.flexible()` - Flexible with flex factor
- `.container()` - Container wrapper
- `.card()` - Card wrapper
- `.onTap()` - Tap handler
- `.hero()` - Hero animation
- `.visible()` - Conditional rendering
- `.showIf()` - Conditional with fallback

---

## Number Extensions

Domain-specific helpers for numbers (int, double).

### Spacing (SizedBox)

```dart
// ❌ Before
SizedBox(height: 16)
SizedBox(width: 20)

// ✅ After
16.heightBox
20.widthBox
```

### Padding (EdgeInsets)

```dart
// ❌ Before
EdgeInsets.all(12)
EdgeInsets.symmetric(horizontal: 16)
EdgeInsets.symmetric(vertical: 8)

// ✅ After
12.paddingAll
16.paddingHorizontal
8.paddingVertical
```

### Border Radius

```dart
// ❌ Before
BorderRadius.circular(8)
BorderRadius.circular(12)

// ✅ After
8.borderRadius
12.borderRadius
```

### Currency Formatting

```dart
// ❌ Before
Text('\$${price.toStringAsFixed(2)}')  // No thousand separators
Text('\$${price.toStringAsFixed(2).replaceAllMapped(...)}')  // Complex!

// ✅ After
Text(price.toCurrency)  // '$1,234.56'
Text(99.99.toCurrency)  // '$99.99'
```

**Available Methods:**

- `.heightBox` - SizedBox with height
- `.widthBox` - SizedBox with width
- `.paddingAll` - EdgeInsets.all
- `.paddingHorizontal` - Horizontal EdgeInsets
- `.paddingVertical` - Vertical EdgeInsets
- `.borderRadius` - Circular BorderRadius
- `.toCurrency` - Format as currency

---

## List Extensions

Auto-spaced layout builders for widget lists.

### Column with Spacing

```dart
// ❌ Before
Column(
  children: [
    Text('Title'),
    SizedBox(height: 8),
    Text('Subtitle'),
    SizedBox(height: 8),
    Text('Footer'),
  ],
)

// ✅ After
[
  Text('Title'),
  Text('Subtitle'),
  Text('Footer'),
].toColumn(spacing: 8)
```

### Row with Spacing

```dart
// ❌ Before
Row(
  children: [
    Icon(Icons.star),
    SizedBox(width: 4),
    Text('4.5'),
    SizedBox(width: 4),
    Text('(120)'),
  ],
)

// ✅ After
[
  Icon(Icons.star),
  Text('4.5'),
  Text('(120)'),
].toRow(spacing: 4)
```

### ListView with Separators

```dart
// ❌ Before
ListView.separated(
  itemCount: items.length,
  itemBuilder: (context, index) => items[index],
  separatorBuilder: (_, __) => Divider(),
)

// ✅ After
items.toListView(separator: Divider())
```

**Available Methods:**

- `.toColumn()` - Column with auto-spacing
- `.toRow()` - Row with auto-spacing
- `.toListView()` - ListView with separators
- Spacing is automatic via `.divide()` method

---

## String Extensions

Text manipulation, validation, and formatting.

### Case Conversion

```dart
// ❌ Before
final snakeCase = 'userId'.replaceAllMapped(...);  // Complex regex
final camelCase = 'user_id'.replaceAllMapped(...); // Complex regex

// ✅ After
'userId'.inSnakeCase      // 'user_id'
'user_id'.inCamelCase     // 'userId'
'hello'.capitalize        // 'Hello'
'Hello'.decapitalize      // 'hello'
```

### Validation

```dart
// ❌ Before
final emailValid = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
    .hasMatch(email);

// ✅ After
email.isValidEmail  // true or false
```

### Text Checks

```dart
// ❌ Before
text.trim().isEmpty
!text.trim().isEmpty

// ✅ After
text.isBlank        // true if empty or whitespace
text.isNotBlank     // true if has content
```

### String Manipulation

```dart
// ❌ Before
text.split('').reversed.join()
text.startsWith(prefix) ? text.substring(prefix.length) : text
text.endsWith(suffix) ? text.substring(0, text.length - suffix.length) : text

// ✅ After
text.reversed                   // 'olleh' from 'hello'
text.removePrefix('Hello')      // 'World' from 'HelloWorld'
text.removeSuffix('.dart')      // 'file' from 'file.dart'
```

### Null-Safe Parsing

```dart
// ❌ Before
int? value = int.tryParse(text);     // Returns null on failure
double? value = double.tryParse(text);

// ✅ After
text.toIntOrNull()     // Clearer intent
text.toDoubleOrNull()  // Clearer intent

// Examples
'42'.toIntOrNull()         // 42
'not a number'.toIntOrNull()  // null
'3.14'.toDoubleOrNull()    // 3.14
```

### Number Formatting

```dart
// ❌ Before
final formatted = '1234567'.replaceAllMapped(
  RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
  (m) => '${m[1]},',
);

// ✅ After
'1234567'.withThousandSeparators  // '1,234,567'
```

### Nullable String Helpers

```dart
// ❌ Before
final text = nullableString ?? '';
if (nullableString == null || nullableString.isEmpty) { }
if (nullableString == null || nullableString.trim().isEmpty) { }

// ✅ After
nullableString.orEmpty           // Returns '' if null
nullableString.isNullOrEmpty     // true if null or empty
nullableString.isNullOrBlank     // true if null, empty, or whitespace
```

**Available Methods:**

- `.inSnakeCase` - Convert camelCase to snake_case
- `.inCamelCase` - Convert snake_case to camelCase
- `.capitalize` - Capitalize first letter
- `.decapitalize` - Lowercase first letter
- `.isValidEmail` - Email validation
- `.isBlank` - Check if empty/whitespace
- `.isNotBlank` - Check if has content
- `.reversed` - Reverse string
- `.removePrefix()` - Remove leading text
- `.removeSuffix()` - Remove trailing text
- `.toIntOrNull()` - Safe int parsing
- `.toDoubleOrNull()` - Safe double parsing
- `.withThousandSeparators` - Add commas to numbers
- `.orEmpty` - Null-safe empty string (nullable)
- `.isNullOrEmpty` - Null/empty check (nullable)
- `.isNullOrBlank` - Null/blank check (nullable)

---

## Color Extensions (Optional)

Color manipulation utilities (implement as needed for your project).

```dart
// Examples of possible color extensions:
context.colorScheme.primary.withOpacity(0.5)
Colors.blue.lighten(0.2)
Colors.red.darken(0.3)
```

---

## 💡 Usage Tips

### Chaining Extensions

Extensions can be chained for fluent APIs:

```dart
// Complex UI in one fluent chain
widget
  .paddingAll(16)
  .card(elevation: 4)
  .onTap(() => handleTap())
  .hero('unique-id')
```

### Combining with Constants

Use with constants for consistency:

```dart
// From lib/global/constants/
import '../../app_exporter.dart';

widget.paddingAll(spacing16)
  .container(
    color: appGreen,
    borderRadius: borderRadius12,
  )
```

### Performance

All extensions compile to static function calls - **zero runtime overhead**!

```dart
// This extension code:
widget.paddingAll(16)

// Compiles to something like:
WidgetExtensions.paddingAll(widget, 16)

// No wrapper objects, no extra overhead!
```

---

## 🎯 Quick Examples by Use Case

### Building a Product Card

```dart
// Before: Lots of nesting and boilerplate
Widget buildCard(Product product) {
  return Card(
    child: Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(product.name),
          SizedBox(height: 4),
          Text('\$${product.price.toStringAsFixed(2)}'),
          SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {},
            child: Text('Add'),
          ),
        ],
      ),
    ),
  );
}

// After: Clean and readable
Widget buildCard(Product product) {
  return [
    Text(product.name),
    Text(product.price.toCurrency),
    ElevatedButton(
      onPressed: () {},
      child: Text('Add'),
    ),
  ].toColumn(spacing: 4).paddingAll(12).card();
}
```

### Accessing Theme Data

```dart
// Before: Verbose and repetitive
final bgColor = Theme.of(context).colorScheme.surface;
final textColor = Theme.of(context).colorScheme.onSurface;
final width = MediaQuery.of(context).size.width;

// After: Concise and clear
final bgColor = context.colorScheme.surface;
final textColor = context.colorScheme.onSurface;
final width = context.screenWidth;
```

### String Formatting in Forms

```dart
// Before: Manual validation and formatting
final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@...');
if (!emailRegex.hasMatch(email)) {
  return 'Invalid email';
}

// After: Built-in validation
if (!email.isValidEmail) {
  return 'Invalid email';
}
```

---

## 📚 Additional Resources

- **Source Code:** `lib/global/extensions/` - Implementation details
- **Training Guide:** `TRAINING_GUIDE.md` - Deep dive and exercises
- **Project Summary:** `PROJECT_SUMMARY.md` - Architecture overview

---

Pro Tip: Study the extension implementations in `lib/global/extensions/` to understand the patterns and create your own

---

### String Extensions Examples

```dart
// Case conversion
'userId'.inSnakeCase         // 'user_id'
'created_on'.inCamelCase     // 'createdOn'
'hello world'.capitalize     // 'Hello world'

// Validation
'test@email.com'.isValidEmail  // true
'invalid'.isValidEmail         // false
```

### Color Extensions

```dart
// Shades
Colors.blue.lighter
Colors.red.darker

// Opacity
myColor.withOpacityValue(0.5)

// Hex conversion
Colors.blue.toHex            // '#FF2196F3'
```

### List Extensions 2

```dart
// Safe access
myList.firstOrNull
myList.lastOrNull

// Check empty
myList.isNullOrEmpty
myList.isNotNullOrEmpty
```

---

## 💡 Common Patterns

### Building a Card

**Traditional:**

```dart
Card(
  child: Padding(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Title'),
        SizedBox(height: 8),
        Text('Description'),
      ],
    ),
  ),
)
```

**With Extensions:**

```dart
[
  Text('Title'),
  Text('Description'),
].toColumn(
  crossAxisAlignment: CrossAxisAlignment.start,
  spacing: 8,
).paddingAll(16).card()
```

### Product Row

**Traditional:**

```dart
Container(
  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  child: Row(
    children: [
      Expanded(
        child: Text(
          product.name,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      SizedBox(width: 8),
      Text(
        '\$${product.price.toStringAsFixed(2)}',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    ],
  ),
)
```

**With Extensions:**

```dart
[
  Text(
    product.name,
    style: context.textTheme.titleMedium,
  ).expanded,
  Text(
    product.price.toCurrency,
    style: context.textTheme.titleLarge?.copyWith(
      color: context.colorScheme.primary,
    ),
  ),
].toRow(spacing: 8).paddingSymmetric(horizontal: 16, vertical: 12)
```

### Button with Loading State

**Traditional:**

```dart
Container(
  width: double.infinity,
  height: 50,
  child: FilledButton(
    onPressed: isLoading ? null : () => handleSubmit(),
    child: isLoading
        ? CircularProgressIndicator()
        : Text('Submit'),
  ),
)
```

**With Extensions:**

```dart
FilledButton(
  onPressed: isLoading ? null : handleSubmit,
  child: isLoading
      ? CircularProgressIndicator()
      : Text('Submit'),
).container(
  width: double.infinity,
  height: 50,
)
```

### Form Layout

**Traditional:**

```dart
Padding(
  padding: EdgeInsets.all(16),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      TextField(
        decoration: InputDecoration(labelText: 'Name'),
      ),
      SizedBox(height: 16),
      TextField(
        decoration: InputDecoration(labelText: 'Email'),
      ),
      SizedBox(height: 16),
      TextField(
        decoration: InputDecoration(labelText: 'Password'),
      ),
      SizedBox(height: 24),
      FilledButton(
        onPressed: () {},
        child: Text('Sign Up'),
      ),
    ],
  ),
)
```

**With Extensions:**

```dart
[
  TextField(decoration: InputDecoration(labelText: 'Name')),
  TextField(decoration: InputDecoration(labelText: 'Email')),
  TextField(decoration: InputDecoration(labelText: 'Password')),
  16.heightBox,
  FilledButton(onPressed: () {}, child: Text('Sign Up')),
].toColumn(
  crossAxisAlignment: CrossAxisAlignment.stretch,
  spacing: 16,
).paddingAll(16)
```

---

## 🔥 Advanced Combinations

### Responsive Card Grid

```dart
GridView.builder(
  padding: 16.paddingAll,
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: context.screenWidth > 600 ? 3 : 2,
    childAspectRatio: 0.7,
    crossAxisSpacing: 16,
    mainAxisSpacing: 16,
  ),
  itemCount: products.length,
  itemBuilder: (context, index) {
    final product = products[index];
    return [
      Text(product.imageUrl, style: TextStyle(fontSize: 64))
        .container(height: 120)
        .hero('product_${product.id}'),
      [
        Text(product.name, style: context.textTheme.titleMedium),
        Text(product.price.toCurrency, style: context.textTheme.titleLarge),
      ].toColumn(spacing: 8).paddingAll(12),
    ].toColumn().card();
  },
)
```

### Bottom Sheet with Actions

```dart
showModalBottomSheet(
  context: context,
  builder: (context) => [
    Text(
      'Options',
      style: context.textTheme.titleLarge,
    ),
    16.heightBox,
    [
      Icon(Icons.edit),
      Text('Edit'),
    ].toRow(spacing: 8).onTap(() {
      context.pop();
      // Edit action
    }),
    [
      Icon(Icons.share),
      Text('Share'),
    ].toRow(spacing: 8).onTap(() {
      context.pop();
      // Share action
    }),
    [
      Icon(Icons.delete, color: context.colorScheme.error),
      Text('Delete', style: TextStyle(color: context.colorScheme.error)),
    ].toRow(spacing: 8).onTap(() {
      context.pop();
      // Delete action
    }),
  ].toColumn(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: 16,
  ).paddingAll(24),
);
```

---

## 📝 Tips & Tricks

### Conditional Padding

```dart
// Only add padding if condition is true
widget.showIf(
  needsPadding,
  fallback: widget,
).paddingAll(16)

// Or use ternary
(needsPadding ? widget.paddingAll(16) : widget)
```

### Chaining for Complex Layouts

```dart
content
  .paddingAll(16)
  .card(elevation: 2)
  .container(margin: 8.paddingVertical)
  .onTap(handleTap)
  .hero('card_$id')
```

### Mixing with Traditional Widgets

```dart
// You don't have to use extensions everywhere
ListView(
  children: [
    // Traditional
    Container(
      padding: EdgeInsets.all(16),
      child: Text('Header'),
    ),
    // Extensions
    Text('Body').paddingAll(16),
    // Mixed
    [
      Text('Footer'),
      Icon(Icons.arrow_forward),
    ].toRow().paddingAll(16),
  ],
)
```

---

## ⚡ Performance Notes

Extensions have **ZERO runtime overhead**. They are resolved at compile-time, so:

```dart
widget.paddingAll(16)
// Compiles to exactly the same as:
Padding(padding: EdgeInsets.all(16), child: widget)
```

However, be mindful of creating intermediate objects when chaining extensively.

---

## 🎯 When NOT to Use Extensions

❌ **Complex Business Logic**

```dart
// Bad - too much logic
extension on Product {
  Future<void> saveToDatabase() { ... }
  Future<void> sendToServer() { ... }
}
```

❌ **Breaking Encapsulation**

```dart
// Bad - accessing internals
extension on MyClass {
  void modifyPrivateState() { ... }
}
```

❌ **Over-chaining**

```dart
// Bad - too complex
widget
  .padding1()
  .padding2()
  .margin1()
  .color1()
  .color2()
  .border1()
  .border2()
  .shadow1()
  .shadow2()
```

✅ **Use Container instead for complex styling**

---

**Save this file as a quick reference while coding!**
