import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:kicksy/view/hq/hq_document.dart';
import 'package:kicksy/view/hq/hq_insert.dart';
import 'package:kicksy/view/hq/hq_insert_order_document.dart';
import 'package:kicksy/view/hq/hq_model_detail.dart';
import 'package:kicksy/vm/database_handler.dart';

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
        child: Container(
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
              DropdownButton(
                value: dropDownValue,
                items:
                    productList.map<DropdownMenuItem<String>>((String value) {
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
              Expanded(
                child:
                    dropDownValue == '제품 목록'
                        ? FutureBuilder(
                          future: handler.queryModelwithImage(''),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Get.to(
                                        HqModelDetail(),
                                        arguments: [
                                          snapshot.data![index].model.name,
                                          snapshot.data![index].model.code,
                                          snapshot.data![0].images.image,
                                        ],
                                      );
                                    },
                                    child: Card(
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
                                  );
                                },
                              );
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          },
                        )
                        : FutureBuilder(
                          future: handler.queryOderyingWithDocument(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Column(
                                children: [
                                  Container(
                                    height: 50,
                                    width: 400,
                                    color: Colors.yellow,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text('발주 번호'),
                                        Text('제목'),
                                        Text('기안자'),
                                        Text('날짜'),
                                      ],
                                    ),
                                  ),
                                  ListView.builder(
                                    shrinkWrap: T,
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap:
                                            () => Get.to(
                                              () => HqDocument(),
                                              arguments: [
                                                snapshot
                                                    .data![index]
                                                    .document
                                                    .code,
                                              ],
                                            ),
                                        child: Card(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                snapshot
                                                    .data![index]
                                                    .orderying
                                                    .num
                                                    .toString(),
                                              ),
                                              Text(
                                                snapshot
                                                    .data![index]
                                                    .document
                                                    .title,
                                              ),
                                              Text(
                                                snapshot
                                                    .data![index]
                                                    .document
                                                    .propser,
                                              ),
                                              Text(
                                                snapshot
                                                    .data![index]
                                                    .document
                                                    .date
                                                    .toString()
                                                    .substring(0, 10),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              );
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          },
                        ),
              ),
            ],
          ), // FutureBuilder
        ),
      ),
      floatingActionButton:
          dropDownValue == '제품 목록'
              ? IconButton(
                onPressed:
                    () =>
                        Get.to(() => HqInsert())!.then((value) => reloadData()),
                icon: Icon(Icons.add),
              )
              : IconButton(
                onPressed:
                    () => Get.to(
                      () => HqInsertOrderDocument(),
                    )!.then((value) => reloadData()),
                icon: Icon(Icons.add),
              ),
    );
  }

  reloadData() async {
    handler.queryModelwithImage('');
    handler.queryOderyingWithDocument();
    setState(() {});
  }
}
