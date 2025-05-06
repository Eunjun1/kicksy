import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:team_project_5_2/model/images.dart';
import 'package:team_project_5_2/model/model.dart';
import 'package:team_project_5_2/vm/database_handler_1.dart';

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
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(), icon: Icon(Icons.arrow_back_ios)),
      ),
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
            TextField(controller: nameCT, decoration: InputDecoration(labelText: '제품 이름')),
            TextField(controller: companyCT, decoration: InputDecoration(labelText: '회사 이름')),
            TextField(controller: categoryCT, decoration: InputDecoration(labelText: '카테고리')),
            TextField(controller: colorCT, decoration: InputDecoration(labelText: '색상')),
            TextField(controller: salepriceCT, decoration: InputDecoration(labelText: '판매가')),
            ElevatedButton(
              onPressed: () async {
                insertModelAction();
                insertImageAction();
                Get.back();
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
      imageNum: 0
    );
    await handler.insertModel(modelInsert);
  }

  insertImageAction() async {
    for (int i = 0; i < images.length; i++) {
      var imagesInsert = Images(
        code: i,
        modelname: nameCT.text,
        num: i,
        image: images[i],
      );
      await handler.insertimage(imagesInsert);
    }
  }
}