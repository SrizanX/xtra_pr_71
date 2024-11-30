import 'package:flutter/material.dart';

class AppDialogWidget extends StatelessWidget {
  final String? title;
  final String? message;
  final Function()? onPositiveButtonClick;

  const AppDialogWidget({
    super.key,
    this.title,
    this.message,
    this.onPositiveButtonClick,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "$title",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "$message",
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: OutlinedButton(
                  onPressed: onPositiveButtonClick,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.power_settings_new,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Yes",
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary),
                      )
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
