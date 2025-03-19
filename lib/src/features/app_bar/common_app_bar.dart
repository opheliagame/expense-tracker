import 'package:flutter/material.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Expense Tracker'),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}
