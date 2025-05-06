class Model {
  final int? code;
  final int imageNum;
  final String name;
  final String category;
  final String company;
  final String color;
  final int saleprice;

  Model({
    this.code,
    required this.imageNum,
    required this.name,
    required this.category,
    required this.company,
    required this.color,
    required this.saleprice,
  });

  Model.fromMap(Map<String, dynamic> res)
    : code = res['code'],
      imageNum = res['image_num'],
      name = res['name'],
      category = res['category'],
      company = res['company'],
      color = res['color'],
      saleprice = res['saleprice'];
}