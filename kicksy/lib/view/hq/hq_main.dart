import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:team_project_5_2/view/hq/hq_insert.dart';
import 'package:team_project_5_2/vm/database_handler_1.dart';

class HqMain extends StatefulWidget {
  const HqMain({super.key});

  @override
  State<HqMain> createState() => _HqMainState();
}

class _HqMainState extends State<HqMain> {
  //property
  DatabaseHandler handler = DatabaseHandler();
  late List<String> productList;

  ///
  late String dropDownValue;

  @override
  void initState() {
    super.initState();
    productList = ['제품 목록', '발주 목록'];
    dropDownValue = productList[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('본사main')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '본사',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Text(
                  '팀장 김제원',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Text(
                          '로그아웃',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                          child: Icon(Icons.logout),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(
                  width: 350,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DropdownButton(
                        value: dropDownValue,
                        items:
                            productList.map<DropdownMenuItem<String>>((String value,) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 0, 250, 0),
                                      child: Text(value),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                        onChanged: (String? value) {
                          dropDownValue = value!;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: dropDownValue == '제품 목록' 
              ? FutureBuilder(
                future: handler.queryModelwithImage(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Card(
                              child: Row(
                                children: [
                                  Image.memory(
                                    snapshot.data![index].images.image,
                                    width: 100,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        '모델명 : ${snapshot.data![index].model.name}',
                                      ),
                                      Text(
                                        '제조사 : ${snapshot.data![index].model.company}',
                                      ),
                                      Text(
                                        '가격 : ${snapshot.data![index].model.saleprice}',
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              )
              : Column(
        children: [
          Row(
            children: [
              Text('발주 번호'),
              Text('기안자'),
              Text('날짜'),
              Text('결재 상태'),
            ],
          ),
          FutureBuilder(
            future: handler.queryOderyingWithDocument(), 
            builder: (context, snapshot) {
              if(snapshot.hasData){
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Row(
                        children: [
                          // Text(snapshot.data![index].orderying.num.toString()),
                          // Text(snapshot.data![index].document.propser),
                          // Text(snapshot.data![index].orderying.date.toString()),
                          // Text(snapshot.data![index].orderying.type.toString()),
                        ],
                      ),
                    );
                  },
                );
              }else{
                return Center(child: CircularProgressIndicator(),);
              }
            },
          ),
        ]
            ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => HqInsert());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
