import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../vm/database_handler.dart';
import 'usermain.dart';

class Userinfo extends StatefulWidget {
  const Userinfo({super.key});

  @override
  State<Userinfo> createState() => _UserinfoState();
}

class _UserinfoState extends State<Userinfo> {
  late DatabaseHandler handler;
  late TextEditingController userIDController; //ID
  late TextEditingController userPWController; //PW
  // late TextEditingController userPWcheckController; //PWcheck
  late TextEditingController userPhoneController; //전화번호
  late TextEditingController userAddressController; //주소
  late TextEditingController userDetail_AddressController; //상세주소
  late List<String> userSex;
  late String dropDownValue; //dropdown

  var value = Get.arguments ?? "__";


  @override
  void initState() {
    super.initState();
    handler = DatabaseHandler();
    userIDController = TextEditingController();
    userPWController = TextEditingController();
    // userPWcheckController = TextEditingController();
    userPhoneController = TextEditingController();
    userAddressController = TextEditingController();
    userDetail_AddressController = TextEditingController();
    userSex = ['무관', '남성', '여성'];
    dropDownValue = userSex[0];

    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
              Container(
                width: 350,
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('회원정보',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),),
                  ],
                ),
              ),
              //email
              SizedBox(
                width: 350,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Email',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,)),
                        ],
                      ),
                    ),
                    TextField(
                      controller: userIDController,
                      decoration: InputDecoration(
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
                      readOnly: true,
                    ),
                  ],
                ),
              ),
              
              //PW
              SizedBox(
                width: 350,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('비밀번호',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,)),
                        ],
                      ),
                    ),
                    TextField(
                      controller: userPWController,
                      decoration: InputDecoration(
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
                      readOnly: false,
                      obscureText: true,
                    ),
                  ],
                ),
              ),

              // //PW check
              // SizedBox(
              //   width: 350,
              //   child: Column(
              //     children: [
              //       Padding(
              //         padding: const EdgeInsets.all(8.0),
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.start,
              //           children: [
              //             Text('비밀번호확인',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,)),
              //           ],
              //         ),
              //       ),
              //       TextField(
              //         controller: userPWcheckController,
              //         decoration: InputDecoration(
              //           border: OutlineInputBorder(
              //             borderRadius: BorderRadius.circular(20),
              //             borderSide: BorderSide(color: Color(0xFF727272)),
              //           ),
              //           enabledBorder: OutlineInputBorder(
              //             //입력 비활성화됐을때
              //             borderRadius: BorderRadius.circular(20),
              //             borderSide: BorderSide(color: Color(0xFF727272)),
              //           ),
              //           focusedBorder: OutlineInputBorder(
              //             borderRadius: BorderRadius.circular(20),
              //             borderSide: BorderSide(color: Color(0xFFFFBF1F)),
              //           ),
              //         ),
              //         readOnly: false,
              //         obscureText: true,
              //       ),
              //     ],
              //   ),
              // ),
              
              //PW check
              SizedBox(
                width: 350,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('전화번호',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,)),
                        ],
                      ),
                    ),
                    TextField(
                      controller: userPhoneController,
                      decoration: InputDecoration(
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
                      readOnly: false,
                    ),
                  ],
                ),
              ),
              //성별 선택
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: SizedBox(
                      width: 350,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 120,
                            height: 55,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xFF727272),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                DropdownButton(
                                  iconEnabledColor: Color(0xFFFFBF1F),
                                  icon: Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 28,
                                  ), //꺾쇠아이콘
                                  value: dropDownValue,
                                  items:
                                      userSex.map((String items) {
                                        return DropdownMenuItem(
                                          value: items,
                                          child: Text(items),
                                        );
                                      }).toList(),
                                  onChanged: (value) {
                                    dropDownValue = value!;
                                    setState(() {});
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                          Padding(
                          padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                    child: ElevatedButton(
                      onPressed: () {
                        // insertUser();
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFFBF1F),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        minimumSize: Size(350, 40),
                      ),
                      child: Text(
                        '수정',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFFFFFFFF),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
            ],
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
    );
  }
}