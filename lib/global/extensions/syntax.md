# Syntax for Extensions

Extensions in Dart allow you to add new functionality to existing libraries, types, or classes without modifying their source code. The syntax for defining an extension is as follows:

```dart
extension <extension name>? on <type> { // <extension-name> is optional
  (<member definition>)* // Can provide one or more <member definition>.
}
```

- `<extension name>`: This is an optional name for the extension. Naming your extension can help with readability and debugging.
- `<type>`: This specifies the type (class, interface, etc.) that you are extending.
- `<member definition>`: This can include methods, getters, setters, or operators that you want to add to the specified type.

## Example

```dart
extension StringExtensions on String {
  bool get isPalindrome {
    String cleaned = this.replaceAll(RegExp(r'\W'), '').toLowerCase();
    return cleaned == cleaned.split('').reversed.join('');
  }

  String reverse() {
    return this.split('').reversed.join('');
  }
}
```

In this example, we define an extension called `StringExtensions` on the `String` type. It adds a getter `isPalindrome` to check if the string is a palindrome (a word, phrase, or sequence that reads the same backwards as forwards, e.g. madam or nurses run) and a method `reverse` to reverse the string.
