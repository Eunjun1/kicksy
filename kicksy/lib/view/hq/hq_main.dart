import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kicksy/view/hq/hq_insert.dart';
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
  // late String dropDownValue;

  @override
  void initState() {
    super.initState();
    productList = [];
    // dropDownValue = productList[0];
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
                    '팀장 김재원',
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
              Expanded(
                child: FutureBuilder(
                  future: handler.queryModelwithImage(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Card(
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
                          );
                        },
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
              IconButton(
                onPressed:
                    () => Get.to(HqInsert())!.then((value) {
                      reloadData();
                    }),
                icon: Icon(Icons.add),
              ),
            ],
          ), // FutureBuilder
        ),
      ),
    );
  }

  reloadData() async {
    handler.queryModelwithImage();
    setState(() {});
  }
}
