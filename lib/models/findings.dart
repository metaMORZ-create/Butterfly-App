class Finding {
  final String id;
  final String imagePath; // aufgenommenes Bild (lokal)
  final String name;
  final String description;
  final String reproduction; // „Vermehrung“

  Finding({
    required this.id,
    required this.imagePath,
    required this.name,
    required this.description,
    required this.reproduction,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'imagePath': imagePath,
        'name': name,
        'description': description,
        'reproduction': reproduction,
      };

  factory Finding.fromJson(Map<String, dynamic> json) => Finding(
        id: json['id'],
        imagePath: json['imagePath'],
        name: json['name'],
        description: json['description'],
        reproduction: json['reproduction'],
      );
}
