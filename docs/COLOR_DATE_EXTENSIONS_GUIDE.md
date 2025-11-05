# Color and Date Extensions Implementation Guide

This document describes the newly implemented Color and Date extensions for the Flutter Extensions training project.

## Overview

Following the same patterns as the existing Number and String extensions, we've implemented comprehensive extension methods for `Color` and `DateTime` types, complete with TextLabel conversion functionality and UI demonstration widgets.

## Implementation Details

### 1. Product Model Updates

**File: `lib/data/models/product.dart`**

Added two new properties to the Product model:

- `dateManufactured` (DateTime) - Manufacturing date for each product
- `colors` (List) - List of available colors, populated from `randomColors`

```dart
final DateTime dateManufactured;
final List<Color> colors;
```

### 2. Product Repository Updates

**File: `lib/data/repositories/product_repository.dart`**

Updated `getSampleProducts()` to:

- Assign random manufacturing dates to each product (various dates in 2023-2024)
- Assign 2-5 random colors from the `randomColors` list to each product
- Helper function `getRandomColors(int count)` shuffles and picks random colors

Example:

```dart
Product(
  id: '1',
  name: 'Wireless Headphones',
  // ... other fields
  dateManufactured: DateTime(2024, 6, 15),
  colors: getRandomColors(3),
)
```

## Color Extensions

**File: `lib/global/extensions/color_extensions.dart`**

### Format Conversions

- `toHexWithAlpha` - Full hex with alpha (0xAARRGGBB)
- `toHex` - Hex with alpha and hash (#AARRGGBB)
- `toHexNoAlpha` - Hex without alpha (RRGGBB)
- `toHexNoAlphaWithHash` - Hex without alpha with hash (#RRGGBB)
- `toIntValue` - Integer value (0xAARRGGBB as int)
- `toRGB` - RGB(255, 0, 0)
- `toRGBA` - RGBA(255, 0, 0, 1.00)
- `toHSL` - HSL(180°, 50%, 50%)

### Color Analysis

- `brightness` - Returns brightness value (0.0 to 1.0)
- `isLight` - Check if color is light (brightness > 0.5)
- `isDark` - Check if color is dark
- `complementary` - Get complementary color (opposite on color wheel)
- `grayscale` - Convert to grayscale

### Opacity Variations

- `opacity10/20/30/50/70/90` - Opacity variations

### String to Color Conversion

The `HexStringToColor` extension on `String` allows parsing HEX strings:

- `'00297F'.toColor` - Parse HEX to Color (assumes full opacity)
- `'#FF00297F'.toColor` - Parse with hash and alpha
- `'0xFF00297F'.toColor` - Parse with 0x prefix
- `'invalid'.toColorOr(Colors.blue)` - Safe parsing with fallback

### TextLabel Conversion

Following the pattern from num/string extensions:

```dart
// Single format conversion
color.asTextLabel('Hex (#)')  // TextLabel(label: 'Hex (#)', value: '#FF0000')

// All format variations (17 total)
color.toTextLabels        // List<TextLabel> with all formats
color.toFormatLabels      // Hex, RGB, RGBA, HSL, Integer formats
color.toOpacityLabels     // All opacity variations
color.toAnalysisLabels    // Brightness, complementary, grayscale
```

## Date Extensions

**File: `lib/global/extensions/date_extensions.dart`**

Comprehensive date formatting and manipulation using the `intl` package.

### Date Formatters

- `toFullDate` - Monday, 15 January 2024
- `toSoldDate` - Mon, 15 Jan 24 - 02:30 PM
- `toShortDate` - Jan 15, 2024
- `toNumericDate` - 15/01/2024
- `toISODate` - 2024-01-15
- `toMonthDay` - January 15
- `toMonthYear` - Jan 2024
- `toWeekdayMonthDay` - Monday, January 15

### Time Formatters

- `toTime12Hour` - 2:30 PM
- `toTime24Hour` - 14:30

### Combined DateTime Formatters

- `toDateTimeShort` - Mon, Jan 15, 2:30 PM
- `toDateTimeFull` - Monday, January 15, 2024 at 2:30 PM

### Component Formatters

- `toQuarterYear` - Q1 2024
- `toMonthName` - January
- `toMonthNameShort` - Jan
- `toWeekdayName` - Monday
- `toWeekdayNameShort` - Mon
- `toYear` - 2024

### Relative Date Helpers

- `toRelativeDate` - Today/Yesterday/Tomorrow or formatted date
- `timeAgo` - "5 minutes ago", "2 hours ago", "3 days ago"

### Date Validation

- `isToday/isYesterday/isTomorrow`
- `isPast/isFuture`
- `isWeekend/isWeekday`
- `isThisMonth/isThisYear`

### Date Manipulation

- `firstDayOfMonth/lastDayOfMonth`
- `firstDayOfYear/lastDayOfYear`
- `addDays(int)/subtractDays(int)`
- `addMonths(int)/addYears(int)`
- `startOfDay/endOfDay` - Set time to midnight/23:59:59

### Age Calculation

- `age` - Calculate years from date to now
- `daysUntil` - Days until this date
- `daysSince` - Days since this date

### TextLabel Conversion for Date

Following the same pattern:

```dart
// Single format conversion
date.asTextLabel('Short Date')  // TextLabel(label: 'Short Date', value: 'Jan 15, 2024')

// All format variations
date.toTextLabels        // List<TextLabel> with all 20 formats
date.toDateLabels        // Date-only formats
date.toTimeLabels        // Time-only formats
date.toRelativeLabels    // Relative date formats
```

## UI Widgets

### ColorTitle Widget

**File: `lib/global/widgets/color_title.dart`**

Similar to `NumTitle` and `StringTitle`, displays color extension demonstrations:

Features:

- Color swatch preview (60x60 box)
- Hex code display
- Category chip with adaptive text color (black on light, white on dark)
- Expansion tile with all color format variations
- Visual color swatches for opacity transformations
- Uses green theme color (`appGreen`)

Usage:

```dart
ColorTitle(
  labelColor: Colors.blue,
  labelText: 'Custom Label', // optional, defaults to 'Color Extensions'
)
```

### DateTitle Widget

**File: `lib/global/widgets/date_title.dart`**

Displays date extension demonstrations:

Features:

- Short date display in title
- Category chip with "DATE EXTENSIONS" label
- Expansion tile with all 20 date format variations
- Uses green theme color (`appGreen`)
- Font size 24 for date display

Usage:

```dart
DateTitle(
  labelDate: DateTime.now(),
)
```

## Product Detail Screen Integration

**File: `lib/features/details/product_detail_screen.dart`**

Added two new sections to the product detail screen:

### Manufacturing Date Section

```dart
DateTitle(labelDate: product.dateManufactured)
```

Displays the product's manufacturing date with all format variations.

### Available Colors Section

```dart
if (product.colors.isNotEmpty) ...[
  Text('Available Colors', ...),
  const Spacing(of: spacing12),
  ...product.colors.map(
    (color) => ColorTitle(labelColor: color),
  ),
],
```

Displays all available colors for the product, each with its own expansion tile showing all color format variations and transformations.

## Usage Examples

### Color Extensions Examples

```dart
final color = Colors.blue;

// Format conversions
print(color.toHex);           // #FF2196F3
print(color.toHexNoAlphaWithHash);  // #2196F3
print(color.toRGB);           // RGB(33, 150, 243)
print(color.toHSL);           // HSL(207°, 89%, 54%)
print(color.toIntValue);      // 4280391411

// Analysis
print(color.brightness);       // 0.54
print(color.isLight);         // true
print(color.complementary.toHex);  // #FFED6C09

// Transformations
final transparent = color.opacity50;
final gray = color.grayscale;

// String to Color parsing
final parsed = '00297F'.toColor;  // Color(0xFF00297F)
final safeParsed = 'invalid'.toColorOr(Colors.blue);  // Colors.blue

// TextLabels for UI
final labels = color.toTextLabels;  // All 17 format variations
final formatLabels = color.toFormatLabels;  // Only format conversions
final analysisLabels = color.toAnalysisLabels;  // Only analysis results
```

### Date Extensions Examples

```dart
final date = DateTime(2024, 6, 15, 14, 30);

// Formatting
print(date.toFullDate);       // Monday, 15 June 2024
print(date.toShortDate);      // Jun 15, 2024
print(date.toTime12Hour);     // 2:30 PM
print(date.timeAgo);          // 5 months ago

// Validation
print(date.isWeekend);        // false
print(date.isThisYear);       // true

// Manipulation
final nextMonth = date.addMonths(1);
final startDay = date.startOfDay;

// TextLabels for UI
final labels = date.toTextLabels;  // All 20 format variations
```

## Design Patterns Applied

1. **Consistency**: Color and Date extensions follow the exact same patterns as Number and String extensions
2. **TextLabel Pattern**: All extensions provide `asTextLabel()` and `toTextLabels` for UI demonstration
3. **Categorized Labels**: Grouped label getters (e.g., `toFormatLabels`, `toOpacityLabels`, `toAnalysisLabels`) for different use cases
4. **Widget Consistency**: ColorTitle and DateTitle match the style and structure of NumTitle and StringTitle
5. **Extension-First API**: All formatters are extensions, not standalone functions
6. **Null Safety**: Nullable extensions included (e.g., `NullableDateTimeExtensions`)
7. **String Parsing**: HexStringToColor extension enables parsing HEX strings to Color objects

## Testing the Implementation

Run the app and navigate to any product detail screen to see:

1. The manufacturing date section with DateTitle expansion tile
2. The available colors section with multiple ColorTitle expansion tiles
3. Click on any expansion tile to see all format variations
4. Color tiles show visual swatches for shade transformations

## Constants Used

From `lib/global/constants/`:

- **Colors**: `appGreen`, `black`, `white`, `transparent`, `randomColors`
- **Spacing**: `spacing4`, `spacing8`, `spacing12`, `spacing16`, `spacing24`, `spacing32`, `spacing64`
- **Insets**: `allInsets2`, `allInsets4`, `allInsets16`
- **Border Radius**: `borderRadius4`, `borderRadius8`
- **Font Sizes**: `fontSize14`, `fontSize20`, `fontSize24`
- **Text Styles**: `boldTextStyle`, `regularTextStyle`

## Package Dependencies

The implementation uses:

- `intl` package (already in pubspec.yaml) for date formatting
- No additional packages required for color extensions
- All extensions use built-in Flutter/Dart APIs

## Future Enhancements

Potential additions following the same pattern:

1. **Duration Extensions** - Format durations in human-readable ways
2. **List of Color Extensions** - Gradient generation, palette analysis
3. **Theme Extensions** - Theme-specific color operations
4. **DateTimeRange Extensions** - Working with date ranges

---

**Pattern Philosophy**: The key principle is consistency - every extension type (num, string, color, date) follows the same structure with format conversions, TextLabel support, and dedicated UI widgets for demonstration.
