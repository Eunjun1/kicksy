import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:kicksy/view/user/purchase.dart';
import 'package:kicksy/vm/database_handler.dart';
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

  @override
  void initState() {
    super.initState();
    handler = DatabaseHandler();
    searchController = TextEditingController();
    where = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                    icon: Icon(Icons.menu),
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
                                    padding: const EdgeInsets.all(8.0),
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
                                            color: Color(0xFF727272),
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
                          width: 350,
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
                                ),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Get.to(
                                    Purchase(),
                                    arguments: snapshot.data![index].model.name ?? '기본값',
                                  );
                                  print(snapshot.data![index].model.name);
                                },
                                child: Card(
                                  color: Color.fromARGB(255, 246, 238, 220),
                                  child: Column(
                                    children: [
                                      // Image.memory(
                                      // snapshot.data![index].image
                                      // ),
                                      Column(
                                        children: [
                                          Image.memory(
                                            snapshot
                                                .data![index]
                                                .images
                                                .image,
                                            width: 70,
                                          ),
                                          Text(
                                            //제조사
                                            snapshot
                                                .data![index]
                                                .model
                                                .company,
                                            overflow: TextOverflow.ellipsis,
                                
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            //상품이름
                                            snapshot.data![index].model.name,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            //가격
                                            snapshot
                                                .data![index]
                                                .model
                                                .saleprice
                                                .toString(),
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
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
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('images/logo.png'),
              ),
              otherAccountsPictures: [
                CircleAvatar(backgroundImage: AssetImage('images/logo.png')),
                CircleAvatar(backgroundImage: AssetImage('images/logo.png')),
              ],
              accountName: Text('피카츄'),
              accountEmail: Text('we@gmail.com'),
              decoration: BoxDecoration(
                color: Color(0xFFFFBF1F),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.menu),
              title: Text('home'),
              onTap: () {
                print('home is clicked');
              },
            ),
          ],
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
