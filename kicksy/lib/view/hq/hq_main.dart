import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:kicksy/view/hq/hq_document.dart';
import 'package:kicksy/view/hq/hq_insert.dart';
import 'package:kicksy/view/hq/hq_insert_order_document.dart';
import 'package:kicksy/vm/database_handler.dart';
import 'package:get/get.dart';

import 'package:kicksy/view/hq/hq_insert.dart';
import 'package:kicksy/view/hq/hq_model_detail.dart';
import 'package:kicksy/view/user/login.dart';
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

  var value = Get.arguments ?? "__";

  ///
  // late String dropDownValue;

  @override
  void initState() {
    super.initState();
    productList = [];
    // dropDownValue = productList[0];
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.fromLTRB(28, 80, 28, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '본사',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Row(
                  children: [
                    Text(
                      '팀장 김재원',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 70),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () => Get.to(Login()),
                              child: Text(
                                '로그아웃',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                              child: Icon(Icons.logout),
                            ),
                            // DropdownButton(                                  //제품목록 dropdown
                            //   items: items,
                            //   onChanged: onChanged
                            // )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: FutureBuilder(
                  future: handler.queryModelwithImage(''),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Get.to(
                                HqModelDetail(),
                                arguments: [
                                  snapshot.data![index].model.name,
                                  snapshot.data![index].model.code!,
                                  snapshot.data![index].images.image,
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
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '모델명 : ${snapshot.data![index].model.name}',
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          '제조사 : ${snapshot.data![index].model.company}',
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          '가격 : ${snapshot.data![index].model.saleprice}',
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
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
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(280, 0, 0, 30),
                child: IconButton(
                  onPressed:
                      () => Get.to(HqInsert())!.then((value) {
                        reloadData();
                      }),
                  icon: Icon(Icons.add, size: 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  reloadData() async {
    handler.queryModelwithImage('');
    setState(() {});
  }
}
