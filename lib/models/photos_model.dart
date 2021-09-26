class Photos {
  final int id;
  final int albumId;
  final String title;
  final String url;
  final String thumbnailUrl;
  final bool networkImage;

  Photos({
    required this.id,
    required this.albumId,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
    required this.networkImage,
  });

  factory Photos.fromJson(Map<String, dynamic> json) {
    return Photos(
      id: json['id'] ?? 0,
      albumId: json['albumId'] ?? 0,
      title: json['title'] ?? "",
      url: json['url'] ?? "",
      thumbnailUrl: json['thumbnailUrl'] ?? "",
      networkImage: true,
    );
  }
}