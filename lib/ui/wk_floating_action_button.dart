import 'package:flutter/material.dart';
import 'package:wester_kit/lib.dart';

class WkFloatingActionButton extends StatelessWidget {
  final VoidCallback? onPressed;
  const WkFloatingActionButton({this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
          backgroundColor: WkAppColors.primary,
          onPressed: onPressed,
          child: const Icon(Icons.add, color: Colors.white),
        );
  }
}