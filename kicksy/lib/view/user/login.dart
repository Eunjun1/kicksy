import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kicksy/view/user/signup.dart';
import 'package:kicksy/view/user/usermain.dart';
import 'package:kicksy/view/hq/hq_main.dart';
import 'package:kicksy/vm/database_handler.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //property
  late TextEditingController userIDeditingController;
  late TextEditingController userPWeditingController;
  late DatabaseHandler handler;
  late String userID; //사용자id
  late String userPW; //사용자pw
  late String empID; //사원번호
  late String empPW; //사원비밀번호

  @override
  void initState() {
    super.initState();
    handler = DatabaseHandler();
    userIDeditingController = TextEditingController();
    userPWeditingController = TextEditingController();
    userID = ''; //임시id
    userPW = ''; // 임시 pw
    empID = '1234';
    empPW = '123';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: FocusScope.of(context).unfocus,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 50),
                //logo
                Image.asset('images/logo.png', width: 350),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: SizedBox(
                    width: 350,
                    child: Row(
                      children: [
                        Text(
                          //font는 pretendard로 바꾸기
                          'Login to your Account',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF727272), // 0xFF+727272
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  //ID입력창
                  width: 350,
                  child: TextField(
                    controller: userIDeditingController,
                    onChanged:
                        (value) => reloadData(
                          userIDeditingController.text,
                          userPWeditingController.text,
                        ),
                    decoration: InputDecoration(
                      labelText: 'ID',
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
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: SizedBox(
                    //PW입력창
                    width: 350,
                    child: TextField(                      
                      controller: userPWeditingController,
                      onChanged:
                          (value) => reloadData(
                            userIDeditingController.text,
                            userPWeditingController.text,
                          ),
                      decoration: InputDecoration(
                        // hintText: 'ID를입력하세요',
                        labelText: 'PW',
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
                      obscureText: true,
                    ),
                  ),
                ),
                FutureBuilder(
                  future: handler.querySignIN(
                    userIDeditingController.text,
                    userPWeditingController.text,
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ElevatedButton(
                        //로그인버튼
                        onPressed: () {
                          reloadData(userID, userPW);
                          setState(() {});
                          if (snapshot.hasData) {
                            //유저일 경우 상품메인페이지,사원일 경우 시원페이지로 이동
                            if (snapshot.data!.isNotEmpty) {
                              if (userIDeditingController.text !=
                                      snapshot.data![0].email ||
                                  userPWeditingController.text !=
                                      snapshot.data![0].password) {
                                Get.snackbar('경고', '계정 정보가 일치하지 않습니다');
                              } else {
                                //유저일 경우
                                if (userIDeditingController.text ==
                                        snapshot.data![0].email &&
                                    userPWeditingController.text ==
                                        snapshot.data![0].password) {
                                  Get.to(Usermain()); //유저페이지로 이동
                                }
                                //사원일 경우
                              }
                            } else {
                              Get.snackbar('경고', '계정이 없습니다');
                            }
                          } else {
                            Get.snackbar('경고', '계정이 없습니다');
                          }
                          if (userIDeditingController.text == empID &&
                              userPWeditingController.text == empPW) {
                            Get.to(HqMain());
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFFFBF1F),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          minimumSize: Size(350, 40),
                        ),
                        child: Text(
                          '로그인',
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFFFFFFFF),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
                SizedBox(
                  width: 350,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '계정이 없으신가요?',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFD9D9D9),
                        ),
                      ),
                      //회원가입버튼
                      TextButton(
                        onPressed: () {
                          Get.to(Signup());
                        },
                        child: Text(
                          '회원가입',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFFBF1F),
                          ),
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
    );
  }

  reloadData(String email, String password) async {
    handler.querySignIN(email, password);
    setState(() {});
  }
}
