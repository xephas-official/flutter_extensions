import 'package:intl/intl.dart';
import '../utils/text_label.dart';

/// DateTime extensions for formatting and date manipulation.
///
/// Provides comprehensive date formatting utilities using the intl package
/// and common date operations inspired by Flutter/Dart patterns.
extension DateTimeExtensions on DateTime {
  // ============ Date Formatters ============

  /// Formats date as 'Monday, 15 January 2024'.
  ///
  /// Returns full weekday, day, month, and year.
  String get toFullDate {
    final formatter = DateFormat('EEEE, dd MMMM yyyy');
    return formatter.format(this);
  }

  /// Formats date as 'Mon, 15 Jan 24 - 02:30 PM'.
  ///
  /// Returns abbreviated weekday, date, and 12-hour time.
  String get toSoldDate {
    final formatter = DateFormat('EEE, dd MMM yy - hh:mm a');
    return formatter.format(this);
  }

  /// Formats date as 'Jan 15, 2024'.
  ///
  /// Returns abbreviated month, day, and year.
  String get toShortDate {
    final formatter = DateFormat('MMM dd, yyyy');
    return formatter.format(this);
  }

  /// Formats date as '15/01/2024'.
  ///
  /// Returns day/month/year numeric format.
  String get toNumericDate {
    final formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(this);
  }

  /// Formats date as '2024-01-15'.
  ///
  /// Returns ISO-style YYYY-MM-DD format.
  String get toISODate {
    final formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(this);
  }

  /// Formats date as 'January 15'.
  ///
  /// Returns full month and day without year.
  String get toMonthDay {
    final formatter = DateFormat('MMMM dd');
    return formatter.format(this);
  }

  /// Formats date as 'Jan 2024'.
  ///
  /// Returns abbreviated month and year.
  String get toMonthYear {
    final formatter = DateFormat('MMM yyyy');
    return formatter.format(this);
  }

  /// Formats date as 'Monday, January 15'.
  ///
  /// Returns full weekday, month, and day.
  String get toWeekdayMonthDay {
    final formatter = DateFormat('EEEE, MMMM dd');
    return formatter.format(this);
  }

  /// Formats date as '2:30 PM'.
  ///
  /// Returns 12-hour time with AM/PM.
  String get toTime12Hour {
    final formatter = DateFormat('h:mm a');
    return formatter.format(this);
  }

  /// Formats date as '14:30'.
  ///
  /// Returns 24-hour time format.
  String get toTime24Hour {
    final formatter = DateFormat('HH:mm');
    return formatter.format(this);
  }

  /// Formats date as 'Mon, Jan 15, 2:30 PM'.
  ///
  /// Returns abbreviated weekday, date, and time.
  String get toDateTimeShort {
    final formatter = DateFormat('EEE, MMM dd, h:mm a');
    return formatter.format(this);
  }

  /// Formats date as 'Monday, January 15, 2024 at 2:30 PM'.
  ///
  /// Returns full date and time in readable format.
  String get toDateTimeFull {
    final formatter = DateFormat('EEEE, MMMM dd, yyyy at h:mm a');
    return formatter.format(this);
  }

  /// Formats date as 'Q1 2024' (Quarter and Year).
  ///
  /// Returns the quarter and year.
  String get toQuarterYear {
    final quarter = ((month - 1) ~/ 3) + 1;
    return 'Q$quarter $year';
  }

  /// Formats date as 'January'.
  ///
  /// Returns full month name only.
  String get toMonthName {
    final formatter = DateFormat('MMMM');
    return formatter.format(this);
  }

  /// Formats date as 'Jan'.
  ///
  /// Returns abbreviated month name.
  String get toMonthNameShort {
    final formatter = DateFormat('MMM');
    return formatter.format(this);
  }

  /// Formats date as 'Monday'.
  ///
  /// Returns full weekday name.
  String get toWeekdayName {
    final formatter = DateFormat('EEEE');
    return formatter.format(this);
  }

  /// Formats date as 'Mon'.
  ///
  /// Returns abbreviated weekday name.
  String get toWeekdayNameShort {
    final formatter = DateFormat('EEE');
    return formatter.format(this);
  }

  /// Formats date as '2024'.
  ///
  /// Returns year only.
  String get toYear {
    return year.toString();
  }

  // ============ Relative Date Helpers ============

  /// Returns 'Today', 'Yesterday', or formatted date.
  ///
  /// Smart formatter that shows relative dates for recent dates.
  String get toRelativeDate {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dateToCheck = DateTime(year, month, day);
    final difference = today.difference(dateToCheck).inDays;

    if (difference == 0) {
      return 'Today';
    } else if (difference == 1) {
      return 'Yesterday';
    } else if (difference == -1) {
      return 'Tomorrow';
    } else if (difference > 0 && difference < 7) {
      return '$difference days ago';
    } else if (difference < 0 && difference > -7) {
      return 'In ${difference.abs()} days';
    }
    return toShortDate;
  }

  /// Returns time ago in human-readable format.
  ///
  /// Examples: '5 minutes ago', '2 hours ago', '3 days ago'
  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inSeconds < 60) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      final minutes = difference.inMinutes;
      return '$minutes ${minutes == 1 ? 'minute' : 'minutes'} ago';
    } else if (difference.inHours < 24) {
      final hours = difference.inHours;
      return '$hours ${hours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inDays < 7) {
      final days = difference.inDays;
      return '$days ${days == 1 ? 'day' : 'days'} ago';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks ${weeks == 1 ? 'week' : 'weeks'} ago';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return '$months ${months == 1 ? 'month' : 'months'} ago';
    } else {
      final years = (difference.inDays / 365).floor();
      return '$years ${years == 1 ? 'year' : 'years'} ago';
    }
  }

  // ============ Date Validation ============

  /// Checks if date is today.
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  /// Checks if date is yesterday.
  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day;
  }

  /// Checks if date is tomorrow.
  bool get isTomorrow {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return year == tomorrow.year &&
        month == tomorrow.month &&
        day == tomorrow.day;
  }

  /// Checks if date is in the past.
  bool get isPast => isBefore(DateTime.now());

  /// Checks if date is in the future.
  bool get isFuture => isAfter(DateTime.now());

  /// Checks if date is a weekend (Saturday or Sunday).
  bool get isWeekend =>
      weekday == DateTime.saturday || weekday == DateTime.sunday;

  /// Checks if date is a weekday (Monday to Friday).
  bool get isWeekday => !isWeekend;

  /// Checks if date is in current month.
  bool get isThisMonth {
    final now = DateTime.now();
    return year == now.year && month == now.month;
  }

  /// Checks if date is in current year.
  bool get isThisYear {
    return year == DateTime.now().year;
  }

  // ============ Date Manipulation ============

  /// Returns the first day of the month.
  DateTime get firstDayOfMonth => DateTime(year, month);

  /// Returns the last day of the month.
  DateTime get lastDayOfMonth => DateTime(year, month + 1, 0);

  /// Returns the first day of the year.
  DateTime get firstDayOfYear => DateTime(year);

  /// Returns the last day of the year.
  DateTime get lastDayOfYear => DateTime(year, 12, 31);

  /// Adds specified number of days.
  DateTime addDays(int days) => add(Duration(days: days));

  /// Subtracts specified number of days.
  DateTime subtractDays(int days) => subtract(Duration(days: days));

  /// Adds specified number of months.
  DateTime addMonths(int months) {
    var newMonth = month + months;
    var newYear = year;

    while (newMonth > 12) {
      newMonth -= 12;
      newYear++;
    }
    while (newMonth < 1) {
      newMonth += 12;
      newYear--;
    }

    final lastDayOfNewMonth = DateTime(newYear, newMonth + 1, 0).day;
    final newDay = day > lastDayOfNewMonth ? lastDayOfNewMonth : day;

    return DateTime(newYear, newMonth, newDay, hour, minute, second);
  }

  /// Adds specified number of years.
  DateTime addYears(int years) {
    return DateTime(year + years, month, day, hour, minute, second);
  }

  /// Returns date with time set to midnight (00:00:00).
  DateTime get startOfDay => DateTime(year, month, day);

  /// Returns date with time set to end of day (23:59:59).
  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59, 999);

  // ============ Age Calculation ============

  /// Calculates age in years from this date to now.
  ///
  /// Useful for birthdate to age conversion.
  int get age {
    final now = DateTime.now();
    var calculatedAge = now.year - year;
    if (now.month < month || (now.month == month && now.day < day)) {
      calculatedAge--;
    }
    return calculatedAge;
  }

  /// Returns number of days until this date.
  ///
  /// Returns negative number if date is in the past.
  int get daysUntil {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final target = DateTime(year, month, day);
    return target.difference(today).inDays;
  }

  /// Returns number of days since this date.
  ///
  /// Returns negative number if date is in the future.
  int get daysSince {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final target = DateTime(year, month, day);
    return today.difference(target).inDays;
  }

  // ============ TextLabel Conversion ============

  /// Converts a date to a TextLabel with a specific format.
  ///
  /// Returns TextLabel with the format type as label and formatted value.
  TextLabel asTextLabel(String formatType) {
    String convertedValue;
    switch (formatType) {
      case 'Full Date':
        convertedValue = toFullDate;
      case 'Sold Date':
        convertedValue = toSoldDate;
      case 'Short Date':
        convertedValue = toShortDate;
      case 'Numeric Date':
        convertedValue = toNumericDate;
      case 'ISO Date':
        convertedValue = toISODate;
      case 'Month Day':
        convertedValue = toMonthDay;
      case 'Month Year':
        convertedValue = toMonthYear;
      case 'Weekday Month Day':
        convertedValue = toWeekdayMonthDay;
      case '12-Hour Time':
        convertedValue = toTime12Hour;
      case '24-Hour Time':
        convertedValue = toTime24Hour;
      case 'DateTime Short':
        convertedValue = toDateTimeShort;
      case 'DateTime Full':
        convertedValue = toDateTimeFull;
      case 'Quarter Year':
        convertedValue = toQuarterYear;
      case 'Month Name':
        convertedValue = toMonthName;
      case 'Month Short':
        convertedValue = toMonthNameShort;
      case 'Weekday Name':
        convertedValue = toWeekdayName;
      case 'Weekday Short':
        convertedValue = toWeekdayNameShort;
      case 'Year':
        convertedValue = toYear;
      case 'Relative Date':
        convertedValue = toRelativeDate;
      case 'Time Ago':
        convertedValue = timeAgo;
      default:
        convertedValue = toString();
    }

    return TextLabel(
      label: formatType,
      value: convertedValue,
    );
  }

  /// Returns a list of TextLabels for all date format types.
  ///
  /// Useful for demonstrating all formatting options in UI.
  /// Each TextLabel contains the format name and the formatted value.
  List<TextLabel> get toTextLabels {
    final formats = [
      'Full Date',
      'Sold Date',
      'Short Date',
      'Numeric Date',
      'ISO Date',
      'Month Day',
      'Month Year',
      'Weekday Month Day',
      '12-Hour Time',
      '24-Hour Time',
      'DateTime Short',
      'DateTime Full',
      'Quarter Year',
      'Month Name',
      'Month Short',
      'Weekday Name',
      'Weekday Short',
      'Year',
      'Relative Date',
      'Time Ago',
    ];

    return formats.map(asTextLabel).toList();
  }

  /// Returns a list of TextLabels for date-only formats.
  ///
  /// Useful for displaying dates without time.
  List<TextLabel> get toDateLabels {
    final formats = [
      'Full Date',
      'Short Date',
      'Numeric Date',
      'ISO Date',
      'Month Day',
      'Month Year',
      'Weekday Month Day',
    ];
    return formats.map(asTextLabel).toList();
  }

  /// Returns a list of TextLabels for time-only formats.
  ///
  /// Useful for displaying time without date.
  List<TextLabel> get toTimeLabels {
    final formats = [
      '12-Hour Time',
      '24-Hour Time',
    ];
    return formats.map(asTextLabel).toList();
  }

  /// Returns a list of TextLabels for relative date formats.
  ///
  /// Useful for displaying human-readable relative dates.
  List<TextLabel> get toRelativeLabels {
    final formats = [
      'Relative Date',
      'Time Ago',
    ];
    return formats.map(asTextLabel).toList();
  }
}

/// Extension for nullable DateTime.
extension NullableDateTimeExtensions on DateTime? {
  /// Returns formatted date or default text if null.
  ///
  /// Useful for handling nullable dates safely.
  String orDefault([String defaultText = 'N/A']) {
    return this?.toShortDate ?? defaultText;
  }

  /// Returns true if the date is null.
  bool get isNull => this == null;

  /// Returns true if the date is not null.
  bool get isNotNull => this != null;
}
