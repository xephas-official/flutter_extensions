import '../../../app_exporter.dart';

/// Widget for displaying category filters as chips
class CategoryFilters extends ConsumerWidget {
  /// Constructor
  const CategoryFilters({
    required this.categories,
    required this.selectedCategory,
    super.key,
  });

  /// List of categories to display
  final List<String> categories;

  /// Currently selected category
  final String selectedCategory;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: kToolbarHeight,
      alignment: Alignment.center,
      color: Colors.white,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(categories.length, (index) {
            final category = categories[index];
            final isSelected = category == selectedCategory;
            final isFirst = index == 0;
            final isLast = index == (categories.length - 1);

            final backColor = navyBlue.withValues(alpha: 0.1);
            const selectedColor = navyBlue;
            const textColor = Colors.white;

            final enabledPadding = isSelected
                ? const EdgeInsets.symmetric(horizontal: 4)
                : const EdgeInsets.symmetric(horizontal: 2);

            final padding = isFirst
                ? const EdgeInsets.only(left: 16, right: 2)
                : isLast
                ? const EdgeInsets.only(left: 2, right: 16)
                : enabledPadding;

            return AnimatedPadding(
              duration: const Duration(seconds: 1),
              padding: padding,
              key: Key(category),
              child: FilterChip(
                shape: StadiumBorder(
                  side: BorderSide(
                    width: isSelected ? 2 : 0,
                    color: isSelected ? selectedColor : backColor,
                  ),
                ),
                pressElevation: 10,
                tooltip: category,
                label: Text(
                  category,
                  style: TextStyle(
                    color: isSelected ? textColor : selectedColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                backgroundColor: backColor,
                avatar: isSelected
                    ? const CircleAvatar(
                        backgroundColor: textColor,
                        child: Icon(
                          Icons.check,
                          size: 14,
                          color: selectedColor,
                        ),
                      )
                    : null,
                showCheckmark: false,
                selectedColor: selectedColor,
                selected: isSelected,
                onSelected: (selected) {
                  ref.read(selectedCategoryProvider.notifier).state = category;
                },
              ),
            );
          }),
        ),
      ),
    );
  }
}
