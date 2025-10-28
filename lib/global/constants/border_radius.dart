import '../../app_exporter.dart';

/// Border radius constants for consistent UI styling across the app.
///
/// Use these named constants instead of inline BorderRadius.circular() calls
/// to maintain design consistency and simplify future updates.

// Circular Radii following the 8px grid system

/// 16 circular radius
const circularRadius16 = Radius.circular(spacing16);

/// 12 circular radius
const circularRadius12 = Radius.circular(12);

/// 8 circular radius
const circularRadius8 = Radius.circular(spacing8);

/// 6 circular radius
const circularRadius6 = Radius.circular(6);

/// 4 circular radius
const circularRadius4 = Radius.circular(spacing4);

/// 2 circular radius
const circularRadius2 = Radius.circular(spacing2);

// Border Radii following the 8px grid system

/// border radius 16
const borderRadius16 = BorderRadius.all(circularRadius16);

/// border radius 12
const borderRadius12 = BorderRadius.all(circularRadius12);

/// border radius 8
const borderRadius8 = BorderRadius.all(circularRadius8);

/// border radius 6
const borderRadius6 = BorderRadius.all(circularRadius6);

/// border radius 4
const borderRadius4 = BorderRadius.all(circularRadius4);

/// border radius 2
const borderRadius2 = BorderRadius.all(circularRadius2);

/// border radius 0
const BorderRadius borderRadius0 = BorderRadius.zero;

/// border radius 200 (circular)
const BorderRadius borderRadius200 = BorderRadius.all(Radius.circular(200));
