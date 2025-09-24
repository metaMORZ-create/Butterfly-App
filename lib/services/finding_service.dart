import 'dart:convert';
import 'package:butterfly_app/models/findings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FindingService {
  static const _key = 'findings';

  /// Alle gespeicherten Funde laden
  static Future<List<Finding>> loadFindings() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_key) ?? [];
    return raw.map((e) => Finding.fromJson(jsonDecode(e))).toList();
  }

  /// Neuen Fund speichern
  static Future<void> saveFinding(Finding finding) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_key) ?? [];
    raw.add(jsonEncode(finding.toJson()));
    await prefs.setStringList(_key, raw);
  }
}
