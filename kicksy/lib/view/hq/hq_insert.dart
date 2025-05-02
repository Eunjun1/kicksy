import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kicksy/model/images.dart';
import 'package:kicksy/model/model.dart';
import 'package:kicksy/vm/database_handler.dart';

class HqInsert extends StatefulWidget {
  const HqInsert({super.key});

  @override
  State<HqInsert> createState() => _HqInsertState();
}

class _HqInsertState extends State<HqInsert> {
  late DatabaseHandler handler;
  final ImagePicker picker = ImagePicker();
  late TextEditingController nameCT;
  late TextEditingController companyCT;
  late TextEditingController categoryCT;
  late TextEditingController colorCT;
  late TextEditingController salepriceCT;
  late TextEditingController maxstockCT;
  XFile? imageFile;
  late List<dynamic> images;

  @override
  void initState() {
    super.initState();
    handler = DatabaseHandler();
    nameCT = TextEditingController();
    companyCT = TextEditingController();
    categoryCT = TextEditingController();
    colorCT = TextEditingController();
    salepriceCT = TextEditingController();
    maxstockCT = TextEditingController();
    images = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 150),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    getImageFromGallery(ImageSource.gallery);
                    setState(() {});
                  },
                  icon: Icon(Icons.add),
                ),
                images.isNotEmpty
                    ? SizedBox(
                      height: 100,
                      width: 350,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: images.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.memory(images[index]),
                          );
                        },
                      ),
                    )
                    : Text('이미지를 선택해주세요'),
              ],
            ),
            TextField(controller: nameCT),
            TextField(controller: companyCT),
            TextField(controller: categoryCT),
            TextField(controller: colorCT),
            TextField(controller: salepriceCT),
            ElevatedButton(
              onPressed: () async {
                insertModelAction();
                insertImageAction();
              },
              child: Text('등록'),
            ),
          ],
        ),
      ),
    );
  }

  Future getImageFromGallery(ImageSource imageSource) async {
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile == null) {
      return;
    } else {
      imageFile = XFile(pickedFile.path);
      File imageFile1 = File(imageFile!.path);
      Uint8List getImage = await imageFile1.readAsBytes();
      images.add(getImage);
      setState(() {});
    }
  }

  insertModelAction() async {
    var modelInsert = Model(
      name: nameCT.text,
      category: categoryCT.text,
      company: companyCT.text,
      color: colorCT.text,
      saleprice: int.parse(salepriceCT.text),
    );
    await handler.insertModel(modelInsert);
  }

  insertImageAction() async {
    for (int i = 0; i < images.length; i++) {
      var imagesInsert = Images(
        modelname: nameCT.text,
        name: i.toString(),
        image: images[i],
      );
      await handler.insertimage(imagesInsert);
    }
  }
}
