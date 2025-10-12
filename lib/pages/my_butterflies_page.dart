import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import 'package:butterfly_app/models/findings.dart';
import 'package:butterfly_app/pages/finding_result_page.dart';
import 'package:butterfly_app/services/retrieval_service.dart';
import 'package:butterfly_app/models/user_upload.dart';

class MyButterfliesPage extends StatefulWidget {
  const MyButterfliesPage({super.key});

  @override
  State<MyButterfliesPage> createState() => _MyButterfliesPageState();
}

class _MyButterfliesPageState extends State<MyButterfliesPage> {
  bool _loading = true;
  int? _userId;
  List<UserUpload> _uploads = [];

  @override
  void initState() {
    super.initState();
    _loadUserIdAndData();
  }

  Future<void> _loadUserIdAndData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final id = prefs.getInt('userId');

      if (!mounted) return;

      if (id == null) {
        setState(() => _loading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Keine User-ID gefunden. Bitte neu einloggen.")),
        );
        return;
      }

      setState(() => _userId = id);
      await _load();
    } catch (e) {
      if (!mounted) return;
      setState(() => _loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Fehler beim Laden der User-ID: $e")),
      );
    }
  }

  Future<void> _load() async {
    if (_userId == null) return;

    try {
      final items = await RetrievalService.getUserUploads(
        userId: _userId!,
        limit: 100,
        sort: "desc",
        withButterfly: true, // damit kommt schon butterfly mit
      );
      if (!mounted) return;
      setState(() {
        _uploads = items;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Fehler beim Laden: $e")),
      );
    }
  }

  void _openUpload(UserUpload it) {
    final b = it.butterfly;
    final name = b?.commonName ?? "Schmetterling";
    final desc = b?.description ?? "";
    final repro = b?.reproduction ?? "";

    // Finding für deine bestehende FindingResultPage bauen
    final finding = Finding(
      id: const Uuid().v4(),
      imagePath: it.imageUrl, // URL von Cloudinary
      name: name,
      description: desc,
      reproduction: repro,
      // ggf. weitere Felder mappen
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FindingResultPage.fromFinding(finding: finding),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Meine Schmetterlinge')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _uploads.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.bug_report, size: 64, color: scheme.primary),
                        const SizedBox(height: 12),
                        Text('Noch keine Uploads',
                            style: Theme.of(context).textTheme.titleLarge),
                        const SizedBox(height: 6),
                        const Text(
                          'Fotografiere einen Falter und speichere ihn, um ihn hier zu sehen.',
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
                      childAspectRatio: 0.95,
                    ),
                    itemCount: _uploads.length,
                    itemBuilder: (context, i) {
                      final it = _uploads[i];
                      final title = it.butterfly?.commonName ?? "Schmetterling";
                      final thumb = it.butterfly?.thumbnailUrl ?? it.imageUrl;

                      return _Tile(
                        title: title,
                        imageUrl: thumb,
                        onTap: () => _openUpload(it),
                      );
                    },
                  ),
                ),
    );
  }
}

class _Tile extends StatelessWidget {
  final String title;
  final String imageUrl;
  final VoidCallback onTap;

  const _Tile({
    required this.title,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  child: const Center(child: Icon(Icons.broken_image)),
                ),
                loadingBuilder: (ctx, child, progress) =>
                    progress == null ? child : const Center(child: CircularProgressIndicator()),
              ),
            ),
            Positioned(
              left: 8, right: 8, bottom: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.45),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
