import 'package:butterfly_app/components/finding_page/heading_image.dart';
import 'package:butterfly_app/info/butterfly_info.dart';
import 'package:flutter/material.dart';
import 'package:butterfly_app/components/finding_page/bullet.dart';
import 'package:butterfly_app/components/finding_page/info_card.dart';
import 'package:butterfly_app/components/finding_page/info_chip.dart';
// Achtung: Passe den Importpfad bei Bedarf an dein Projekt an

class FindingResultPage extends StatelessWidget {
  final String speciesId;  // z. B. "Admiral", "Kleiner Fuchs"
  final String imageUrl;   // Bild-URL von der API

  const FindingResultPage({
    super.key,
    required this.speciesId,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    // Informationen zu diesem Falter aus der Map abrufen
    final info = butterflyInfoMap[speciesId];

    // Wenn nichts gefunden, Fehlermeldung anzeigen
    if (info == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Unbekannter Falter')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              'Für diesen Schmetterling sind keine Informationen vorhanden.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(speciesId)),
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              scheme.primaryContainer.withOpacity(0.35),
              Theme.of(context).scaffoldBackgroundColor,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
            children: [
              // Netzwerk- oder Lokales Bild
              HeaderImage(imagePath: imageUrl),
              const SizedBox(height: 20),

              // Titel
              Text(
                speciesId,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),

              // Beschreibung
              Text(
                info.description,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),

              // Dynamische Info-Chips
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: info.chips
                    .map((chip) => InfoChip(icon: chip.icon, label: chip.label))
                    .toList(),
              ),
              const SizedBox(height: 20),

              // Dynamische Info-Karten
              ...info.cards.map(
                (card) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: InfoCard(
                    title: card.title,
                    leading: card.leading,
                    children:
                        card.bullets.map((b) => Bullet(b)).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
