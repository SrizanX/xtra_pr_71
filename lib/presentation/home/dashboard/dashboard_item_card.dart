import 'package:flutter/material.dart';

class DashboardItemCard extends StatelessWidget {
  final Widget child;

  const DashboardItemCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: child,
      ),
    );
  }
}
