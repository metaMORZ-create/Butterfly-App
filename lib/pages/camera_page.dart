import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:butterfly_app/services/image_service.dart';
import 'package:butterfly_app/info/butterfly_list.dart';
import 'finding_result_page.dart'; // passe bei Bedarf den Pfad an

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  File? _lastImage;

  Future<void> _takePhoto() async {
    final image = await ImageService.takePhoto();
    if (image != null && mounted) {
      setState(() => _lastImage = image);

      // Zufällige butterflyId aus der Map
      final ids = idToSpeciesName.keys.toList();
      final randomId = ids[Random().nextInt(ids.length)];

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => FindingResultPage(
            butterflyId: randomId,
            imageUrl: image.path, // lokaler Pfad
          ),
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
                  color:
                      Theme.of(context).colorScheme.primary.withOpacity(0.6),
                ),
              const SizedBox(height: 20),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: _takePhoto,
                  icon: const Icon(Icons.photo_camera),
                  label: const Text("Foto aufnehmen"),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Live-Aufnahme starten ist noch nicht implementiert.")),
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
