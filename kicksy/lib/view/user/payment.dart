import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kicksy/model/product_with_model.dart';
import 'package:kicksy/model/request.dart';
import 'package:kicksy/view/user/mapview.dart';

import 'package:kicksy/vm/database_handler.dart';

class UserPayment extends StatefulWidget {
  const UserPayment({super.key});

  @override
  State<UserPayment> createState() => _UserPaymentState();
}

class _UserPaymentState extends State<UserPayment> {
  DatabaseHandler databaseHandler = DatabaseHandler();

  late List<String> store;
  late int count;
  late String selectedStore;
  late TextEditingController textEditingController;
  late String userId;
  late int modelCode;
  late int selectedSize;
  late List<ProductWithModel> model;

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
    count = Get.arguments[1];
    textEditingController = TextEditingController();
    userId = Get.arguments[3];
    modelCode = Get.arguments[0];
    selectedSize = Get.arguments[4];
    model = List<ProductWithModel>.from(Get.arguments[2]);
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
                FutureBuilder(
                  future: databaseHandler.queryImages(model[0].model.name),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Image.memory(snapshot.data![0].image, scale: 10);
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
                SizedBox(width: 100, height: 100),
                Column(
                  children: [
                    Text('모델 : ${model[0].model.name}'),
                    Text('사이즈 : $selectedSize'),
                  ],
                ),
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
              Text(
                '최종 가격 : ${count * model[0].model.saleprice}',
                style: TextStyle(),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  insertRequest();
                },
                child: Text('결제 하기'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  insertRequest() {
    // id와 product코드 argument가져와서 고치기
    var insertreq = Request(
      userId: userId,
      productCode: model[0].product.code!,
      storeCode: getStoreCode(),
      type: 0,
      date: DateTime.now().toString().substring(0, 10),
      count: count,
    );
    databaseHandler.insertRequest(insertreq);
  }

  getStoreCode() {
    int storeCode = 0;
    switch (selectedStore) {
      case ('강남구'):
        storeCode = 1;
      case ('강동구'):
        storeCode = 2;
      case ('강북구'):
        storeCode = 3;
      case ('강서구'):
        storeCode = 4;
      case ('관악구'):
        storeCode = 5;
      case ('광진구'):
        storeCode = 6;
      case ('구로구'):
        storeCode = 7;
      case ('금천구'):
        storeCode = 8;
      case ('노원구'):
        storeCode = 9;
      case ('도봉구'):
        storeCode = 10;
      case ('동대문구'):
        storeCode = 11;
      case ('동작구'):
        storeCode = 12;
      case ('마포구'):
        storeCode = 13;
      case ('서대문구'):
        storeCode = 14;
      case ('서초구'):
        storeCode = 15;
      case ('성동구'):
        storeCode = 16;
      case ('성북구'):
        storeCode = 17;
      case ('송파구'):
        storeCode = 18;
      case ('양천구'):
        storeCode = 19;
      case ('영등포구'):
        storeCode = 20;
      case ('용산구'):
        storeCode = 21;
      case ('은평구'):
        storeCode = 22;
      case ('종로구'):
        storeCode = 23;
      case ('중구'):
        storeCode = 24;
      case ('중랑구'):
        storeCode = 25;
    }
    return storeCode;
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
