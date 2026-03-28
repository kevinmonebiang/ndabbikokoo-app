class Announcement {
  const Announcement({
    required this.title,
    required this.category,
    required this.message,
    required this.publishedOn,
    this.highlighted = false,
  });

  final String title;
  final String category;
  final String message;
  final DateTime publishedOn;
  final bool highlighted;
}

