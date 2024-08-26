class Genre {
  final int id;
  final String name;
  final String imageUrl;

  Genre({required this.id, required this.name, required this.imageUrl});

  factory Genre.fromJson(Map<String, dynamic> json, String imageUrl) {
    return Genre(
      id: json['id'],
      name: json['name'],
      imageUrl: imageUrl,
    );
  }
}
