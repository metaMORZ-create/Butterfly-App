import 'package:butterfly_app/components/my_butterflies/empty_state.dart';
import 'package:butterfly_app/components/my_butterflies/uploads_grid.dart';
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
      final id = prefs.getInt('user_id'); // <- dein gespeicherter Key

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
        withButterfly: true, // Butterfly-Daten gleich mitladen
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

    final finding = Finding(
      id: const Uuid().v4(),
      imagePath: it.imageUrl, // URL (Cloudinary)
      name: name,
      description: desc,
      reproduction: repro,
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
    return Scaffold(
      appBar: AppBar(title: const Text('Meine Schmetterlinge')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _uploads.isEmpty
              ? const MyButterfliesEmptyState()
              : MyButterfliesUploadsGrid(
                  uploads: _uploads,
                  onRefresh: _load,
                  onTapUpload: _openUpload,
                ),
    );
  }
}
