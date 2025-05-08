import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kicksy/view/user/mapview.dart';

class UserPayment extends StatefulWidget {
  const UserPayment({super.key});

  @override
  State<UserPayment> createState() => _UserPaymentState();
}

class _UserPaymentState extends State<UserPayment> {
  late List<String> store;
  late int count;
  late String selectedStore;
  late TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    store = [
      '',
      '강남구',
      '강동구',
      '강북구',
      '강서구',
      '관악구',
      '광진구',
      '구로구',
      '금천구',
      '노원구',
      '도봉구',
      '동대문구',
      '동작구',
      '마포구',
      '서대문구',
      '서초구',
      '성동구',
      '성북구',
      '송파구',
      '양천구',
      '영등포구',
      '용산구',
      '은평구',
      '종로구',
      '중구',
      '중랑구',
    ];
    selectedStore = '';
    count = 1;
    textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('결제 정보'),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('구매 상품'),
          SizedBox(
            child: Row(
              children: [
                SizedBox(width: 100, height: 100),
                Column(children: [Text('모델 :'), Text('색상 :'), Text('사이즈 :')]),
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        countUp();
                        setState(() {});
                      },
                      icon: Icon(Icons.arrow_upward),
                    ),
                    Container(
                      width: 15,
                      color: Color(0xffFFC01E),
                      child: SizedBox(
                        child: Text(
                          count.toString(),
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        countDown();
                        setState(() {});
                      },
                      icon: Icon(Icons.arrow_downward),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            width: 200,
            child: Row(
              children: [
                DropdownButton(
                  value: selectedStore,
                  items:
                      store.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: SizedBox(width: 120, child: Text(value)),
                        );
                      }).toList(),
                  onChanged: (String? value) {
                    if (store.contains('')) {
                      store.remove('');
                    }
                    selectedStore = value!;
                    textEditingController.text = selectedStore;
                    setState(() {});
                  },
                ),
                IconButton(
                  onPressed: () => Get.to(() => UserMapview()),
                  icon: Icon(Icons.map),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('최종 가격 : ', style: TextStyle(), textAlign: TextAlign.center),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [ElevatedButton(onPressed: () {}, child: Text('결제 하기'))],
          ),
        ],
      ),
    );
  }

  countUp() {
    count += 1;
  }

  countDown() {
    if (count == 1) {
      count = 1;
    } else {
      count -= 1;
    }
  }
}
