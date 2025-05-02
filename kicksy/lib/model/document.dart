class Document {
  final int code;
  final String propser;
  final String title;
  final String contents;
  final DateTime date;
  final int type;
  final String grade;

  Document({
    required this.code,
    required this.propser,
    required this.title,
    required this.contents,
    required this.date,
    required this.type,
    required this.grade
  });

  Document.fromMap(Map<String, dynamic> res)
  : code = res['code'],
  propser = res['propser'],
  title = res['title'],
  contents = res['contents'],
  date = res['date'],
  type = res['type'],
  grade = res['grade'];
}
