class Model {
  final int? code;
  final int imagecode;
  final String name;
  final String category;
  final String company;
  final String color;
  final int saleprice;

  Model({
    this.code,
    required this.imagecode,
    required this.name,
    required this.category,
    required this.company,
    required this.color,
    required this.saleprice,
  });

  Model.fromMap(Map<String, dynamic> res)
    : code = res['code'],
      imagecode = res['image_code'],
      name = res['name'],
      category = res['category'],
      company = res['company'],
      color = res['color'],
      saleprice = res['saleprice'];
}
