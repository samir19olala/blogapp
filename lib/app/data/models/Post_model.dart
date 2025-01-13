class Post {
  final int id;
  final String title;
  final String content;
  final String category;
  final String coverImage;
  final String authorName;
  final String authorAvatar;
  final String authorUsername;
  final DateTime createdAt;
  final int likesCount;
  final int commentsCount;
  final int sharesCount;
  final bool isBookmarked;
  final int readTime;
  final String summary;

  Post({
    required this.id,
    required this.title,
    required this.content,
    required this.category,
    required this.coverImage,
    required this.authorName,
    required this.authorAvatar,
    required this.authorUsername,
    required this.createdAt,
    required this.likesCount,
    required this.commentsCount,
    required this.sharesCount,
    this.isBookmarked = false,
    required this.readTime,
    required this.summary,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      category: json['category'],
      coverImage: json['cover_image'],
      authorName: json['author_name'],
      authorAvatar: json['author_avatar'],
      authorUsername: json['author_username'],
      createdAt: DateTime.parse(json['created_at']),
      likesCount: json['likes_count'],
      commentsCount: json['comments_count'],
      sharesCount: json['shares_count'],
      isBookmarked: json['is_bookmarked'] ?? false,
      readTime: json['read_time'],
      summary: json['summary'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'category': category,
      'cover_image': coverImage,
      'author_name': authorName,
      'author_avatar': authorAvatar,
      'author_username': authorUsername,
      'created_at': createdAt.toIso8601String(),
      'likes_count': likesCount,
      'comments_count': commentsCount,
      'shares_count': sharesCount,
      'is_bookmarked': isBookmarked,
      'read_time': readTime,
      'summary': summary,
    };
  }
}
