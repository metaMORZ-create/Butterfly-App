import 'package:flutter/material.dart';
import 'package:butterfly_app/pages/finding_result_page.dart';
import 'package:butterfly_app/services/retrieval_service.dart';
// Annahme: ButterflyLite ist in demselben Modell wie UserUpload definiert.
// Wenn du ein separates Modell hast, den Import entsprechend anpassen:
import 'package:butterfly_app/models/user_upload.dart';

class ButterflyCatalogPage extends StatefulWidget {
  const ButterflyCatalogPage({super.key});

  @override
  State<ButterflyCatalogPage> createState() => _ButterflyCatalogPageState();
}

class _ButterflyCatalogPageState extends State<ButterflyCatalogPage> {
  bool _loading = true;
  String? _error;
  List<ButterflyLite> _items = [];

  @override
  void initState() {
    super.initState();
    _loadCatalog();
  }

  Future<void> _loadCatalog() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final items = await RetrievalService.getButterflyCatalog(
        limit: 500,  // ggf. erhöhen oder paginieren
        offset: 0,
      );
      if (!mounted) return;
      setState(() {
        _items = items;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _error = 'Katalog konnte nicht geladen werden: $e';
      });
    }
  }

  void _openButterfly(ButterflyLite it) {
    final id = it.id;
    final imageUrl = it.imageUrl ?? it.thumbnailUrl ?? "https://www.shutterstock.com/image-vector/default-ui-image-placeholder-wireframes-600nw-1037719192.jpg; // was vorhanden ist";
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FindingResultPage(
          butterflyId: id,
          imageUrl: imageUrl,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final body = _buildBody(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Butterfly Catalog')),
      body: RefreshIndicator(
        onRefresh: _loadCatalog,
        child: body,
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null) {
      return ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Icon(Icons.error_outline, color: Colors.redAccent),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        _error!,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                    IconButton(
                      tooltip: 'Neu laden',
                      onPressed: _loadCatalog,
                      icon: const Icon(Icons.refresh),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    }
    if (_items.isEmpty) {
      return ListView(
        children: const [
          SizedBox(height: 80),
          Center(
            child: Text(
              'Noch keine Arten im Katalog.',
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      );
    }
    return _CatalogGrid(
      items: _items,
      onTap: _openButterfly,
    );
  }
}

class _CatalogGrid extends StatelessWidget {
  final List<ButterflyLite> items;
  final void Function(ButterflyLite) onTap;

  const _CatalogGrid({
    required this.items,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    // einfache Responsive-Logik
    final crossAxisCount = width >= 1100
        ? 5
        : width >= 900
            ? 4
            : width >= 650
                ? 3
                : 2;

    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.78,
      ),
      itemCount: items.length,
      itemBuilder: (context, i) {
        final it = items[i];
        return _CatalogTile(
          item: it,
          onTap: () => onTap(it),
        );
      },
    );
  }
}

class _CatalogTile extends StatelessWidget {
  final ButterflyLite item;
  final VoidCallback onTap;

  const _CatalogTile({
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final title = item.commonName;
    final subtitle = item.scientificName ?? '';
    final imageUrl = item.thumbnailUrl ?? item.imageUrl;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 1,
        child: Column(
          children: [
            // Bild
            AspectRatio(
              aspectRatio: 16 / 10,
              child: imageUrl != null && imageUrl.isNotEmpty
                  ? Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _ImagePlaceholderIcon(scheme: scheme),
                      loadingBuilder: (ctx, child, progress) {
                        if (progress == null) return child;
                        return const Center(child: CircularProgressIndicator(strokeWidth: 2));
                      },
                    )
                  : _ImagePlaceholderIcon(scheme: scheme),
            ),
            // Text
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Common name
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(height: 4),
                  // Scientific name
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[700],
                          fontStyle: FontStyle.italic,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ImagePlaceholderIcon extends StatelessWidget {
  final ColorScheme scheme;
  const _ImagePlaceholderIcon({required this.scheme});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: scheme.surfaceContainerHighest.withOpacity(0.4),
      child: Icon(
        Icons.image_outlined,
        size: 48,
        color: scheme.primary.withOpacity(0.5),
      ),
    );
    }
}
