import 'dart:io';

import 'package:butterfly_app/components/finding_page/bullet.dart';
import 'package:butterfly_app/components/finding_page/heading_image.dart';
import 'package:butterfly_app/components/finding_page/info_card.dart';
import 'package:butterfly_app/components/finding_page/info_chip.dart';
import 'package:flutter/material.dart';
import 'package:butterfly_app/info/butterfly_info.dart';
// Mapping from butterflyId to species name
import 'package:butterfly_app/info/butterfly_list.dart';
import 'package:butterfly_app/services/upload_service.dart';
import 'package:butterfly_app/services/finding_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
// Falls du dein eigenes Finding-Modell hast, importiere es entsprechend.
import 'package:butterfly_app/models/findings.dart';

/// Eine Seite für neue Fotoaufnahmen, die das lokale Bild anzeigt, die
/// zugehörige Art über die `speciesId` identifiziert und einen Speichern‑Button
/// anbietet. Über den Button wird das Bild mitsamt zugehöriger Art und
/// Standortdaten an den Server hochgeladen.
class NewCaptureResultPage extends StatelessWidget {
  /// Die numerische ID der Schmetterlingsart, wie sie vom Backend und der Datenbank verwendet wird.
  final int butterflyId;

  /// Der lokale Pfad des aufgenommenen Bildes.
  final String imagePath;

  const NewCaptureResultPage({
    super.key,
    required this.butterflyId,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    // Über die numerische ID den Namen ermitteln
    final speciesName = idToSpeciesName[butterflyId];
    final info = speciesName != null ? butterflyInfoMap[speciesName] : null;

    // Wenn für die gegebene ID keine Informationen vorliegen, eine
    // einfache Fehlermeldung anzeigen.
    if (info == null || speciesName == null) {
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
      appBar: AppBar(title: Text(speciesName)),
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
              // Bild anzeigen
              // Wenn imagePath kein http enthält, wird es als lokale Datei genutzt.
              // Dazu nutzen wir das HeaderImage aus deinem Komponentenordner.
              HeaderImage(imagePath: imagePath),
              const SizedBox(height: 20),
              Text(
                speciesName,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              Text(
                info.description,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: info.chips
                    .map((chip) => InfoChip(icon: chip.icon, label: chip.label))
                    .toList(),
              ),
              const SizedBox(height: 20),
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
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
          child: SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              onPressed: () async {
                // Beim Speichern die Foto- und Standortdaten an den Backend-Service senden.
                // Hole zunächst die userId aus den SharedPreferences (oder aus deinem Auth-Provider).
                final prefs = await SharedPreferences.getInstance();
                final userId = prefs.getInt('user_id');
                if (userId == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Keine User-ID gefunden. Bitte neu einloggen.'),
                    ),
                  );
                  return;
                }
                // Beispielhafte Koordinaten – in einer realen App über einen LocationService holen.
                const double latitude = 48.1372;
                const double longitude = 11.5756;
                try {
                  // Ladeindikator anzeigen
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) => const Center(child: CircularProgressIndicator()),
                  );
                  // Bild hochladen
                  final file = File(imagePath);
                  final result = await UploadService.uploadPhoto(
                    file: file,
                    userId: userId,
                    butterflyId: butterflyId,
                    latitude: latitude,
                    longitude: longitude,
                  );
                  // Optional lokal speichern. Das speciesName steht oben bereit,
                  // da wir es aus der idToSpeciesName Map bestimmt haben.
                  final localFinding = Finding(
                    id: const Uuid().v4(),
                    imagePath: imagePath,
                    name: speciesName,
                    description: info.description,
                    reproduction: info.reproduction,
                  );
                  await FindingService.saveFinding(localFinding);
                  // Ladeindikator schließen
                  if (context.mounted) Navigator.pop(context);
                  // Erfolgsmeldung
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Upload ok! URL: ${result.imageUrl}')),
                    );
                    Navigator.pop(context); // Zurück zur Kamera
                  }
                } catch (e) {
                  // Ladeindikator schließen
                  if (context.mounted) Navigator.pop(context);
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Upload fehlgeschlagen: $e')),
                    );
                  }
                }
              },
              icon: const Icon(Icons.bookmark_added),
              label: const Text('Fund speichern'),
            ),
          ),
        ),
      ),
    );
  }
}