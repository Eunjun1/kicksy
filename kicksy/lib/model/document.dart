class Document {
  final int code;
  final String propser;
  final String title;
  final String contents;
  final DateTime date;

  Document({
    required this.code,
    required this.propser,
    required this.title,
    required this.contents,
    required this.date,
  });

  Document.fromMap(Map<String, dynamic> res)
  : code = res['code'],
  propser = res['propser'],
  title = res['title'],
  contents = res['contents'],
  date = res['date'];
}

//code integer primary key autoincrement, propser text, title text, contents text, date date