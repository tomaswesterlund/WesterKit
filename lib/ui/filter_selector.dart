import 'package:flutter/material.dart';
import 'package:wester_kit/ui/texts/header_text.dart';
import 'package:wester_kit/wk_app_colors.dart';

class FilterSelectorItem {
  final String label;
  final dynamic value;

  const FilterSelectorItem({required this.label, required this.value});
}

class FilterSelector extends StatelessWidget {
  final List<FilterSelectorItem> options;
  final FilterSelectorItem selectedValue;
  final ValueChanged<FilterSelectorItem> onSelected;

  final Color backgroundColor;
  final Color selectedColor;
  final Color unselectedTextColor;
  final Color selectedTextColor;
  final Color borderColor;

  const FilterSelector({
    super.key,
    required this.options,
    required this.selectedValue,
    required this.onSelected,
    this.backgroundColor = WkAppColors.surface,
    this.selectedColor = WkAppColors.primary,
    this.unselectedTextColor = WkAppColors.textPrimary,
    this.selectedTextColor = WkAppColors.surface,
    this.borderColor = WkAppColors.border,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: options.map((option) {
          final isSelected = selectedValue == option;

          return Expanded(
            child: GestureDetector(
              onTap: () => onSelected(option),
              behavior: HitTestBehavior.opaque,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  color: isSelected ? selectedColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(24),
                ),
                alignment: Alignment.center,
                // Using HeaderText.six (H6: 14px / 16 line)
                child: HeaderText.six(
                  option.label,
                  textAlign: TextAlign.center,
                  color: isSelected ? selectedTextColor : unselectedTextColor,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
