class Album {
  final int id;
  final int userId;
  final String title;
  final String body;

  Album({required this.id, required this.userId, required this.title, required this.body});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'] ?? 0,
      userId: json['userId'] ?? 0,
      title: json['title'] ?? "",
      body: json['body'] ?? "",
    );
  }
}