import 'dart:io';
import 'package:flutter/material.dart';
import 'package:butterfly_app/pages/new_capture_result_page.dart';
import 'package:butterfly_app/services/image_service.dart';
import 'package:butterfly_app/services/identification_service.dart'; // <- classifyPhoto
import 'package:butterfly_app/info/butterfly_list.dart'; // <- idToSpeciesName

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  File? _lastImage;

  /// Mappt den Species-Namen (von der API) zur ID aus `idToSpeciesName`.
  /// Vergleicht case-insensitive und getrimmt.
  int? _speciesToId(String species) {
    final target = species.trim().toUpperCase();
    for (final entry in idToSpeciesName.entries) {
      if (entry.value.toUpperCase() == target) return entry.key;
    }
    return null;
  }

  Future<void> _takePhoto() async {
    final image = await ImageService.takePhoto();
    if (image == null || !mounted) return;

    setState(() => _lastImage = image);

    // Loader anzeigen (modal, nicht wegklickbar)
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    try {
      // 1) Species vom Backend holen
      final species = await IdentificationService.classifyPhoto(file: image);
      // 2) Species -> ID mappen
      final id = _speciesToId(species);

      // Loader schließen
      if (mounted) Navigator.of(context).pop();

      if (id == null) {
        // Kein Mapping gefunden: Nutzer informieren
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Unknown species returned: $species"),
            backgroundColor: Colors.orange,
          ),
        );
        return;
      }

      // 3) Weiter zur Result-Page mit korrekter ID
      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => NewCaptureResultPage(
            butterflyId: id,
            imagePath: image.path,
          ),
        ),
      );
    } catch (e) {
      // Loader schließen bei Fehler
      if (mounted) Navigator.of(context).pop();
      // Fehler anzeigen
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Classification failed: $e"),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Kamera")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_lastImage != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.file(
                    _lastImage!,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                )
              else
                Icon(
                  Icons.camera_alt_rounded,
                  size: 120,
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.6),
                ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: _takePhoto,
                  icon: const Icon(Icons.photo_camera),
                  label: const Text("Foto aufnehmen & identifizieren"),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Live-Aufnahme starten ist noch nicht implementiert."),
                    ),
                  ),
                  icon: const Icon(Icons.videocam),
                  label: const Text("Live-Aufnahme starten"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
