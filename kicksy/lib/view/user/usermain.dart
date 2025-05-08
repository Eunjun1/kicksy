import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:kicksy/view/user/purchase.dart';
import 'package:kicksy/view/user/userinfo.dart';
import 'package:kicksy/vm/database_handler.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Usermain extends StatefulWidget {
  const Usermain({super.key});

  @override
  State<Usermain> createState() => _UsermainState();
}

class _UsermainState extends State<Usermain> {
  DatabaseHandler handler = DatabaseHandler();
  late TextEditingController searchController;

  late String where;
  var value = Get.arguments ?? "__";

  @override
  void initState() {
    super.initState();
    handler = DatabaseHandler();
    searchController = TextEditingController();
    where = '';
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SingleChildScrollView(
          child: FutureBuilder(
            future: handler.queryModelwithImage(where),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Center(
                  child: GestureDetector(
                    onTap: () => FocusScope.of(context).unfocus(),
                    child: Column(
                      children: [
                        SizedBox(height: 50),
                        //우측상단 logo
                        Stack(
                          children: [
                            Positioned(
                              top: 38,
                              left: 30,
                              child: Builder(
                                builder:
                                    (context) => IconButton(
                                      icon: Icon(Icons.menu,
                                      color: Color(0xFFFFBF1F)),
                                      onPressed: () {
                                        Scaffold.of(context).openDrawer();
                                      },
                                    ),
                              ),
                            ),
                            Center(
                              child: Image.asset('images/logo.png', width: 120),
                            ),
                          ],
                        ),
      
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: SizedBox(
                            //상품검색 입력창
                            width: 350,
                            child: TextField(
                              controller: searchController,
                              onChanged: (value) {
                                where =
                                    "where name like '%${searchController.text}%'";
      
                                setState(() {});
                                reloadData(where);
                              },
                              decoration: InputDecoration(
                                //search icon
                                hintText: '검색어를 입력해주세요',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                    color: Color(0xFF727272),
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  //입력 비활성화됐을때
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                    color: Color(0xFF727272),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                    color: Color(0xFFFFBF1F),
                                  ),
                                ),
                              ),
      
                              //비밀번호 안보이게
                            ),
                          ),
                        ),
                        //container내부에 사진 들어가기
                        Container(
                          width: 350,
                          height: 110,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color(0xFFFFBF1F),
                          ),
                        ),
                        SizedBox(
                          width: 350,
                          child: Row(
                            children: [
                              Text(
                                '카테고리',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextButton(
                                  onPressed: () {
                                    where = "";
                                    setState(() {});
                                    reloadData(where);
                                  },
      
                                  child: SizedBox(
                                    child: Text(
                                      '전체 보기',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF727272),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        FutureBuilder(
                          future: handler.queryCompany(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return SizedBox(
                                height: 50,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data?.length,
                                  itemBuilder: (context, index) {
                                    return
                                    //제조사 별 카테고리 버튼
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(30, 4, 30, 4),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          where =
                                              "where company = '${snapshot.data![index].company}'";
                                          setState(() {});
                                          reloadData(where);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Color(0xFFFFBF1F),
                                        ),
                                        child: SizedBox(
                                          child: Text(
                                            snapshot.data![index].company,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              // color: Color(0xFF727272),
                                              color: Color(0xFFD09D1D),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: SizedBox(
                            width: 380,
                            child: GridView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: snapshot.data?.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 25,
                                    mainAxisSpacing: 25,
                                    childAspectRatio: 1 / 1.4, //gridview 가로세로 비율
                                  ),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () => Get.to(Purchase()),
                                  child: Card(
                                    color: Color.fromARGB(255, 246, 238, 220),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 160,
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                    5.0,
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(10),
                                                    child: Image.memory(
                                                      snapshot
                                                          .data![index]
                                                          .images
                                                          .image,
                                                      width: 180,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                      ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            //제조사
                                                            snapshot
                                                                .data![index]
                                                                .model
                                                                .company,
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                            ),
                                                          ),
                                                          Text(
                                                            //상품이름
                                                            snapshot
                                                                .data![index]
                                                                .model
                                                                .name,
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                            ),
                                                          ),
                                                          Text(
                                                            //가격
                                                            snapshot
                                                                .data![index]
                                                                .model
                                                                .saleprice
                                                                .toString(),
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
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
        drawer: Drawer(
          child: ListView(
            children: [
              GestureDetector(
                onTap: () => Get.to(Userinfo()),
                child: UserAccountsDrawerHeader(
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: AssetImage('images/logo.png'),
                    
                  ),
                  // otherAccountsPictures: [
                  //   CircleAvatar(backgroundImage: AssetImage('images/logo.png')),
                  //   CircleAvatar(backgroundImage: AssetImage('images/logo.png')),
                  // ],
                  accountName: Text('피카츄',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                  accountEmail: Text('we@gmail.com',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)),
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
                leading: Icon(Icons.list_alt_rounded),
                title: Text('주문목록',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                onTap: () {
                  Get.to(Usermain());
                  // print('home is clicked');
                },
              ),
              ListTile(
                leading: Icon(Icons.autorenew_sharp),
                title: Text('반품목록',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                onTap: () {
                  // Get.to()
                  // print('home is clicked');
                },
              ),
              ListTile(
                leading: Icon(Icons.question_mark_outlined),
                title: Text('고객센터?(또는 반품신청)',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                onTap: () {
                  // Get.to()
                  // print('home is clicked');
                },
              ),
            ],
          ),
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
