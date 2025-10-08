import 'dart:convert';
import 'dart:io';
import 'package:butterfly_app/models/upload.dart';
import 'package:http/http.dart' as http;

/// Passe das an: lokal, Emulator oder Railway
/// Android-Emulator: 10.0.2.2, iOS-Simulator: localhost
const String kApiBase = "https://web-production-97da3.up.railway.app"; // z.B. "https://dein-projekt.up.railway.app"



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

    // Felder
    request.fields['user_id'] = userId.toString();
    request.fields['butterfly_id'] = butterflyId.toString();
    request.fields['taken_at'] = (takenAt ?? DateTime.now().toUtc()).toIso8601String();
    request.fields['latitude'] = latitude.toString();
    request.fields['longitude'] = longitude.toString();

    // Datei
    request.files.add(await http.MultipartFile.fromPath('file', file.path));

    final streamed = await request.send();
    final resp = await http.Response.fromStream(streamed);

    if (resp.statusCode != 200) {
      throw HttpException("Upload failed (${resp.statusCode}): ${resp.body}");
    }
    final data = json.decode(resp.body) as Map<String, dynamic>;
    return UploadResult.fromJson(data);
  }
}
