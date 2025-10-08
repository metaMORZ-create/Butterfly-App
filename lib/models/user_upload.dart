class ButterflyLite {
  final int id;
  final String commonName;
  final String? scientificName;
  final String? description;
  final String? reproduction;
  final String? habitat;
  final String? season;
  final int? wingspanMinMm;
  final int? wingspanMaxMm;
  final String? imageUrl;
  final String? thumbnailUrl;

  ButterflyLite({
    required this.id,
    required this.commonName,
    this.scientificName,
    this.description,
    this.reproduction,
    this.habitat,
    this.season,
    this.wingspanMinMm,
    this.wingspanMaxMm,
    this.imageUrl,
    this.thumbnailUrl,
  });

  factory ButterflyLite.fromJson(Map<String, dynamic> j) => ButterflyLite(
        id: j['id'] as int,
        commonName: j['common_name'] as String,
        scientificName: j['scientific_name'] as String?,
        description: j['description'] as String?,
        reproduction: j['reproduction'] as String?,
        habitat: j['habitat'] as String?,
        season: j['season'] as String?,
        wingspanMinMm: j['wingspan_min_mm'] as int?,
        wingspanMaxMm: j['wingspan_max_mm'] as int?,
        imageUrl: j['image_url'] as String?,
        thumbnailUrl: j['thumbnail_url'] as String?,
      );
}

class UserUpload {
  final int id;
  final int userId;
  final int butterflyId;
  final String imageUrl;
  final String publicId;
  final DateTime takenAt;
  final double latitude;
  final double longitude;
  final ButterflyLite? butterfly; // nur vorhanden, wenn with_butterfly=true

  UserUpload({
    required this.id,
    required this.userId,
    required this.butterflyId,
    required this.imageUrl,
    required this.publicId,
    required this.takenAt,
    required this.latitude,
    required this.longitude,
    this.butterfly,
  });

  factory UserUpload.fromJson(Map<String, dynamic> j) => UserUpload(
        id: j['id'] as int,
        userId: j['user_id'] as int,
        butterflyId: j['butterfly_id'] as int,
        imageUrl: j['image_url'] as String,
        publicId: j['public_id'] as String,
        takenAt: DateTime.parse(j['taken_at'] as String),
        latitude: (j['latitude'] as num).toDouble(),
        longitude: (j['longitude'] as num).toDouble(),
        butterfly: j['butterfly'] != null
            ? ButterflyLite.fromJson(j['butterfly'] as Map<String, dynamic>)
            : null,
      );
}
