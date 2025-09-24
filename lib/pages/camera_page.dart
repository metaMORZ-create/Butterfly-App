import 'dart:io';
import 'package:butterfly_app/services/image_service.dart';
import 'package:flutter/material.dart';
import 'finding_result_page.dart';

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

      // Nach Foto -> zur Ergebnis-Seite navigieren
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => FindingResultPage(imageFile: image),
        ),
      );
    }
  }

  void _notImplemented(String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("$feature ist noch nicht implementiert.")),
    );
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
                  onPressed: () => _notImplemented("Live-Aufnahme starten"),
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
