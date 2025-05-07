import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remedi_kopo/remedi_kopo.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  late TextEditingController userIDController; //ID
  late TextEditingController userPWController; //PW
  late TextEditingController userPhoneController; //전화번호
  late TextEditingController _AddressController;
  late TextEditingController userAddressController; //주소
  late List<String> userSex;
  late String dropDownValue; //dropdown

  @override
  void initState() {
    super.initState();
    userIDController = TextEditingController();
    userPWController = TextEditingController();
    userPhoneController = TextEditingController();
    userAddressController = TextEditingController();
    _AddressController = TextEditingController();
    userSex = ['남성', '여성'];
    dropDownValue = userSex[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: FocusScope.of(context).unfocus,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 380,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(Icons.arrow_back_ios_new_rounded),
                    ),
                    Padding(
                      //우측 상단 로고
                      padding: const EdgeInsets.fromLTRB(0, 30, 10, 30),
                      child: Image.asset('images/logo.png', width: 120),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                child: SizedBox(
                  width: 350,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        '정보 입력',
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
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
                child: SizedBox(
                  //userEmail 입력
                  width: 350,
                  child: TextField(
                    controller: userIDController,
                    decoration: InputDecoration(
                      // hintText: 'ID를입력하세요',
                      labelText: 'Email',
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
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: SizedBox(
                  //userID일치 여부
                  width: 350,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '일치여부',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: SizedBox(
                  //userPW 입력
                  width: 350,
                  child: TextField(
                    controller: userPWController,
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
                    //비밀번호 안보이게
                    obscureText: true,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: SizedBox(
                  //userphone입력
                  width: 350,
                  child: TextField(
                    controller: userPhoneController,
                    decoration: InputDecoration(
                      // hintText: 'ID를입력하세요',
                      labelText: '휴대전화',
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
              ),
              Padding(
                //주소찾기 창
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 250,
                      height: 55,
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF727272), width: 1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: Text('주소', style: TextStyle(fontSize: 16)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   //주소찾기 버튼
                    //   width: 100,
                    //   child: TextButton(
                    //     onPressed: () async{
                    //       //dialog로 카카오주소검색 API
                    //       KopoModel model = await Navigator.push(
                    //           context,CupertinoPageRoute(builder: (context) => RemediKopo(),
                    //           ),
                    //           );

                    //           logger.i(
                    //             '${model.zonecode} / ${model.address} / ${model.buildingName}',
                    //             );
                    //             // => 13529 / 경기 성남시 분당구 판교역로 166 / 카카오 판교 아지트
                    //             },
                    //     style: TextButton.styleFrom(
                    //       minimumSize: Size(100,30)
                    //     ),
                    //     child: Text(
                    //       '주소 찾기',
                    //       style: TextStyle(
                    //         fontSize: 16,
                    //         color: Color(0xFFFFBF1F),
                    //         fontWeight: FontWeight.bold
                    //       ),
                    //     )
                    //   ),
                    // ),
                    GestureDetector(
                      onTap: () async {
                        addressAPI();
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '주소 찾기',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFFFFBF1F),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextFormField(
                            controller: _AddressController,
                            enabled: false,
                            decoration: InputDecoration(isDense: false),
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: SizedBox(
                  //userAddress입력창
                  width: 350,
                  child: TextField(
                    controller: userAddressController,
                    decoration: InputDecoration(
                      // hintText: 'ID를입력하세요',
                      labelText: '상세주소',
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
              ),
              //성별 선택
              SizedBox(
                width: 350,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 120,
                      height: 55,
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF727272), width: 1),
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
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(Signup());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFFBF1F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    minimumSize: Size(350, 40),
                  ),
                  child: Text(
                    '회원가입',
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
      ),
    );
  }

  //function
  addressAPI() {
    // KopoModel model = await Navigator.push(
    //     context,
    //     CupertinoPageRoute(
    //       builder: (context) => RemediKopo(),
    //     ),
    //   );
    //   logger.i(
    //     '${model.zonecode} / ${model.address} / ${model.buildingName}',
    //   );
    //   // => 13529 / 경기 성남시 분당구 판교역로 166 / 카카오 판교 아지트
    // },
  }

  _addressAPI() async {
    KopoModel model = await Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => RemediKopo(),
      ),
    );
    _AddressController.text =
        '${model.zonecode!} ${model.address!} ${model.buildingName!}';
  }


}
