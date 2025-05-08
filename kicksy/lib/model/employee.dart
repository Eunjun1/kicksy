class Employee {
  final int code;
  final String pw;
  final String division;
  final String grade;

  Employee({
    required this.code,
    required this.pw,
    required this.division,
    required this.grade
  });

  Employee.fromMap(Map<String, dynamic> res)
    : code = res['emp_code'],
      pw = res['password'],
      division = res['division'],
      grade = res['grade'];

}