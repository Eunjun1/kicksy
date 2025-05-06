import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:team_project_5_2/model/document.dart';
import 'package:team_project_5_2/vm/database_handler_1.dart';

class HqDocument extends StatefulWidget {
  const HqDocument({super.key});

  @override
  State<HqDocument> createState() => _HqDocumentState();
}

class _HqDocumentState extends State<HqDocument> {
  DatabaseHandler databaseHandler = DatabaseHandler();

  late List<Document> documentList;

  @override
  void initState() {
    super.initState();
    documentList = [
      Document(
        code: 1,
        propser: '김태민',
        title: '기안1',
        contents: '알빠노',
        date: DateTime.now(),
        type: 1,
        grade: '팀장',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Color(0xFFD9D9D9),
              width: 350,
              height: 600,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('문서 코드 : ${documentList[0].code.toString()}'),
                  Text('기안자 : ${documentList[0].propser}'),
                  Text('문서 제목 : ${documentList[0].title}'),
                  Text('문서 내용 : ${documentList[0].contents}'),
                  Text('기안 날짜 : ${documentList[0].date.toString().substring(0, 10)}'),
                  Text(
                    documentList[0].type == 0
                    ? '팀장 결재중'
                    : documentList[0].type == 1
                    ? '이사 결재중'
                    : documentList[0].type == -1
                    ? '반려'
                    : '결제 완료'
                  ),
                ],
              ),
            ),
            documentList[0].type == 0 && documentList[0].grade == '팀장'
                ? Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // 업데이트 (type를 +1함)
                        Get.back();
                      },
                      child: Container(
                        width: 350,
                        color: Color(0xFFFFBF1F),
                        child: Text('승인', textAlign: TextAlign.center),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        //업데이트
                        Get.back();
                      },
                      child: Container(
                        color: Color(0xFFD9D9D9),
                        width: 350,
                        child: Text('부결', textAlign: TextAlign.center),
                      ),
                    ),
                  ],
                )
                : documentList[0].type == 1 && documentList[0].grade == '이사'
                ? Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // 업데이트 (type를 +1함)
                        Get.back();
                      },
                      child: Container(
                        width: 350,
                        color: Color(0xFFFFBF1F),
                        child: Text('승인', textAlign: TextAlign.center),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        //업데이트
                        Get.back();
                      },
                      child: Container(
                        color: Color(0xFFD9D9D9),
                        width: 350,
                        child: Text('부결', textAlign: TextAlign.center),
                      ),
                    ),
                  ],
                )
                : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: SizedBox(
                        width: 350,
                        child: ColoredBox(
                          color: Color(0xFFD9D9D9),
                          child: Text('확인', textAlign: TextAlign.center),
                        ),
                      ),
                    ),
                  ],
                ),
          ],
        ),
      ),
    );
  }
}
