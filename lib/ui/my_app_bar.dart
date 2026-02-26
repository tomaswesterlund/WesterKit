import 'package:flutter/material.dart';
import 'package:wester_kit/wk_app_colors.dart';
import 'package:wester_kit/extensions/nullable_string_extensions.dart';
import 'package:wester_kit/ui/texts/header_text.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool automaticallyImplyLeading;
  final List<Widget>? actions;
  final Color backgroundColor;
  final Color foregroundColor;

  const MyAppBar({
    required this.title,
    this.automaticallyImplyLeading = true,
    this.actions, // Removed "= null" as it is redundant for nullable types
    this.backgroundColor = Colors.transparent,
    this.foregroundColor = WkAppColors.textPrimary, // Standardized to your brand text color
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: automaticallyImplyLeading,
      title: title.isNotNullOrEmpty() ? HeaderText.four(title!) : null,
      centerTitle: true,
      elevation: 0,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      // Ensures system icons (battery, time) contrast correctly
      iconTheme: IconThemeData(color: foregroundColor),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}