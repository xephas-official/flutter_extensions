import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider for the selected product category filter
final selectedCategoryProvider = StateProvider<String>((ref) => 'All');
