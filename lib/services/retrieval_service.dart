import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_upload.dart';

const String kApiBase = "https://web-production-97da3.up.railway.app";

/// Holt User-Uploads aus deiner FastAPI (kein Auth).
class RetrievalService {
  static Future<List<UserUpload>> getUserUploads({
    required int userId,
    int limit = 50,
    int offset = 0,
    String sort = "desc",      // "asc" | "desc"
    bool withButterfly = true, // wenn true: API liefert Butterfly-Infos mit
  }) async {
    final uri = Uri.parse(
      "$kApiBase/uploads/user/$userId"
      "?limit=$limit&offset=$offset&sort=$sort&with_butterfly=$withButterfly",
    );

    final res = await http.get(uri);
    if (res.statusCode != 200) {
      throw Exception("Fehler ${res.statusCode}: ${res.body}");
    }

    final map = json.decode(res.body) as Map<String, dynamic>;
    final items = (map["items"] as List<dynamic>? ?? []);
    return items.map((e) => UserUpload.fromJson(e as Map<String, dynamic>)).toList();
  }

  static Future<ButterflyLite> getButterfly(int id) async {
    final uri = Uri.parse("$kApiBase/butterflies/$id");
    final res = await http.get(uri);
    if (res.statusCode != 200) {
      throw Exception("Fehler ${res.statusCode}: ${res.body}");
    }
    final map = json.decode(res.body) as Map<String, dynamic>;
    return ButterflyLite.fromJson(map);
  }

    /// Holt den Artenkatalog (alle Butterflies) – optional paginiert.
  static Future<List<ButterflyLite>> getButterflyCatalog({
    int limit = 100,
    int offset = 0,
  }) async {
    // Pfad-Varianten (je nach API-Prefix)
    final candidates = <Uri>[
      Uri.parse("$kApiBase/butterflies/catalog?limit=$limit&offset=$offset"),
    ];

    Object? lastErr;
    for (final uri in candidates) {
      try {
        final res = await http.get(uri);
        if (res.statusCode != 200) {
          lastErr = Exception("Fehler ${res.statusCode}: ${res.body}");
          continue;
        }
        final map = json.decode(res.body) as Map<String, dynamic>;
        final items = (map["items"] as List<dynamic>? ?? []);
        return items
            .map((e) => ButterflyLite.fromJson(e as Map<String, dynamic>))
            .toList();
      } catch (e) {
        lastErr = e;
      }
    }
    throw Exception("Katalog konnte nicht geladen werden: $lastErr");
  }

}
