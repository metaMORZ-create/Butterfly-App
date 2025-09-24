import 'package:flutter/material.dart';
import 'my_butterflies_page.dart'; // <--- Import hinzufügen

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  void _notImplemented(BuildContext context, String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("$feature ist noch nicht implementiert.")),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Informationen"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.menu_book_rounded,
                size: 120,
                color: scheme.primary.withOpacity(0.7),
              ),
              const SizedBox(height: 20),
              Text(
                "Hier findest du deine Entdeckungen,\nden Katalog und die Heatmap.",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey[600],
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),

              // Meine Schmetterlinge
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  style: FilledButton.styleFrom(
                    backgroundColor: scheme.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: const TextStyle(fontSize: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const MyButterfliesPage(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.bug_report),
                  label: const Text("Meine gefundenen Schmetterlinge"),
                ),
              ),
              const SizedBox(height: 16),

              // Katalog
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  style: FilledButton.styleFrom(
                    backgroundColor: scheme.primaryContainer,
                    foregroundColor: scheme.onPrimaryContainer,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: const TextStyle(fontSize: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () => _notImplemented(context, "Katalog"),
                  icon: const Icon(Icons.collections_bookmark),
                  label: const Text("Schmetterlingskatalog"),
                ),
              ),
              const SizedBox(height: 16),

              // Heatmap
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: const TextStyle(fontSize: 18),
                    side: BorderSide(color: scheme.primary, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () => _notImplemented(context, "Heatmap"),
                  icon: const Icon(Icons.map),
                  label: const Text("Heatmap"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
