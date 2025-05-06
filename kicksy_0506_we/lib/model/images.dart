import 'dart:typed_data';

class Images {
  final int? code;
  final String name;
  final Uint8List image;

  Images({this.code, required this.name, required this.image});

  Images.fromMap(Map<String, dynamic> res)
    : code = res['code'],
      name = res['name'],
      image = res['image'];
}
