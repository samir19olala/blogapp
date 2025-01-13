import '../models/post_model.dart';

class MockService {
  static List<Post> getMockPosts() {
    return [
      Post(
        id: 1,
        title: "Flutter 3.0: What's New and Exciting",
        content: """
Flutter 3.0 brings groundbreaking changes to the framework, including improved performance, 
new widgets, and better platform integration. This major release introduces stable support 
for macOS and Linux desktop apps, making Flutter a true cross-platform framework.

Key highlights include:
- Improved performance with a new rendering engine
- Enhanced Material You support
- New widgets for desktop platforms
- Better accessibility features
""",
        category: "Technology",
        coverImage: "https://picsum.photos/800/400?random=1",
        authorName: "Sarah Johnson",
        authorAvatar: "https://i.pravatar.cc/150?img=1",
        authorUsername: "@sarahj_tech",
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
        likesCount: 234,
        commentsCount: 45,
        sharesCount: 23,
        readTime: 5,
        summary:
            "Explore the latest features and improvements in Flutter 3.0, including desktop support and performance enhancements.",
      ),
      Post(
        id: 2,
        title: "The Future of Mobile Development",
        content: """
As we move into 2024, mobile development continues to evolve at a rapid pace. 
Cross-platform development tools are becoming more sophisticated, while native 
development is still holding strong for performance-critical applications.

Trends to watch:
1. AI-powered development tools
2. Cross-platform frameworks
3. Progressive Web Apps
4. 5G optimization
""",
        category: "Mobile",
        coverImage: "https://picsum.photos/800/400?random=2",
        authorName: "Mike Chen",
        authorAvatar: "https://i.pravatar.cc/150?img=2",
        authorUsername: "@mikechen_dev",
        createdAt: DateTime.now().subtract(const Duration(hours: 12)),
        likesCount: 156,
        commentsCount: 28,
        sharesCount: 15,
        readTime: 7,
        summary:
            "An in-depth look at mobile development trends and predictions for the coming year.",
      ),
      Post(
        id: 3,
        title: "Building Scalable APIs with Node.js",
        content: """
Creating scalable APIs is crucial for modern applications. This guide covers best 
practices for building robust APIs using Node.js and Express, including authentication, 
rate limiting, and caching strategies.

Topics covered:
- RESTful design principles
- Authentication and authorization
- Database optimization
- Error handling
- API documentation
""",
        category: "Backend",
        coverImage: "https://picsum.photos/800/400?random=3",
        authorName: "Alex Rivera",
        authorAvatar: "https://i.pravatar.cc/150?img=3",
        authorUsername: "@arivera_dev",
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        likesCount: 189,
        commentsCount: 32,
        sharesCount: 19,
        readTime: 10,
        summary:
            "Learn how to build production-ready APIs with Node.js, covering security, performance, and best practices.",
      ),
      Post(
        id: 4,
        title: "Building Scalable APIs with Node.js",
        content: """
Creating scalable APIs is crucial for modern applications. This guide covers best 
practices for building robust APIs using Node.js and Express, including authentication, 
rate limiting, and caching strategies.

Topics covered:
- RESTful design principles
- Authentication and authorization
- Database optimization
- Error handling
- API documentation
""",
        category: "Frontend",
        coverImage: "https://picsum.photos/800/400?random=4",
        authorName: "Alex Rivera",
        authorAvatar: "https://i.pravatar.cc/150?img=4",
        authorUsername: "@salir ",
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        likesCount: 889,
        commentsCount: 32,
        sharesCount: 19,
        readTime: 10,
        summary:
            "Learn how to build production-ready APIs with Node.js, covering security, performance, and best practices.",
      ),
      Post(
        id: 5,
        title: "Building Scalable APIs with Node.js",
        content: """
Creating scalable APIs is crucial for modern applications. This guide covers best 
practices for building robust APIs using Node.js and Express, including authentication, 
rate limiting, and caching strategies.

Topics covered:
- RESTful design principles
- Authentication and authorization
- Database optimization
- Error handling
- API documentation
""",
        category: "Mobile",
        coverImage: "https://picsum.photos/800/400?random=5",
        authorName: "Alex Rivera",
        authorAvatar: "https://i.pravatar.cc/150?img=5",
        authorUsername: "@arivera_dev",
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        likesCount: 189,
        commentsCount: 32,
        sharesCount: 19,
        readTime: 10,
        summary:
            "Learn how to build production-ready APIs with Node.js, covering security, performance, and best practices.",
      ),
      Post(
        id: 6,
        title: "Building Scalable APIs with Node.js",
        content: """
Creating scalable APIs is crucial for modern applications. This guide covers best 
practices for building robust APIs using Node.js and Express, including authentication, 
rate limiting, and caching strategies.

Topics covered:
- RESTful design principles
- Authentication and authorization
- Database optimization
- Error handling
- API documentation
""",
        category: "Backend",
        coverImage: "https://picsum.photos/800/400?random=6",
        authorName: "Alex Rivera",
        authorAvatar: "https://i.pravatar.cc/150?img=6sd",
        authorUsername: "@arivera_dev",
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        likesCount: 189,
        commentsCount: 32,
        sharesCount: 19,
        readTime: 10,
        summary:
            "Learn how to build production-ready APIs with Node.js, covering security, performance, and best practices.",
      ),
    ];
  }

  static List<String> getMockCategories() {
    return [
      'Technology',
      'Mobile',
      'Backend',
      'Frontend',
      'DevOps',
      'AI',
      'Cloud',
      'Security',
    ];
  }
}
