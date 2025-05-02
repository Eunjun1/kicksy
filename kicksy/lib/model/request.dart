class Request {
  final int num;
  final String userId;
  final int productCode;
  final int documentCode;
  final int type;
  final DateTime date; 
  final int count;
  final String reason;

  Request({
    required this.num,
    required this.userId,
    required this.productCode,
    required this.documentCode,
    required this.type,
    required this.date,
    required this.count,
    required this.reason
  });
  
  Request.fromMap(Map<String, dynamic> res)
  : num = res['num'],
  userId = res['user_id'],
  productCode = res['product_code'],
  documentCode = res['document_code'],
  type = res['type'],
  date = res['date'],
  count = res['count'],
  reason = res['reason'];
}