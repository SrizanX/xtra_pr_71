import 'package:flutter/material.dart';

class DashboardItem extends StatelessWidget {
  final String label;
  final String data;

  const DashboardItem({super.key, required this.label, required this.data});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        Text(data),
      ],
    );
  }
}
