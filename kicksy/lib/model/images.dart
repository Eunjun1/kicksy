import 'dart:typed_data';

class Images {
  final int? code;
  final String modelname;
  final String name;
  final Uint8List image;

  Images({
    this.code,
    required this.modelname,
    required this.name,
    required this.image,
  });

  Images.fromMap(Map<String, dynamic> res)
    : code = res['code'],
      modelname = res['model_name'],
      name = res['name'],
      image = res['image'];
}
