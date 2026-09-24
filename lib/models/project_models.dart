class BlogPost {
  const BlogPost({
    required this.title,
    required this.excerpt,
    required this.category,
    required this.date,
    required this.readTime,
    this.content = '',
    this.imagePath = '',
  });

  final String title;
  final String excerpt;
  final String category;
  final String date;
  final String readTime;
  final String content;
  final String imagePath;
}

class Project {
  const Project({
    required this.title,
    required this.summary,
    required this.description,
    required this.imagePath,
    this.gallery = const [],
  });

  final String title;
  final String summary;
  final String description;
  final String imagePath;
  final List<String> gallery;
}

class LeisureHighlight {
  const LeisureHighlight({
    required this.title,
    required this.description,
    required this.icon,
  });

  final String title;
  final String description;
  final String icon;
}
