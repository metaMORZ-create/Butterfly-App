// lib/features/camera/finding_result_page.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

// passe diese Importe an dein Projekt an:
import 'package:butterfly_app/models/findings.dart';
import 'package:butterfly_app/services/finding_service.dart';

class FindingResultPage extends StatelessWidget {
  final File? imageFile;  // wenn neu fotografiert
  final Finding? finding; // wenn aus "Meine Schmetterlinge" geöffnet

  const FindingResultPage({super.key, required this.imageFile}) : finding = null;
  const FindingResultPage.fromFinding({super.key, required this.finding}) : imageFile = null;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    // Demo-Fallback, wenn von der Kamera kommend
    final current = finding ??
        Finding(
          id: const Uuid().v4(),
          imagePath: imageFile!.path,
          name: "Monarchfalter",
          description: "Ein bekannter Wanderfalter mit orange-schwarzen Flügeln.",
          reproduction: "Ei → Raupe → Puppe → Falter",
          // Du kannst dein Modell gern um weitere Felder erweitern
        );

    return Scaffold(
      appBar: AppBar(title: const Text("Erkanntes Foto")),
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
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 100), // unten Platz für den Button
            children: [
              _HeaderImage(imagePath: current.imagePath),
              const SizedBox(height: 20),

              // Titel + Untertitel
              Text(
                current.name,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                current.description,
                style: Theme.of(context).textTheme.bodyMedium,
              ),

              const SizedBox(height: 16),

              // Info-Chips
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _InfoChip(icon: Icons.eco, label: "Nektartrinker"),
                  _InfoChip(icon: Icons.park, label: "Lebensraum: Wiesen"),
                  _InfoChip(icon: Icons.stacked_line_chart, label: "Flugsaison: Mai–Sep"),
                  _InfoChip(icon: Icons.straighten, label: "Spannweite: ~95–105 mm"),
                ],
              ),

              const SizedBox(height: 20),

              // Karten mit Details
              _InfoCard(
                title: "Vermehrung",
                leading: Icons.change_circle_outlined,
                children: [
                  _Bullet("Ei – an Wirtspflanzen abgelegt"),
                  _Bullet("Raupe – mehrere Häutungen"),
                  _Bullet("Puppe – Metamorphose"),
                  _Bullet("Falter – Lebensdauer wenige Wochen"),
                ],
              ),
              const SizedBox(height: 12),
              _InfoCard(
                title: "Hinweise zur Beobachtung",
                leading: Icons.visibility_outlined,
                children: [
                  _Bullet("Aktiv bei warmem, sonnigem Wetter"),
                  _Bullet("Bevorzugt Disteln, Seidenpflanzen & Buddleja"),
                  _Bullet("Nicht stören – Fotos aus ~1–2 m Entfernung"),
                ],
              ),
            ],
          ),
        ),
      ),

      // Sticky Save-Button
      bottomNavigationBar: finding == null
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
                      await FindingService.saveFinding(current);
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
            )
          : null,
    );
  }
}

class _HeaderImage extends StatelessWidget {
  final String imagePath;
  const _HeaderImage({required this.imagePath});

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
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.file(
                File(imagePath),
                fit: BoxFit.cover,
              ),
            ),
            // leichte Gradient-Overlay unten für Lesbarkeit
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
            // Demo-Badge (z. B. „Erkannt (Demo)“)
            Positioned(
              left: 12,
              top: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: scheme.primary.withOpacity(0.85),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.auto_awesome, size: 16, color: Colors.white),
                    SizedBox(width: 6),
                    Text("Erkannt (Demo)", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                  ],
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

  const _InfoCard({required this.title, required this.leading, required this.children});

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
        children: [
          const Text("•  "),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
