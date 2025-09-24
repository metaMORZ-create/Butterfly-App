import 'dart:io';
import 'package:butterfly_app/models/findings.dart';
import 'package:butterfly_app/pages/finding_result_page.dart';
import 'package:butterfly_app/services/finding_service.dart';
import 'package:flutter/material.dart';

class MyButterfliesPage extends StatefulWidget {
  const MyButterfliesPage({super.key});

  @override
  State<MyButterfliesPage> createState() => _MyButterfliesPageState();
}

class _MyButterfliesPageState extends State<MyButterfliesPage> {
  List<Finding> _findings = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final list = await FindingService.loadFindings();
    if (!mounted) return;
    setState(() {
      _findings = list.reversed.toList(); // neueste zuerst
      _loading = false;
    });
  }

  void _openFinding(Finding f) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FindingResultPage.fromFinding(finding: f),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Meine Schmetterlinge')),
      body:
          _loading
              ? const Center(child: CircularProgressIndicator())
              : _findings.isEmpty
              ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.bug_report, size: 64, color: scheme.primary),
                      const SizedBox(height: 12),
                      Text(
                        'Noch keine Funde',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Nimm ein Foto im Kamerabereich auf, um deinen ersten Fund zu speichern.',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              )
              : RefreshIndicator(
                onRefresh: _load,
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: _findings.length,
                  itemBuilder: (context, i) {
                    final f = _findings[i];
                    return _FindingTile(
                      finding: f,
                      onTap: () => _openFinding(f),
                    );
                  },
                ),
              ),
    );
  }
}

class _FindingTile extends StatelessWidget {
  final Finding finding;
  final VoidCallback onTap;

  const _FindingTile({required this.finding, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final file = File(finding.imagePath);

    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.file(
                file,
                fit: BoxFit.cover,
                errorBuilder:
                    (_, __, ___) => Container(
                      color: Theme.of(context).colorScheme.surfaceVariant,
                      child: const Center(child: Icon(Icons.broken_image)),
                    ),
              ),
            ),
            Positioned(
              left: 8,
              right: 8,
              bottom: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.45),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  finding.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
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
