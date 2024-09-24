import 'package:cleanarchitecture/features/blog/domain/entity/blog.dart';

class BlogModel extends Blog {
  BlogModel(
      {required super.userId,
      required super.blogId,
      required super.tittle,
      required super.content,
      required super.topics,
      required super.imageUrl,
      required super.updatedAt,
      super.blogName});
  Map<String, dynamic> tojson() {
    return <String, dynamic>{
      'blog_id': blogId,
      'user_id': userId,
      'updated_at': updatedAt.toIso8601String(),
      'tittle': tittle,
      'content': content,
      'image_url': imageUrl,
      'topics': topics,
    };
  }

  factory BlogModel.fromJson(Map<String, dynamic> map) {
    return BlogModel(
      userId: map['blog_id'] as String,
      blogId: map['user_id'] as String,
      tittle: map['tittle'] as String,
      content: map['content'] as String,
      topics: List<String>.from(map['topics'] ?? []),
      imageUrl: map['image_url'] as String,
      updatedAt: map['updated_at'] == null
          ? DateTime.now()
          : DateTime.parse(map['updated_at']),
    );
  }
  BlogModel copyWith({
    String? userId,
    String? blogId,
    String? tittle,
    String? content,
    List<String>? topics,
    String? imageUrl,
    DateTime? updatedAt,
    String? blogName,
  }) {
    return BlogModel(
        userId: userId ?? this.userId,
        blogId: blogId ?? this.blogId,
        tittle: tittle ?? this.tittle,
        content: content ?? this.content,
        topics: topics ?? this.topics,
        imageUrl: imageUrl ?? this.imageUrl,
        updatedAt: updatedAt ?? this.updatedAt,
        blogName: blogName ?? this.blogName);
  }
}
