class Book {
  final String? _id; // _id is now nullable
  final String title;
  final String description;
  final String link;
  final String createdAt;
  final int clicked;

  // Main constructor with nullable _id parameter
  Book(this._id, this.title, this.description, this.link, this.createdAt,
      this.clicked);

  String? get id => _id;

  // Named constructor without _id parameter
  Book.fromJson(Map<String, dynamic> json)
      : _id = json['_id'],
        title = json['title'],
        description = json['description'],
        link = json['link'],
        createdAt = json['createdAt'],
        clicked = json['clicked'];

  // Convert to json
  Map<String, dynamic> toJson() => {
        if (_id != null) '_id': _id, // Only add _id if not null
        'title': title,
        'description': description,
        'link': link,
        'createdAt': createdAt,
        'clicked': clicked,
      };
}
