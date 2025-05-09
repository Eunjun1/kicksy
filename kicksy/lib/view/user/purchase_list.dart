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
  int storeCode = 0;


  @override
  void initState() {
    super.initState();
    handler = DatabaseHandler();
    searchController = TextEditingController();
    where = '';
    storeName = '';

  }

  getStoreCode() {
    switch (storeCode) {
      case (1):
        storeName = '강남구';
        break;
      case (2):
        storeName = '강동구';
        break;
      case (3):
        storeName = '강북구';
        break;
      case (4):
        storeName = '강서구';
        break;
      case (5):
        storeName = '관악구';
        break;
      case (6):
        storeName = '광진구';
        break;
      case (7):
        storeName = '구로구';
        break;
      case (8):
        storeName = '금천구';
        break;
      case (9):
        storeName = '노원구';
        break;
      case (10):
        storeName = '도봉구';
        break;
      case (11):
        storeName = '동대문구';
        break;
      case (12):
        storeName = '동작구';
        break;
      case (13):
        storeName = '마포구';
        break;
      case (14):
        storeName = '서대문구';
        break;
      case (15):
        storeName = '서초구';
        break;
      case (16):
        storeName = '성동구';
        break;
      case (17):
        storeName = '성북구';
        break;
      case (18):
        storeName = '송파구';
        break;
      case (19):
        storeName = '양천구';
        break;
      case (20):
        storeName = '영등포구';
        break;
      case (21):
        storeName = '용산구';
        break;
      case (22):
        storeName = '은평구';
        break;
      case (23):
        storeName = '종로구';
        break;
      case (24):
        storeName = '중구';
        break;
      case (25):
        storeName = '중랑구';
        break;
      default:
        storeName = '알 수 없음';
        setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SingleChildScrollView(
          child: FutureBuilder(
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

                          ListView.builder(
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
                                                        snapshot.data![index].images.image,
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
                                                        storeCode =
                                                            snapshot
                                                                .data![index]!
                                                                .storeCode;
                                                        var req_num =
                                                            snapshot
                                                                .data![index]
                                                                .num!;
                                                        var req_count =
                                                            snapshot
                                                                .data![index]
                                                                .count;
                                                        getStoreCode();
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
                                                                        '수령처 : $storeName 매장',
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
