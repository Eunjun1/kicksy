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
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          '발주결재',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(width: 1, color: Colors.black),
              ),
              width: MediaQuery.of(context).size.width - 50,
              height: MediaQuery.of(context).size.height - 260,
              // color:Color(0xFFffffff),
              child: SizedBox(
                width: 250,
                child: Column(
                  // Text('기안자 :     ',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //기안자
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: SizedBox(
                        width: 300,
                        child: TextField(
                          controller: propserCT,
                          decoration: InputDecoration(labelText: '기안자'),
                        ),
                      ),
                    ),
                    //제목
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: SizedBox(
                        width: 300,
                        child: TextField(
                          controller: titleCT,
                          decoration: InputDecoration(labelText: '제목'),
                        ),
                      ),
                    ),
                    //내용
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: SizedBox(
                        width: 300,
                        child: TextField(
                          controller: contentCT,
                          decoration: InputDecoration(labelText: '내용'),
                        ),
                      ),
                    ),
                    //직원코드
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: SizedBox(
                        width: 300,
                        child: TextField(
                          controller: employeeCodeCT,
                          decoration: InputDecoration(labelText: '직원 코드'),
                        ),
                      ),
                    ),
                    //제품번호
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: SizedBox(
                        width: 300,
                        child: TextField(
                          controller: productCodeCT,
                          decoration: InputDecoration(labelText: '제품 번호'),
                        ),
                      ),
                    ),
                    //오더타입
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: SizedBox(
                        width: 300,
                        child: TextField(
                          controller: odyTypeCT,
                          decoration: InputDecoration(labelText: '오더 타입'),
                        ),
                      ),
                    ),
                    //구매 수량
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: SizedBox(
                        width: 300,
                        child: TextField(
                          controller: odyCountCT,
                          decoration: InputDecoration(labelText: '발주 수량'),
                        ),
                      ),
                    ),
                    //거절이유
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: SizedBox(
                        width: 300,
                        child: TextField(
                          controller: rejectReasonCT,
                          decoration: InputDecoration(labelText: '거절 이유'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: ElevatedButton(
                onPressed: () {
                  insertOrdering();
                  insertDocument();
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFFBF1F),
                  minimumSize: Size(350, 40),
                ),
                child: Text(
                  '입력',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  insertOrdering() {
    var insertorderying = Orderying(
      employeeCode: int.parse(employeeCodeCT.text),
      productCode: int.parse(productCodeCT.text),
      documentCode: 0,
      type: int.parse(odyTypeCT.text),
      date: DateTime.now().toString(),
      count: int.parse(odyCountCT.text),
      rejectReason: rejectReasonCT.text,
    );
    databaseHandler.insertOrdering(insertorderying);
  }

  insertDocument() {
    var insertdocument = Document(
      propser: propserCT.text,
      title: titleCT.text,
      contents: contentCT.text,
      date: DateTime.now().toString(),
    );
    databaseHandler.insertDocument(insertdocument);
  }
}
