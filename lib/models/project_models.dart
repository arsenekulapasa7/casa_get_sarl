class BlogPost {
  const BlogPost({
    required this.title,
    required this.excerpt,
    required this.category,
    required this.date,
    required this.readTime,
    this.imagePath = '',
  });

  final String title;
  final String excerpt;
  final String category;
  final String date;
  final String readTime;
  final String imagePath;
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
