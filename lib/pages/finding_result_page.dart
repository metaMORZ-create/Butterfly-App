// lib/features/camera/finding_result_page.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'package:butterfly_app/services/upload_service.dart';
import 'package:butterfly_app/services/retrieval_service.dart';

// Dein vorhandenes Demo/Local-Modell
import 'package:butterfly_app/models/findings.dart';
// Für ButterflyLite (API-Details)
import 'package:butterfly_app/models/user_upload.dart';

class FindingResultPage extends StatefulWidget {
  /// Fall A: neue Aufnahme (lokale Datei)
  final File? imageFile;

  /// Fall B: aus „Meine Schmetterlinge“ geöffnet (Cloud-URL + butterflyId)
  final String? imageUrl;
  final int? butterflyId;

  /// Optional: vorhandenes Finding (dein altes Verhalten)
  final Finding? finding;

  const FindingResultPage({
    super.key,
    required this.imageFile,
  })  : imageUrl = null,
        butterflyId = null,
        finding = null;

  const FindingResultPage.fromFinding({
    super.key,
    required this.finding,
  })  : imageFile = null,
        imageUrl = null,
        butterflyId = null;

  /// Neuer bequemer Konstruktor, wenn du direkt aus der Liste kommst.
  const FindingResultPage.fromUpload({
    super.key,
    required this.imageUrl,
    required this.butterflyId,
  })  : imageFile = null,
        finding = null;

  @override
  State<FindingResultPage> createState() => _FindingResultPageState();
}

class _FindingResultPageState extends State<FindingResultPage> {
  ButterflyLite? _butterfly; // vom Server geladen
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _maybeLoadButterfly();
  }

  Future<void> _maybeLoadButterfly() async {
    // Nur laden, wenn wir eine butterflyId haben und KEIN fertiges Finding mit Daten übergeben wurde
    if (widget.butterflyId != null) {
      setState(() => _loading = true);
      try {
        final b = await RetrievalService.getButterfly(widget.butterflyId!);
        if (mounted) setState(() => _butterfly = b);
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Konnte Butterfly nicht laden: $e")),
        );
      } finally {
        if (mounted) setState(() => _loading = false);
      }
    }
  }

  /// Bildquelle für das Header-Bild ermitteln (File oder Netzwerk)
  Widget _buildHeaderImage(String imagePathOrUrl) {
    final isNetwork = imagePathOrUrl.startsWith("http");
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: isNetwork
          ? Image.network(
              imagePathOrUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const Center(child: Icon(Icons.broken_image)),
            )
          : Image.file(
              File(imagePathOrUrl),
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const Center(child: Icon(Icons.broken_image)),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    // 1) Datenquelle priorisieren:
    //    - Wenn finding übergeben wurde → nutze es.
    //    - Sonst, wenn butterfly geladen wurde (fromUpload) → baue ein "synthetisches" Finding für die Anzeige.
    //    - Sonst, wenn imageFile vorhanden → baue Demo-Finding (dein altes Verhalten).
    final Finding current = widget.finding ??
        (() {
          if (_butterfly != null && widget.imageUrl != null) {
            return Finding(
              id: const Uuid().v4(),
              imagePath: widget.imageUrl!,
              name: _butterfly!.commonName,
              description: _butterfly!.description ?? "",
              reproduction: _butterfly!.reproduction ?? "",
            );
          }
          if (widget.imageFile != null) {
            return Finding(
              id: const Uuid().v4(),
              imagePath: widget.imageFile!.path,
              name: "Unbekannter Falter",
              description: "Neues Foto – wähle später den korrekten Falter.",
              reproduction: "",
            );
          }
          // Fallback
          return Finding(
            id: const Uuid().v4(),
            imagePath: "",
            name: "Schmetterling",
            description: "",
            reproduction: "",
          );
        }());

    final bool showSaveButton = widget.imageFile != null; // nur bei neuer Aufnahme
    final String headerPathOrUrl = current.imagePath;

    return Scaffold(
      appBar: AppBar(title: const Text("Erkanntes Foto")),
      body: Stack(
        children: [
          DecoratedBox(
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
                  // Header mit File/URL
                  _HeaderFrame(child: _buildHeaderImage(headerPathOrUrl)),
                  const SizedBox(height: 20),

                  // Titel + Beschreibung
                  Text(
                    current.name,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 8),
                  Text(current.description, style: Theme.of(context).textTheme.bodyMedium),

                  const SizedBox(height: 16),

                  // Info-Chips – hier ein paar Beispiele, du kannst _butterfly nutzen wenn vorhanden
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      if (_butterfly?.season != null)
                        _InfoChip(icon: Icons.stacked_line_chart, label: "Flugsaison: ${_butterfly!.season}"),
                      if (_butterfly?.wingspanMinMm != null && _butterfly?.wingspanMaxMm != null)
                        _InfoChip(
                          icon: Icons.straighten,
                          label: "Spannweite: ~${_butterfly!.wingspanMinMm}-${_butterfly!.wingspanMaxMm} mm",
                        ),
                      if (_butterfly?.habitat != null)
                        _InfoChip(icon: Icons.park, label: "Lebensraum: ${_butterfly!.habitat}"),
                    ],
                  ),

                  const SizedBox(height: 20),

                  _InfoCard(
                    title: "Vermehrung",
                    leading: Icons.change_circle_outlined,
                    children: [
                      _Bullet(_butterfly?.reproduction ?? current.reproduction),
                    ],
                  ),
                ],
              ),
            ),
          ),

          if (_loading)
            const Positioned.fill(
              child: ColoredBox(
                color: Color(0x33000000),
                child: Center(child: CircularProgressIndicator()),
              ),
            ),
        ],
      ),

      // Speichern-Button nur für neue Fotos (wenn imageFile != null)
      bottomNavigationBar: showSaveButton
          ? SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                child: SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                    ),
                    onPressed: () async {
                      // Beispielwerte – später mit echter Auswahl/Erkennung ersetzen:
                      final int userId = 1;
                      final int butterflyId = widget.butterflyId ?? 42;
                      const double lat = 48.1372;
                      const double lon = 11.5756;

                      try {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (_) => const Center(child: CircularProgressIndicator()),
                        );

                        final file = widget.imageFile!;
                        final result = await UploadService.uploadPhoto(
                          file: file,
                          userId: userId,
                          butterflyId: butterflyId,
                          latitude: lat,
                          longitude: lon,
                        );

                        if (mounted) Navigator.pop(context); // Loading schließen
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Upload ok! URL: ${result.imageUrl}")),
                          );
                          Navigator.pop(context);
                        }
                      } catch (e) {
                        if (mounted) Navigator.pop(context); // Loading schließen
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Upload fehlgeschlagen: $e")),
                          );
                        }
                      }
                    },
                    icon: const Icon(Icons.bookmark_added),
                    label: const Text("Fund speichern"),
                  ),
                ),
              ),
            )
          : null,
    );
  }
}

class _HeaderFrame extends StatelessWidget {
  final Widget child;
  const _HeaderFrame({required this.child});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: scheme.primary.withOpacity(0.15),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            child,
            Positioned.fill(
              child: IgnorePointer(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.transparent, Colors.black.withOpacity(0.15)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: scheme.primary.withOpacity(0.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: scheme.primary.withOpacity(0.25)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: scheme.primary),
          const SizedBox(width: 6),
          Text(label, style: TextStyle(color: scheme.onSurface)),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final IconData leading;
  final List<Widget> children;

  const _InfoCard({
    required this.title,
    required this.leading,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      elevation: 0,
      color: scheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Icon(leading, color: scheme.primary),
              const SizedBox(width: 10),
              Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
            ]),
            const SizedBox(height: 8),
            ...children,
          ],
        ),
      ),
    );
  }
}

class _Bullet extends StatelessWidget {
  final String text;
  const _Bullet(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("•  "),
          Expanded(child: Text("")),
        ],
      ),
    );
  }
}
