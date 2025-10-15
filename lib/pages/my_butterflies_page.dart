import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:butterfly_app/components/my_butterflies/empty_state.dart';
import 'package:butterfly_app/components/my_butterflies/uploads_grid.dart';
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
      final id = prefs.getInt('user_id');
      if (!mounted) return;
      if (id == null) {
        setState(() => _loading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("No User ID found. Please log in.")),
        );
        return;
      }
      setState(() => _userId = id);
      await _load();
    } catch (e) {
      if (!mounted) return;
      setState(() => _loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error while Loading User ID: $e")),
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
        withButterfly: true,
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
        SnackBar(content: Text("Error while loading: $e")),
      );
    }
  }

  void _openUpload(UserUpload it) {
    // ID des Falters aus dem Upload-Modell holen (anpassen, falls Feld anders heißt)
    final id = it.butterfly?.id ?? it.butterflyId;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FindingResultPage(
          butterflyId: id,
          imageUrl: it.imageUrl,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Butterflies')),
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
