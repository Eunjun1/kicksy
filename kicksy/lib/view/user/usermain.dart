import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kicksy/view/uesr/purchase.dart';
import 'package:kicksy/view/uesr/purchase_list.dart';
import 'package:kicksy/view/uesr/userinfo.dart';
import 'package:kicksy/vm/database_handler.dart';

class Usermain extends StatefulWidget {
  const Usermain({super.key});

  @override
  State<Usermain> createState() => _UsermainState();
}

class _UsermainState extends State<Usermain> {
  DatabaseHandler handler = DatabaseHandler();
  late TextEditingController searchController;
  int selectedIndex = -1;

  late String where;
  var value = Get.arguments ?? "__";
  late dynamic newProd;

  @override
  void initState() {
    super.initState();
    handler = DatabaseHandler();
    searchController = TextEditingController();
    where = '';
    _handlenew();
  }

  Future<void> _handlenew() async {
    final newProdName = await handler.queryProductNew();
    final newProdname = newProdName[0].model.name;
    final newProdImage = await handler.queryImages(newProdname);
    newProd = newProdImage[0].image;
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
                        SizedBox(height: 60),
                        //우측상단 logo
                        Stack(
                          children: [
                            Positioned(
                              top: 35,
                              left: 10,
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
                            Center(
                              child: Transform.scale(
                                scale: 1.2,
                                child: Image.asset(
                                  'images/logo.png',
                                  width: 120,
                                ),
                              ),
                            ),
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                          child: SizedBox(
                            //상품검색 입력창
                            width: 400,
                            child: TextField(
                              controller: searchController,
                              onChanged: (value) async {
                                if (selectedIndex == -1) {
                                  where =
                                      "where name like '%${searchController.text}%'";
                                } else {
                                  final companyList =
                                      await handler.queryCompany();
                                  final searchCompany =
                                      companyList[selectedIndex].company;
                                  where =
                                      "where name like '%${searchController.text}%' and company = '$searchCompany'";
                                }
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
                          width: 400,
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image: MemoryImage(newProd),
                              fit: BoxFit.cover,
                            ),
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
                                    searchController.clear();
                                    where = "";
                                    setState(() {
                                      selectedIndex = -1;
                                    });
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
                                width: 400,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data?.length,
                                  itemBuilder: (context, index) {
                                    final isSelected = selectedIndex == index;
                                    return
                                    //제조사 별 카테고리 버튼
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                        5,
                                        4,
                                        5,
                                        4,
                                      ),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          searchController.clear();
                                          where =
                                              "where company = '${snapshot.data![index].company}'";
                                          setState(() {
                                            selectedIndex = index;
                                          });
                                          reloadData(where);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              isSelected
                                                  ? Colors.yellow[100]
                                                  : Color(0xFFFFBF1F),
                                        ),
                                        child: SizedBox(
                                          child: Text(
                                            snapshot.data![index].company,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              // color: Color(0xFF727272),
                                              color:
                                                  isSelected
                                                      ? Colors.black
                                                      : Color(0xFFD09D1D),
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
                                    childAspectRatio:
                                        1 / 1.4, //gridview 가로세로 비율
                                  ),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap:
                                      () => Get.to(
                                        Purchase(),
                                        arguments: [
                                          snapshot.data![index].model.name,
                                          value[0]
                                        ],
                                      ),
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
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          10,
                                                        ),
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
                                                                  FontWeight
                                                                      .bold,
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
                                                                  FontWeight
                                                                      .bold,
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
                                                                  FontWeight
                                                                      .bold,
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
