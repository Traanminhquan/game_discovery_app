class Game {
  final int id;
  final String title;
  final String thumbnail;
  final String shortDescription;
  final String description;
  final String genre;
  final String platform;
  final String publisher;
  final String developer;
  final String releaseDate;
  final List<String> screenshots;

  Game({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.shortDescription,
    required this.description,
    required this.genre,
    required this.platform,
    required this.publisher,
    required this.developer,
    required this.releaseDate,
    required this.screenshots,
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    final screenshotList = json['screenshots'] as List<dynamic>?;

    return Game(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
      shortDescription: json['short_description'] ?? '',
      description: json['description'] ?? '',
      genre: json['genre'] ?? '',
      platform: json['platform'] ?? '',
      publisher: json['publisher'] ?? '',
      developer: json['developer'] ?? '',
      releaseDate: json['release_date'] ?? '',
      screenshots: screenshotList
              ?.map((item) => item['image']?.toString() ?? '')
              .where((url) => url.isNotEmpty)
              .toList() ??
          [],
    );
  }
}