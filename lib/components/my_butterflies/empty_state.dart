import 'package:flutter/material.dart';

class MyButterfliesEmptyState extends StatelessWidget {
  const MyButterfliesEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.bug_report, size: 64, color: scheme.primary),
            const SizedBox(height: 12),
            Text(
              'Noch keine Uploads',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 6),
            const Text(
              'Take a Picture of a butterfly and upload it to see it here!',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
