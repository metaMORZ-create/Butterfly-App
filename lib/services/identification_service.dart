import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart' as p;

const String kApiBase = "https://web-production-97da3.up.railway.app";

class IdentificationService {
  /// Sendet ein Bild an /api/predict und gibt NUR die Species (String) zurück.
  static Future<String> classifyPhoto({
    required File file,
  }) async {
    final uri = Uri.parse("$kApiBase/api/predict");
    final request = http.MultipartRequest('POST', uri);

    // saubere MIME-Erkennung
    String filename = p.basename(file.path);
    if (!filename.contains('.')) filename = "$filename.jpg";
    final headerBytes = await file.openRead(0, 64).fold<List<int>>([], (b, d) => b..addAll(d));
    final mime = lookupMimeType(file.path, headerBytes: headerBytes) ?? 'image/jpeg';

    request.files.add(await http.MultipartFile.fromPath(
      'file',
      file.path,
      filename: filename,
      contentType: MediaType.parse(mime),
    ));

    final streamed = await request.send().timeout(const Duration(seconds: 30));
    final resp = await http.Response.fromStream(streamed);

    if (resp.statusCode < 200 || resp.statusCode >= 300) {
      throw HttpException("Prediction failed (${resp.statusCode}): ${resp.body}");
    }

    final Map<String, dynamic> data = json.decode(resp.body) as Map<String, dynamic>;

    // Erwartetes Backend-Format: { "filename": "...", "species": "..." }
    final species = data['species'];
    if (species is String && species.trim().isNotEmpty) {
      return species;
    }
    // Falls das Backend anders antwortet, hier fallback/error:
    throw const FormatException("Response does not contain 'species' string");
  }
}
