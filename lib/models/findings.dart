// lib/models/findings.dart
class Finding {
  final String id;            // lokal generiert (UUID)
  final String imagePath;     // lokaler Datei-Pfad (bei frischen Funden)
  final String name;
  final String description;
  final String reproduction;

  // 🆕 Remote-Felder (optional)
  final int? remoteId;        // ID aus der API (Postgres)
  final String? imageUrl;     // Bild-URL aus der API
  final int? userId;          // für Uploads

  Finding({
    required this.id,
    required this.imagePath,
    required this.name,
    required this.description,
    required this.reproduction,
    this.remoteId,
    this.imageUrl,
    this.userId,
  });

  factory Finding.fromJson(Map<String, dynamic> j) => Finding(
        id: j['id'],
        imagePath: j['imagePath'],
        name: j['name'],
        description: j['description'],
        reproduction: j['reproduction'],
        remoteId: j['remoteId'],
        imageUrl: j['imageUrl'],
        userId: j['userId'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'imagePath': imagePath,
        'name': name,
        'description': description,
        'reproduction': reproduction,
        'remoteId': remoteId,
        'imageUrl': imageUrl,
        'userId': userId,
      };

  //  Helper: Kopie mit Änderungen
  Finding copyWith({
    String? id,
    String? imagePath,
    String? name,
    String? description,
    String? reproduction,
    int? remoteId,
    String? imageUrl,
    int? userId,
  }) {
    return Finding(
      id: id ?? this.id,
      imagePath: imagePath ?? this.imagePath,
      name: name ?? this.name,
      description: description ?? this.description,
      reproduction: reproduction ?? this.reproduction,
      remoteId: remoteId ?? this.remoteId,
      imageUrl: imageUrl ?? this.imageUrl,
      userId: userId ?? this.userId,
    );
  }
}
