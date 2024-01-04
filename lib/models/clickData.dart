class ClickData {
  final int totalBooks;
  final int clicked;
  final int notClicked;

  ClickData(
      {required this.totalBooks,
      required this.clicked,
      required this.notClicked});

  factory ClickData.fromJson(Map<String, dynamic> json) {
    return ClickData(
      totalBooks: json['TotalBooks'],
      clicked: json['Clicked'],
      notClicked: json['NotClicked'],
    );
  }
}
