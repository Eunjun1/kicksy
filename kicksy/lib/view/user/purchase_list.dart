import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kicksy/view/user/userinfo.dart';
import 'package:kicksy/view/user/usermain.dart';

import 'package:kicksy/vm/database_handler.dart';

class PurchaseList extends StatefulWidget {
  const PurchaseList({super.key});

  @override
  State<PurchaseList> createState() => _PurchaseList();
}

class _PurchaseList extends State<PurchaseList> {
  DatabaseHandler handler = DatabaseHandler();
  late TextEditingController searchController;
  int selectedIndex = -1;

  late String where;
  var value = Get.arguments ?? "__";
  late dynamic newProd;
  late String storeName;

  @override
  void initState() {
    super.initState();
    handler = DatabaseHandler();
    searchController = TextEditingController();
    where = '';
    storeName = '';
  }

  String getStoreCode(int storeCode) {
    switch (storeCode) {
      case 1:
        return '강남구';
      case 2:
        return '강동구';
      case 3:
        return '강북구';
      case 4:
        return '강서구';
      case 5:
        return '관악구';
      case 6:
        return '광진구';
      case 7:
        return '구로구';
      case 8:
        return '금천구';
      case 9:
        return '노원구';
      case 10:
        return '도봉구';
      case 11:
        return '동대문구';
      case 12:
        return '동작구';
      case 13:
        return '마포구';
      case 14:
        return '서대문구';
      case 15:
        return '서초구';
      case 16:
        return '성동구';
      case 17:
        return '성북구';
      case 18:
        return '송파구';
      case 19:
        return '양천구';
      case 20:
        return '영등포구';
      case 21:
        return '용산구';
      case 22:
        return '은평구';
      case 23:
        return '종로구';
      case 24:
        return '중구';
      case 25:
        return '중랑구';
      default:
        return '알 수 없음';
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: FutureBuilder(
          future: handler.queryRequest(value[0]),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Center(
                child: GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 28.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 60),
                        //우측상단 logo
                        Stack(
                          children: [
                            Positioned(
                              top: 35,
                              child: Builder(
                                builder:
                                    (context) => IconButton(
                                      icon: Transform.scale(
                                        scale: 1.2,
                                        child: Icon(
                                          Icons.menu,
                                          color: Color(0xFFFFBF1F),
                                        ),
                                      ),
                                      onPressed: () {
                                        Scaffold.of(context).openDrawer();
                                      },
                                    ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 28.0),
                              child: Center(
                                child: Transform.scale(
                                  scale: 1.2,
                                  child: Image.asset(
                                    'images/logo.png',
                                    width: 120,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        Text(
                          '주문내역',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 30,
                          ),
                        ),

                        Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemCount: snapshot.data?.length,
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 28.0),
                                    child: Text(
                                      '주문일자 : ${snapshot.data![index].date.substring(0, 10)}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  FutureBuilder(
                                    future: handler.queryUserRequestImages(
                                      snapshot.data![index].num!,
                                    ),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                            0,
                                            10,
                                            28,
                                            0,
                                          ),
                                          child: Container(
                                            width: 346,
                                            height: 120,
                                            child: Stack(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          20,
                                                        ),
                                                    image: DecorationImage(
                                                      image: MemoryImage(
                                                        snapshot.data![1].image,
                                                      ),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          20,
                                                        ),
                                                    color: Colors.black
                                                        .withOpacity(0.4),
                                                  ),
                                                ),
                                                // Content on top of overlay
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                    12.0,
                                                  ),
                                                  child: FutureBuilder(
                                                    future: handler
                                                        .queryRequest(value[0]),
                                                    builder: (
                                                      context,
                                                      snapshot,
                                                    ) {
                                                      if (snapshot.hasData) {
                                                        int thisStoreCode =
                                                            snapshot
                                                                .data![index]!
                                                                .storeCode;
                                                        String thisStoreName =
                                                            getStoreCode(
                                                              thisStoreCode,
                                                            );
                                                        var req_num =
                                                            snapshot
                                                                .data![index]
                                                                .num!;
                                                        var req_count =
                                                            snapshot
                                                                .data![index]
                                                                .count;

                                                        return Row(
                                                          children: [
                                                            FutureBuilder(
                                                              future: handler
                                                                  .queryReqProductwithModel(
                                                                    req_num,
                                                                  ),
                                                              builder: (
                                                                context,
                                                                snapshot,
                                                              ) {
                                                                if (snapshot
                                                                    .hasData) {
                                                                  return Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        '주문 번호 : $req_num',
                                                                        style: TextStyle(
                                                                          color:
                                                                              Colors.white,
                                                                          fontWeight:
                                                                              FontWeight.w700,
                                                                          fontSize:
                                                                              16,
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        '수령처 : $thisStoreName 매장',
                                                                        style: TextStyle(
                                                                          color:
                                                                              Colors.white,
                                                                          fontWeight:
                                                                              FontWeight.w700,
                                                                          fontSize:
                                                                              16,
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        '개수 : $req_count개',
                                                                        style: TextStyle(
                                                                          color:
                                                                              Colors.white,
                                                                          fontWeight:
                                                                              FontWeight.w700,
                                                                          fontSize:
                                                                              16,
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        '결제 가격 : ₩ ${req_count * snapshot.data![0].model.saleprice}',
                                                                        style: TextStyle(
                                                                          color:
                                                                              Colors.white,
                                                                          fontWeight:
                                                                              FontWeight.w700,
                                                                          fontSize:
                                                                              16,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  );
                                                                } else {
                                                                  return CircularProgressIndicator();
                                                                }
                                                              },
                                                            ),
                                                          ],
                                                        );
                                                      } else {
                                                        return CircularProgressIndicator();
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      } else {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                    },
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
        //drawer
        drawer: FutureBuilder(
          future: handler.querySignINUser(value[0]),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Drawer(
                child: ListView(
                  children: [
                    GestureDetector(
                      onTap: () => Get.to(Userinfo()),
                      child: UserAccountsDrawerHeader(
                        currentAccountPicture: Transform.scale(
                          scale: 1.3,
                          child: Image.asset('images/kicksy_white.png'),
                        ),

                        // otherAccountsPictures: [
                        //   CircleAvatar(backgroundImage: AssetImage('images/logo.png')),
                        //   CircleAvatar(backgroundImage: AssetImage('images/logo.png')),
                        // ],
                        accountName: Text(
                          snapshot.data![0].email,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        accountEmail: Text(
                          '전화번호 : ${snapshot.data![0].phone}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xFFFFBF1F),
                          // borderRadius: BorderRadius.only(
                          //   bottomLeft: Radius.circular(40),
                          //   bottomRight: Radius.circular(40),
                          // ),
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.home_outlined),
                      title: Text(
                        '메인',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () {
                        Get.to(Usermain(), arguments: [value[0]]);
                        // print('home is clicked');
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.list_alt_rounded),
                      title: Text(
                        '주문목록',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () {
                        Get.to(PurchaseList(), arguments: [value[0]]);
                        // print('home is clicked');
                      },
                    ),
                  ],
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  } //build

  //function

  reloadData(String where) async {
    await handler.queryModelwithImage(where);
    setState(() {});
  }
} //class
