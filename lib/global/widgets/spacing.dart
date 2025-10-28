import 'package:gap/gap.dart';

import '../../app_exporter.dart';

/// Provides dynamic spacing between widgets using the gap package.
///
/// This widget creates consistent gaps in layouts that automatically
/// adapt to the parent's direction (vertical in Column, horizontal in Row).
class Spacing extends StatelessWidget {
  /// Creates a spacing widget with the specified gap.
  const Spacing({required this.of, super.key});

  /// Amount of space between widgets
  final double of;

  @override
  Widget build(BuildContext context) {
    return Gap(of);
  }
}

/// Sliver version of Spacing for use in CustomScrollView and similar widgets.
class SliverSpacing extends StatelessWidget {
  /// Creates sliver spacing.
  const SliverSpacing({required this.of, super.key});

  /// Amount of space between widgets
  final double of;

  @override
  Widget build(BuildContext context) {
    return SliverGap(of);
  }
}

/// Empty space widget for collapsing layouts.
class EmptySpace extends StatelessWidget {
  /// Creates an empty space widget.
  const EmptySpace({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}

/// Empty space for sliver widgets.
class SliverEmptySpace extends StatelessWidget {
  /// Creates sliver empty space.
  const SliverEmptySpace({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(child: EmptySpace());
  }
}
