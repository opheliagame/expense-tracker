import 'package:flutter/material.dart';

class MyChip extends StatelessWidget {
  const MyChip({
    super.key,
    required this.label,
    this.labelStyle,
    this.labelPadding,
    this.backgroundColor,
  });

  final String label;
  final TextStyle? labelStyle;
  final EdgeInsets? labelPadding;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: labelPadding ?? const EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(4),
        ),
        color: backgroundColor ?? Theme.of(context).colorScheme.surface,
      ),
      child: Text(
        label,
        style: labelStyle ?? Theme.of(context).textTheme.labelSmall,
      ),
    );
  }
}
