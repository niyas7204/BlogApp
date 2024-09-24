class Blog {
  final String userId;
  final String blogId;
  final String tittle;
  final String content;
  final List<String> topics;
  final String imageUrl;
  final DateTime updatedAt;
  final String? blogName;
  Blog(
      {required this.userId,
      required this.blogId,
      required this.tittle,
      required this.content,
      required this.topics,
      required this.imageUrl,
      required this.updatedAt,
      this.blogName});
}
