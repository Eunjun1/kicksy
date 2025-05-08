import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:kicksy/view/user/purchase.dart';
import 'package:kicksy/view/user/userinfo.dart';
import 'package:kicksy/view/user/usermain.dart';
import 'package:kicksy/vm/database_handler.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

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
                        // ListView.builder(itemBuilder: (context, index) {}),
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
                      onTap: () => Get.to(Userinfo(), arguments: [value[0]]),
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
