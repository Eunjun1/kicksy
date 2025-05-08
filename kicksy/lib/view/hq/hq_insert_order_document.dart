import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kicksy/model/document.dart';
import 'package:kicksy/model/orderying.dart';
import 'package:kicksy/vm/database_handler.dart';

class HqInsertOrderDocument extends StatefulWidget {
  const HqInsertOrderDocument({super.key});

  @override
  State<HqInsertOrderDocument> createState() => _HqInsertOrderDocumentState();
}

class _HqInsertOrderDocumentState extends State<HqInsertOrderDocument> {

  DatabaseHandler databaseHandler = DatabaseHandler();
  
  TextEditingController numCT = TextEditingController();
  TextEditingController propserCT = TextEditingController();
  TextEditingController titleCT = TextEditingController();
  TextEditingController contentCT = TextEditingController();
  TextEditingController dateCT = TextEditingController();
  TextEditingController odyNumCT = TextEditingController();
  TextEditingController employeeCodeCT = TextEditingController();
  TextEditingController productCodeCT = TextEditingController();
  TextEditingController documentCodeCT = TextEditingController();
  TextEditingController odyTypeCT = TextEditingController();
  TextEditingController odyDateCT = TextEditingController();
  TextEditingController odyCountCT = TextEditingController();
  TextEditingController rejectReasonCT = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () => Get.back(), icon: Icon(Icons.arrow_back_ios)),
      ),
      body: Center(
        child: Column(
          children: [
            TextField(controller: numCT, decoration: InputDecoration(labelText: '문서 번호')),
            TextField(controller: propserCT, decoration: InputDecoration(labelText: '기안자')),
            TextField(controller: titleCT, decoration: InputDecoration(labelText: '제목')),
            TextField(controller: contentCT, decoration: InputDecoration(labelText: '내용')),
            TextField(controller: dateCT, decoration: InputDecoration(labelText: '기안 날짜')),
            TextField(controller: odyNumCT, decoration: InputDecoration(labelText: '오더 번호')),
            TextField(controller: employeeCodeCT, decoration: InputDecoration(labelText: '직원 코드')),
            TextField(controller: productCodeCT, decoration: InputDecoration(labelText: '제품 번호')),
            TextField(controller: documentCodeCT, decoration: InputDecoration(labelText: '문서 번호')),
            TextField(controller: odyTypeCT, decoration: InputDecoration(labelText: '오더 타입')),
            TextField(controller: odyDateCT, decoration: InputDecoration(labelText: '오더 날짜')),
            TextField(controller: odyCountCT, decoration: InputDecoration(labelText: '오더 숫자')),
            TextField(controller: rejectReasonCT, decoration: InputDecoration(labelText: '거절 이유')),
            ElevatedButton(onPressed: () {
              insertOrdering();
              insertDocument();
            }, child: Text('입력'))
          ],
        )
      ),
    );
  }

  insertOrdering(){
    var insertorderying = Orderying(
      num:  int.parse(odyNumCT.text), 
      employeeCode: int.parse(employeeCodeCT.text), 
      productCode: int.parse(productCodeCT.text), 
      documentCode: int.parse(documentCodeCT.text), 
      type: int.parse(odyNumCT.text), 
      date: DateTime.now().toString(), 
      count: int.parse(odyNumCT.text), 
      rejectReason: rejectReasonCT.text);
    databaseHandler.insertOrdering(insertorderying);
  }

  insertDocument(){
    var insertdocument = Document(
      code: int.parse(numCT.text), 
      propser: propserCT.text, 
      title: titleCT.text, 
      contents: contentCT.text, 
      date: DateTime.now().toString());
    databaseHandler.insertDocument(insertdocument);
  }

}