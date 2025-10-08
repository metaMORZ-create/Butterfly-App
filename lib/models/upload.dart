
class UploadResult {
  final int id;
  final String imageUrl;
  final String publicId;
  final DateTime takenAt;
  final double latitude;
  final double longitude;

  UploadResult({
    required this.id,
    required this.imageUrl,
    required this.publicId,
    required this.takenAt,
    required this.latitude,
    required this.longitude,
  });

  factory UploadResult.fromJson(Map<String, dynamic> j) => UploadResult(
    id: j['id'] as int,
    imageUrl: j['image_url'] as String,
    publicId: j['public_id'] as String,
    takenAt: DateTime.parse(j['taken_at'] as String),
    latitude: (j['latitude'] as num).toDouble(),
    longitude: (j['longitude'] as num).toDouble(),
  );
}