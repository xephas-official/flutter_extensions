# Quick Extension Examples - Cheat Sheet

## 🚀 Quick Reference for All Extensions

### Context Extensions

```dart
// Theme access
context.theme
context.colorScheme
context.textTheme

// Specific colors
context.colorScheme.primary
context.colorScheme.secondary
context.colorScheme.error

// Screen dimensions
context.screenSize
context.screenWidth
context.screenHeight
context.isLandscape
context.isPortrait

// Navigation
context.push(MyScreen())
context.pop()
context.pop<String>('result')

// Feedback
context.showSnackBar('Message')
context.showSnackBar('Message', duration: Duration(seconds: 5))
context.showBanner('Important message')
```

### Widget Extensions

```dart
// Padding
widget.padding(EdgeInsets.all(16))
widget.paddingAll(16)
widget.paddingSymmetric(horizontal: 16, vertical: 8)
widget.paddingOnly(left: 16, top: 8)

// Layout
widget.center
widget.expanded
widget.flexible(flex: 2)

// Container
widget.container(
  width: 200,
  height: 100,
  color: Colors.blue,
  padding: 8.paddingAll,
)

// Card
widget.card()
widget.card(elevation: 4, margin: 8.paddingAll)

// Interactions
widget.onTap(() => print('Tapped'))
widget.onTap(() { }, borderRadius: 12.borderRadius)

// Hero animation
widget.hero('unique-tag')

// Visibility
widget.visible(isLoggedIn)
widget.showIf(hasData, fallback: CircularProgressIndicator())
```

### Number Extensions

```dart
// Spacing
16.heightBox              // SizedBox(height: 16)
20.widthBox               // SizedBox(width: 20)

// Padding
12.paddingAll             // EdgeInsets.all(12)
16.paddingHorizontal      // EdgeInsets.symmetric(horizontal: 16)
8.paddingVertical         // EdgeInsets.symmetric(vertical: 8)

// Border radius
8.borderRadius            // BorderRadius.circular(8)
12.borderRadius           // BorderRadius.circular(12)

// Currency formatting
99.99.toCurrency          // '$99.99'
1234.56.toCurrency        // '$1,234.56'
```

### `List<Widget>` Extensions

```dart
// Column with spacing
[
  Text('Title'),
  Text('Subtitle'),
  Text('Body'),
].toColumn(spacing: 8)

// Column with alignment
[
  Text('Left'),
  Text('Aligned'),
].toColumn(
  crossAxisAlignment: CrossAxisAlignment.start,
  mainAxisAlignment: MainAxisAlignment.center,
  spacing: 4,
)

// Row with spacing
[
  Icon(Icons.home),
  Text('Home'),
  Icon(Icons.arrow_forward),
].toRow(spacing: 8)

// Row with alignment
[
  Text('Left'),
  Spacer(),
  Text('Right'),
].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween)

// ListView
[
  ListTile(title: Text('Item 1')),
  ListTile(title: Text('Item 2')),
].toListView(padding: 16.paddingAll)

// Wrap
[
  Chip(label: Text('Tag 1')),
  Chip(label: Text('Tag 2')),
  Chip(label: Text('Tag 3')),
].toWrap(spacing: 8, runSpacing: 8)

// Divide items
[
  Text('Item 1'),
  Text('Item 2'),
  Text('Item 3'),
].divide(Divider())
```

### String Extensions

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
