import 'package:intl/intl.dart';
import '../utils/text_label.dart';

/// Number extensions for common operations on integers and doubles.
///
/// Provides formatting utilities, currency conversions, validation helpers,
/// and widget shortcuts for spacing.
extension NumberExtensions on num {
  // ============ Currency Formatters ============

  /// Converts number to USD currency format.
  ///
  /// Returns formatted string like '$1,234.56' with dollar sign and commas.
  String get toUSD {
    final formatter = NumberFormat.simpleCurrency(
      name: r'$',
      decimalDigits: 2,
    );
    return formatter.format(this);
  }

  /// Converts number to Kenyan Shilling currency format.
  ///
  /// Returns formatted string like 'KES 1,234.56' with currency code.
  String get toKES {
    final formatter = NumberFormat.simpleCurrency(
      name: 'KES ',
      decimalDigits: 2,
    );
    return formatter.format(this);
  }

  /// Converts number to Ugandan Shilling currency format.
  ///
  /// Returns formatted string like 'UGX 1,234' without decimal places.
  String get toUGX {
    final formatter = NumberFormat.simpleCurrency(
      name: 'UGX ',
      decimalDigits: 0,
    );
    return formatter.format(this);
  }

  /// Converts number to Euro currency format.
  ///
  /// Returns formatted string like '€1,234.56' with euro symbol.
  String get toEUR {
    final formatter = NumberFormat.simpleCurrency(
      name: '€',
      decimalDigits: 2,
    );
    return formatter.format(this);
  }

  /// Converts number to British Pound currency format.
  ///
  /// Returns formatted string like '£1,234.56' with pound symbol.
  String get toGBP {
    final formatter = NumberFormat.simpleCurrency(
      name: '£',
      decimalDigits: 2,
    );
    return formatter.format(this);
  }

  // ============ Number Formatters ============

  /// Formats number with thousand separators.
  ///
  /// Returns formatted string like '1,234,567' with commas.
  String get formatWithCommas {
    final formatter = NumberFormat.decimalPattern();
    return formatter.format(this);
  }

  /// Formats large numbers in compact form.
  ///
  /// Returns '1.2K', '3.4M', '5.6B' etc for large numbers.
  String get formatCompact {
    final formatter = NumberFormat.compact();
    return formatter.format(this);
  }

  /// Formats number with specified decimal places.
  ///
  /// Returns string with exact decimal precision.
  String toDecimal([int decimalPlaces = 2]) {
    return toStringAsFixed(decimalPlaces);
  }

  /// Formats number as percentage.
  ///
  /// Returns formatted string like '45.5%' with percent sign.
  String get toPercent {
    final formatter = NumberFormat.percentPattern();
    return formatter.format(this / 100);
  }

  /// Smart number formatter.
  ///
  /// Returns compact format (1K, 1M) for large numbers above 9999,
  /// otherwise returns formatted number with commas.
  String get format {
    if (this > 9999) {
      return formatCompact;
    }
    return formatWithCommas;
  }

  // ============ Validation Helpers ============

  /// Checks if number is zero.
  bool get isZero => this == 0;

  /// Checks if number is not zero.
  bool get isNotZero => this != 0;

  /// Checks if number is positive.
  bool get isPositive => this > 0;

  /// Checks if number is negative.
  bool get isNegative => this < 0;

  /// Checks if number is within a valid price range.
  ///
  /// Returns true if number is greater than 0 and less than 1 million.
  bool get isValidPrice => this > 0 && this < 1000000;

  /// Checks if number is a valid quantity.
  ///
  /// Returns true if number is greater than 0 and is a whole number.
  bool get isValidQuantity => this > 0 && this % 1 == 0;

  // ============ Math Utilities ============

  /// Calculates percentage of this number.
  ///
  /// Returns the calculated percentage value.
  double percentOf(num total) {
    if (total == 0) return 0;
    return (this / total) * 100;
  }

  /// Adds percentage to this number.
  ///
  /// Returns number increased by specified percentage.
  double addPercent(num percent) {
    return this + (this * percent / 100);
  }

  /// Subtracts percentage from this number.
  ///
  /// Returns number decreased by specified percentage.
  double subtractPercent(num percent) {
    return this - (this * percent / 100);
  }

  /// Clamps number between min and max values.
  ///
  /// Returns value constrained within specified range.
  num clampValue(num min, num max) {
    return clamp(min, max);
  }

  // ============ Discount & Pricing Helpers ============

  /// Applies 20% discount to this number.
  ///
  /// Returns number reduced by 20%.
  /// Example: 100.discount20 returns 80.0
  double get discount20 => subtractPercent(20);

  /// Applies 30% discount to this number.
  ///
  /// Returns number reduced by 30%.
  /// Example: 100.discount30 returns 70.0
  double get discount30 => subtractPercent(30);

  /// Applies 50% discount to this number.
  ///
  /// Returns number reduced by 50%.
  /// Example: 100.discount50 returns 50.0
  double get discount50 => subtractPercent(50);

  /// Adds 20% markup to this number.
  ///
  /// Returns number increased by 20%.
  /// Example: 100.markup20 returns 120.0
  double get markup20 => addPercent(20);

  /// Adds 30% markup to this number.
  ///
  /// Returns number increased by 30%.
  /// Example: 100.markup30 returns 130.0
  double get markup30 => addPercent(30);

  /// Adds 50% markup to this number.
  ///
  /// Returns number increased by 50%.
  /// Example: 100.markup50 returns 150.0
  double get markup50 => addPercent(50);

  /// Calculates the discount amount for 20% off.
  ///
  /// Returns the amount saved with 20% discount.
  /// Example: 100.discountAmount20 returns 20.0
  double get discountAmount20 => this * 0.20;

  /// Calculates the discount amount for 30% off.
  ///
  /// Returns the amount saved with 30% discount.
  /// Example: 100.discountAmount30 returns 30.0
  double get discountAmount30 => this * 0.30;

  /// Calculates the discount amount for 50% off.
  ///
  /// Returns the amount saved with 50% discount.
  /// Example: 100.discountAmount50 returns 50.0
  double get discountAmount50 => this * 0.50;

  // ============ TextLabel Conversion ============

  /// Converts a number to a TextLabel with a specific format.
  ///
  /// Returns TextLabel with the format type as label and formatted value.
  TextLabel asTextLabel(String formatType) {
    String convertedValue;
    switch (formatType) {
      case 'USD':
        convertedValue = toUSD;
      case 'KES':
        convertedValue = toKES;
      case 'UGX':
        convertedValue = toUGX;
      case 'EUR':
        convertedValue = toEUR;
      case 'GBP':
        convertedValue = toGBP;
      case 'With Commas':
        convertedValue = formatWithCommas;
      case 'Compact':
        convertedValue = formatCompact;
      case 'Percentage':
        convertedValue = toPercent;
      case '0 Decimals':
        convertedValue = toDecimal(0);
      case '1 Decimal':
        convertedValue = toDecimal(1);
      case '2 Decimals':
        convertedValue = toDecimal();
      case '3 Decimals':
        convertedValue = toDecimal(3);
      case 'Smart Format':
        convertedValue = format;
      case '20% Off':
        convertedValue = discount20.toUSD;
      case '30% Off':
        convertedValue = discount30.toUSD;
      case '50% Off':
        convertedValue = discount50.toUSD;
      case '20% Markup':
        convertedValue = markup20.toUSD;
      case '30% Markup':
        convertedValue = markup30.toUSD;
      case '50% Markup':
        convertedValue = markup50.toUSD;
      case 'Save 20%':
        convertedValue = 'Save ${discountAmount20.toUSD}';
      case 'Save 30%':
        convertedValue = 'Save ${discountAmount30.toUSD}';
      case 'Save 50%':
        convertedValue = 'Save ${discountAmount50.toUSD}';
      case 'Raw':
        convertedValue = toString();
      default:
        convertedValue = toString();
    }
    return TextLabel(
      label: formatType,
      value: convertedValue,
    );
  }

  /// Returns a list of TextLabels for all number format types.
  ///
  /// Useful for demonstrating all formatting options in UI.
  /// Each TextLabel contains the format name and the formatted value.
  ///
  /// Example:
  /// ```dart
  /// final price = 1234.56;
  /// final labels = price.toTextLabels;
  /// // Returns list with USD, KES, UGX, EUR, GBP, With Commas, etc.
  /// ```
  List<TextLabel> get toTextLabels {
    final formats = [
      'USD',
      'KES',
      'UGX',
      'EUR',
      'GBP',
      'With Commas',
      'Compact',
      'Percentage',
      '0 Decimals',
      '1 Decimal',
      '2 Decimals',
      '3 Decimals',
      'Smart Format',
      '20% Off',
      '30% Off',
      '50% Off',
      'Save 20%',
      'Save 30%',
      'Save 50%',
      'Raw',
    ];

    return formats.map(asTextLabel).toList();
  }

  /// Returns a list of TextLabels for currency formats only.
  ///
  /// Useful for displaying price in multiple currencies.
  ///
  /// Example:
  /// ```dart
  /// final price = 99.99;
  /// final currencies = price.toCurrencyLabels;
  /// // Returns USD, KES, UGX, EUR, GBP formats
  /// ```
  List<TextLabel> get toCurrencyLabels {
    final currencies = ['USD', 'KES', 'UGX', 'EUR', 'GBP'];
    return currencies.map(asTextLabel).toList();
  }

  /// Returns a list of TextLabels for number formats only.
  ///
  /// Useful for displaying numbers in different formats.
  ///
  /// Example:
  /// ```dart
  /// final amount = 123456.789;
  /// final formats = amount.toFormatLabels;
  /// // Returns With Commas, Compact, Smart Format, etc.
  /// ```
  List<TextLabel> get toFormatLabels {
    final formats = [
      'With Commas',
      'Compact',
      'Smart Format',
      '0 Decimals',
      '1 Decimal',
      '2 Decimals',
      '3 Decimals',
      'Percentage',
      'Raw',
    ];
    return formats.map(asTextLabel).toList();
  }

  /// Returns a list of TextLabels for discount pricing.
  ///
  /// Useful for displaying discounted prices in shopping cart.
  ///
  /// Example:
  /// ```dart
  /// final price = 100.0;
  /// final discounts = price.toDiscountLabels;
  /// // Returns 20%, 30%, 50% off prices and savings amounts
  /// ```
  List<TextLabel> get toDiscountLabels {
    final discounts = [
      '20% Off',
      '30% Off',
      '50% Off',
      'Save 20%',
      'Save 30%',
      'Save 50%',
    ];
    return discounts.map(asTextLabel).toList();
  }

  /// Returns a list of TextLabels for markup pricing.
  ///
  /// Useful for displaying marked up prices.
  ///
  /// Example:
  /// ```dart
  /// final cost = 100.0;
  /// final markups = cost.toMarkupLabels;
  /// // Returns 20%, 30%, 50% markup prices
  /// ```
  List<TextLabel> get toMarkupLabels {
    final markups = [
      '20% Markup',
      '30% Markup',
      '50% Markup',
    ];
    return markups.map(asTextLabel).toList();
  }
}
