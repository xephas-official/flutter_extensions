# OOP Principles: Extensions vs Functions

This document explains which Object-Oriented Programming (OOP) principles
extensions follow that traditional functions don't.

## 1. Encapsulation ✅

Extensions encapsulate behavior with the data type itself, keeping related
functionality together:

```dart
// ✅ Extensions: Behavior travels with the type
'hello world'.inCamelCase  // Method feels "part of" String

// ❌ Functions: Behavior is separated from the type
toCamelCase('hello world')  // Function exists independently
```

## 2. Open/Closed Principle ✅✅ (Most Important)

**"Software entities should be open for extension, but closed for
modification."**

Extensions allow you to **extend existing classes without modifying their
source code**:

```dart
// ✅ Extensions: Extend String class without touching Flutter/Dart source
extension StringExtensions on String {
  String get inCamelCase => // ... implementation
}

// Now String has new capabilities WITHOUT modifying the original class!
'text'.inCamelCase

// ❌ Functions: Don't extend the type at all
// You're just creating standalone utility functions
String toCamelCase(String input) => // ...
```

**Real-world analogy**: It's like adding a new feature to your phone through
an app, rather than having to rebuild the phone itself.

## 3. Single Responsibility Principle ✅

Extensions group related methods together by type, maintaining clear
boundaries:

```dart
// ✅ Extensions: String-related operations stay with String
extension StringExtensions on String {
  String get inCamelCase => // ...
  String get inSnakeCase => // ...
  bool get isValidEmail => // ...
}

// ✅ Each extension class has single responsibility
extension NumExtensions on num {
  String get toUSD => // ...
  String get formatCompact => // ...
}

// ❌ Functions: Often dumped into "utility" files with mixed responsibilities
// string_utils.dart might contain:
String toCamelCase(String s) => // ...
bool isValidEmail(String s) => // ...
int parseNumber(String s) => // ...  // Why is this here?
String formatCurrency(num n) => // ...  // This isn't even about strings!
```

## 4. Polymorphism (Method Dispatch) ✅

Extensions participate in Dart's type system and method resolution:

```dart
// ✅ Extensions: Type-aware, works with polymorphism
Object obj = 'hello';
if (obj is String) {
  obj.inCamelCase;  // Extension method available!
}

// ❌ Functions: No polymorphic behavior
Object obj = 'hello';
if (obj is String) {
  toCamelCase(obj);  // Function doesn't care about type hierarchy
}
```

## 5. Principle of Least Surprise ✅

Extensions follow the natural object-oriented calling convention:

```dart
// ✅ Extensions: Read naturally, left-to-right
'hello world'
  .inCamelCase
  .capitalize
  .withQuotes

// ❌ Functions: Read inside-out (violates natural reading flow)
addQuotes(capitalize(toCamelCase('hello world')))
// Must parse from innermost to outermost!
```

## 6. Tell, Don't Ask ✅

Extensions follow the OOP principle of telling objects what to do:

```dart
// ✅ Extensions: "String, convert yourself to camel case"
'hello world'.inCamelCase

// ❌ Functions: "I'll take your string and do something to it"
toCamelCase('hello world')
```

## Key Difference Summary

| Principle | Extensions | Functions |
|-----------|-----------|-----------|
| Encapsulation | ✅ Behavior with data | ❌ Separated |
| Open/Closed | ✅ Extend without modifying | ❌ Doesn't extend |
| Single Responsibility | ✅ Grouped by type | ⚠️ Often mixed |
| Polymorphism | ✅ Type-aware | ❌ Type-agnostic |
| Least Surprise | ✅ Natural OOP syntax | ❌ Procedural |
| Tell, Don't Ask | ✅ Object-oriented | ❌ Procedural |

## In This Codebase

Look at the implementations in this project:

```dart
// filepath: lib/global/extensions/string_extensions.dart
extension StringExtensions on String {
  // ✅ Extends String type following Open/Closed Principle
  String get inCamelCase => _splitIntoWords()
    .first.toLowerCase() + 
    _splitIntoWords().skip(1).map((w) => w.capitalize).join();
}

// filepath: lib/global/extensions/string_functions.dart
String toCamelCase(String input) {
  // ❌ Standalone function, doesn't follow OOP principles
  final words = _splitIntoWords(input);
  return words.first.toLowerCase() + 
    words.skip(1).map(_capitalize).join();
}
```

## Detailed Explanation: Open/Closed Principle

**The primary OOP principle is Open/Closed** - extensions let you add new
behavior to existing types without modifying them, which is a cornerstone of
maintainable object-oriented design.

### Why This Matters

1. **No Source Code Modification**: You can't modify Flutter's `String` class
   source code, but you can extend it
2. **Backward Compatibility**: Adding extensions doesn't break existing code
3. **Separation of Concerns**: Core types remain simple, extensions add
   domain-specific functionality
4. **Team Collaboration**: Multiple developers can add extensions without
   conflicts

### Real-World Example

```dart
// Imagine you're using a third-party package with a Color class
// You can't modify their source code, but you need HEX conversion

// ✅ Extensions: Add functionality without touching their code
extension ColorExtensions on Color {
  String get toHex => '#${value.toRadixString(16).padLeft(8, '0')}';
}

// Now use it naturally
final hexColor = Colors.blue.toHex;  // '#FF2196F3'

// ❌ Functions: Would require wrapping or utility functions
String colorToHex(Color color) {
  return '#${color.value.toRadixString(16).padLeft(8, '0')}';
}

// Less intuitive usage
final hexColor = colorToHex(Colors.blue);
```

## Conclusion

Extensions are fundamentally more aligned with OOP principles than functions
because they:

- **Extend types** rather than create separate utilities
- **Group related behavior** with the types they operate on
- **Follow natural OOP syntax** and conventions
- **Participate in the type system** for better polymorphism
- **Maintain encapsulation** by keeping behavior close to data

This is why modern Dart/Flutter codebases prefer extensions over utility
function files for type-specific operations.
