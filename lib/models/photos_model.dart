class Photos {
  final int id;
  final int albumId;
  final String title;
  final String url;
  final String thumbnailUrl;

  Photos({
    required this.id,
    required this.albumId,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  factory Photos.fromJson(Map<String, dynamic> json) {
    return Photos(
      id: json['id'] ?? 0,
      albumId: json['albumId'] ?? 0,
      title: json['title'] ?? "",
      url: json['url'] ?? "",
      thumbnailUrl: json['thumbnailUrl'] ?? "",
    );
  }
}