import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
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
  late List<String> brandName;

  @override
  void initState() {
    super.initState();
    handler = DatabaseHandler();
    searchController = TextEditingController();
    brandName = [
      '전체보기',
      '나이키',
      '아디다스',
      '반스',
      '뉴발란스',
      ' aaa',
      'bbb',
      'ccc',
      'dddd',
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: Column(
              children: [
                //우측상단 logo
                Stack(
                  children: [
                    Row(
                      children: [
                        Positioned(
                          top: 95,
                          child: Builder(
                            builder:
                                (context) => IconButton(
                                  icon: Icon(Icons.menu, color: Colors.amber),
                                  onPressed: () {
                                    Scaffold.of(context).openDrawer();
                                  },
                                ),
                          ),
                        ),
                        Positioned(
                          top: 30,
                          left: 126,
                          child: Image.asset('images/logo.png', width: 150)
                        ),
                      ],
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: SizedBox(
                    //상품검색 입력창
                    width: 346,
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        //search icon
                        label: Icon(Icons.search, color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Color(0xFF727272)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          //입력 비활성화됐을때
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Color(0xFF727272)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Color(0xFFFFBF1F)),
                        ),
                      ),
                      //비밀번호 안보이게
                      obscureText: true,
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
                    ],
                  ),
                ),
                FutureBuilder(
                  future: handler.queryProduct(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return SizedBox(
                        height: 50,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: brandName.length,
                          itemBuilder: (context, index) {
                            return
                            //제조사 별 카테고리 버튼
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  selectButton();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFFFFBF1F),
                                ),
                                child: SizedBox(
                                  child: Text(
                                    brandName[index],
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
                      itemCount: brandName.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 25,
                        mainAxisSpacing: 25,
                      ),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            // Get.to(purchase()); 구매페이지
                          },
                          child: GestureDetector(
                            // onTap: () => Get.to(Purchase());,
                            child: SizedBox(
                              height: 150,
                              width: 150,
                              child: Card(
                                color: Color.fromARGB(255, 246, 238, 220),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // Image.memory(
                                      // snapshot.data![index].image
                                      // ),
                                      Container(
                                        width: 100,
                                        height: 100,
                                        child: Column(
                                          children: [
                                            Image.asset(
                                              'images/logo.png',
                                              width: 70,
                                            ),
                                            Text(
                                              //제조사
                                              brandName[index],
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              //상품이름
                                              brandName[index],
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              //가격
                                              brandName[index],
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
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
  selectButton() {}
} //class
