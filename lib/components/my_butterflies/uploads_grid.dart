import 'package:flutter/material.dart';
import 'package:butterfly_app/models/user_upload.dart';
import 'upload_tile.dart';

class MyButterfliesUploadsGrid extends StatelessWidget {
  final List<UserUpload> uploads;
  final Future<void> Function() onRefresh;
  final void Function(UserUpload) onTapUpload;

  const MyButterfliesUploadsGrid({
    super.key,
    required this.uploads,
    required this.onRefresh,
    required this.onTapUpload,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.95,
        ),
        itemCount: uploads.length,
        itemBuilder: (context, i) {
          final it = uploads[i];
          final title = it.butterfly?.commonName ?? "Butterfly";
          final thumb = it.butterfly?.thumbnailUrl ?? it.imageUrl;

          return MyButterfliesUploadTile(
            title: title,
            imageUrl: thumb,
            onTap: () => onTapUpload(it),
          );
        },
      ),
    );
  }
}
