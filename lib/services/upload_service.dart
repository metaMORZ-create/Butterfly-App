import 'dart:convert';
import 'dart:io';
import 'package:butterfly_app/models/upload.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart' as p;

const String kApiBase = "https://web-production-97da3.up.railway.app";

class UploadService {
  /// Lädt ein Bild + Metadaten zu deinem FastAPI-/uploads-Endpoint hoch.
  static Future<UploadResult> uploadPhoto({
    required File file,
    required int userId,
    required int butterflyId,
    required double latitude,
    required double longitude,
    DateTime? takenAt, // default: now (UTC)
  }) async {
    final uri = Uri.parse("$kApiBase/uploads");
    final request = http.MultipartRequest('POST', uri);

    // --- Felder ---
    request.fields['user_id'] = userId.toString();
    request.fields['butterfly_id'] = butterflyId.toString();
    request.fields['taken_at'] = (takenAt ?? DateTime.now().toUtc()).toIso8601String();
    request.fields['latitude'] = latitude.toString();
    request.fields['longitude'] = longitude.toString();

    // --- MIME-Typ sauber bestimmen (wichtig gegen 415) ---
    // 1) Dateiname mit Endung sicherstellen
    String filename = p.basename(file.path);
    if (!filename.contains('.')) {
      // falls image_picker mal ohne Endung liefert
      filename = "$filename.jpg";
    }

    // 2) MIME-Type ermitteln (mit Header-Bytes als Fallback)
    final bytes = await file.openRead(0, 64).fold<List<int>>([], (b, d) => b..addAll(d));
    final mimeType = lookupMimeType(file.path, headerBytes: bytes) ?? 'image/jpeg';
    final mediaType = MediaType.parse(mimeType);

    // --- Datei-Part hinzufügen inkl. contentType ---
    request.files.add(
      await http.MultipartFile.fromPath(
        'file',
        file.path,
        filename: filename,
        contentType: mediaType,
      ),
    );

    // --- Request senden ---
    final streamed = await request.send().timeout(const Duration(seconds: 30));
    final resp = await http.Response.fromStream(streamed);

    if (resp.statusCode < 200 || resp.statusCode >= 300) {
      throw HttpException("Upload failed (${resp.statusCode}): ${resp.body}");
    }

    final data = json.decode(resp.body) as Map<String, dynamic>;
    return UploadResult.fromJson(data);
  }
}
