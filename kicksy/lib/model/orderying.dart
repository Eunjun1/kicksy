class Orderying {
  final int num;
  final int employeeCode;
  final int productCode;
  final int documentCode;
  final int type;
  final DateTime date;
  final int count;
  final String rejectReason;

  Orderying({
    required this.num,
    required this.employeeCode,
    required this.productCode,
    required this.documentCode,
    required this.type,
    required this.date,
    required this.count,
    required this.rejectReason,
  });

  Orderying.fromMap(Map<String, dynamic> res)
  : num = res['num'],
  employeeCode = res['employee_code'],
  productCode = res['product_code'],
  documentCode = res['document_code'],
  type = res['type'],
  date = res['date'],
  count = res['count'],
  rejectReason = res['reject_reason'];
}