import 'dart:io';
import 'package:butterfly_app/components/finding_page/bullet.dart';
import 'package:butterfly_app/components/finding_page/heading_image.dart';
import 'package:butterfly_app/components/finding_page/info_card.dart';
import 'package:butterfly_app/components/finding_page/info_chip.dart';
import 'package:butterfly_app/components/finding_page/save_finding_bar.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

// Passe diese Importe an dein Projekt an:
import 'package:butterfly_app/models/findings.dart';
import 'package:butterfly_app/services/finding_service.dart';


/// Zeigt das Ergebnis eines erkannten Schmetterlingsfotos.
/// Entweder durch ein neues Foto (`imageFile`) oder durch einen gespeicherten Fund (`finding`).
class FindingResultPage extends StatelessWidget {
  final File? imageFile;
  final Finding? finding;

  const FindingResultPage({super.key, required this.imageFile}) : finding = null;
  const FindingResultPage.fromFinding({super.key, required this.finding}) : imageFile = null;

  Finding _buildCurrentFinding() {
    if (finding != null) return finding!;
    return Finding(
      id: const Uuid().v4(),
      imagePath: imageFile!.path,
      name: "Monarchfalter",
      description: "Ein bekannter Wanderfalter mit orange-schwarzen Flügeln.",
      reproduction: "Ei → Raupe → Puppe → Falter",
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final current = _buildCurrentFinding();

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
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
            children: [
              HeaderImage(imagePath: current.imagePath),
              const SizedBox(height: 20),

              Text(
                current.name,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              Text(current.description,
                  style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 16),

              // Infochips
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: const [
                  InfoChip(icon: Icons.eco, label: "Nektartrinker"),
                  InfoChip(icon: Icons.park, label: "Lebensraum: Wiesen"),
                  InfoChip(
                      icon: Icons.stacked_line_chart,
                      label: "Flugsaison: Mai–Sep"),
                  InfoChip(
                      icon: Icons.straighten, label: "Spannweite: ~95–105 mm"),
                ],
              ),
              const SizedBox(height: 20),

              const InfoCard(
                title: "Vermehrung",
                leading: Icons.change_circle_outlined,
                children: [
                  Bullet("Ei – an Wirtspflanzen abgelegt"),
                  Bullet("Raupe – mehrere Häutungen"),
                  Bullet("Puppe – Metamorphose"),
                  Bullet("Falter – Lebensdauer wenige Wochen"),
                ],
              ),
              const SizedBox(height: 12),
              const InfoCard(
                title: "Hinweise zur Beobachtung",
                leading: Icons.visibility_outlined,
                children: [
                  Bullet("Aktiv bei warmem, sonnigem Wetter"),
                  Bullet("Bevorzugt Disteln, Seidenpflanzen & Buddleja"),
                  Bullet("Nicht stören – Fotos aus ~1–2 m Entfernung"),
                ],
              ),
            ],
          ),
        ),
      ),

      // Nur anzeigen, wenn neuer Fund
      bottomNavigationBar: finding == null
          ? SaveFindingBar(
              onSave: () async {
                await FindingService.saveFinding(current);
              },
            )
          : null,
    );
  }
}
