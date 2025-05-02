class Management {
  final int num;
  final int employeeCode;
  final int productCode;
  final int storeCode;
  final int type;
  final DateTime date;
  final int count;

  Management({
    required this.num,
    required this.employeeCode,
    required this.productCode,
    required this.storeCode,
    required this.type,
    required this.date,
    required this.count,
  });

  Management.fromMap(Map<String, dynamic> res)
  : num = res['num'],
  employeeCode = res['employee_code'],
  productCode = res['product_code'],
  storeCode = res['store_code'],
  type = res['type'],
  date = res['date'],
  count = res['count'];
}