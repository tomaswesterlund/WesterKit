import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wester_kit/wk_app_colors.dart';

class FilterSelectorItem {
  final String label;
  final dynamic value;

  const FilterSelectorItem({required this.label, required this.value});
}

class FilterSelector extends StatelessWidget {
  final List<FilterSelectorItem> options;
  final FilterSelectorItem selectedValue;
  final Function(FilterSelectorItem) onSelected;

  // Customization properties for WesterKit flexibility
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
    // Defaulting to WesterKit Brand Colors
    this.backgroundColor = WkAppColors.surface,
    this.selectedColor = WkAppColors.primary,
    this.unselectedTextColor = WkAppColors.textPrimary,
    this.selectedTextColor = WkAppColors.surface,
    this.borderColor = WkAppColors.border, // Replaces auxiliarScale[100]
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
                child: Text(
                  option.label,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.raleway(
                    color: isSelected ? selectedTextColor : unselectedTextColor,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
