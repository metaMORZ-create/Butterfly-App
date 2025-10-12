import 'package:flutter/material.dart';

class SaveFindingBar extends StatelessWidget {
  final Future<void> Function() onSave;

  const SaveFindingBar({super.key, required this.onSave});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
        child: SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            ),
            onPressed: () async {
              await onSave();
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Fund gespeichert!")),
                );
                Navigator.pop(context);
              }
            },
            icon: const Icon(Icons.bookmark_added),
            label: const Text("Fund speichern"),
          ),
        ),
      ),
    );
  }
}
