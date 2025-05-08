import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kicksy/model/images.dart';
import 'package:kicksy/model/model.dart';
import 'package:kicksy/model/product_with_model.dart';
import 'package:kicksy/view/user/payment.dart';
import 'package:kicksy/vm/database_handler.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';

class Purchase extends StatefulWidget {
  const Purchase({super.key});

  @override
  State<Purchase> createState() => _PurchaseState();
}

class _PurchaseState extends State<Purchase> {
  DatabaseHandler handler = DatabaseHandler();
  var modelName = Get.arguments ?? '__';
  late List<ProductWithModel> data;
  late List<Images> imageData;
  late int imageCurrent;
  late int buyCount;
  late List<Model> sameCategory;

  @override
  void initState() {
    super.initState();
    data = [];
    imageData = [];
    sameCategory = [];
    imageCurrent = 0;
    buyCount = 1;
    fetchAllData();
  }

  Future<void> fetchAllData() async {
    await fetchData();
    await fetchImageData();

    await fetchsameCategory(); // data[0] 접근은 fetchData가 끝난 뒤에만
    setState(() {});
  }

  Future<void> fetchData() async {
    List<ProductWithModel> fetchData = await handler.queryProductwithModel(
      modelName,
    );
    data = fetchData;
    setState(() {});
  }

  Future<void> fetchImageData() async {
    List<Images> fetchImageData = await handler.queryImages(modelName);

    imageData = fetchImageData;
    setState(() {});
  }

  Future<void> fetchsameCategory() async {
    List<Model> fetchData = await handler.queryModelWhereCategory(
      data[0].model.category,
    );
    sameCategory = fetchData;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: false, title: Text('구매하기')),
      body:
          data.isEmpty && imageData.isEmpty
              ? Center(child: CircularProgressIndicator()) // 로딩 중
              : Stack(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data[0].model.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.amber,
                              fontSize: 40,
                            ),
                          ),
                          Text(data[0].model.company),
                          Text(data[0].model.category),

                          imageData.isEmpty || data.isEmpty
                              ? SizedBox(
                                width: 346,
                                height: 250,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              )
                              : ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: SimpleGestureDetector(
                                  onHorizontalSwipe: (direction) {
                                    direction == SwipeDirection.left
                                        ? {
                                          imageCurrent += 1,
                                          if (imageCurrent >
                                              imageData.length - 1)
                                            {imageCurrent = 0, setState(() {})},
                                        }
                                        : {
                                          imageCurrent -= 1,
                                          if (imageCurrent < 0)
                                            {
                                              imageCurrent =
                                                  imageData.length - 1,
                                              setState(() {}),
                                            },
                                        };

                                    setState(() {});
                                  },
                                  child: Container(
                                    width: 346,
                                    height: 250,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: MemoryImage(
                                          imageData[imageCurrent].image,
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                          Text('${data[0].model.saleprice}원'),

                          Text('비슷한 신발'),

                          SizedBox(
                            width: 354,
                            height: 70,
                            child: Expanded(
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: sameCategory.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    child: Text(sameCategory[index].color),
                                  );
                                },
                              ),
                            ),
                          ),

                          Text('사이즈'),

                          SizedBox(
                            width: 354,
                            height: 58,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                return SizedBox(
                                  width: 95,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      child: Text(
                                        data[index].product.size.toString(),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),

                          Text('개수'),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  if (buyCount > 1) {
                                    buyCount -= 1;
                                  } else {
                                    buyCount = 1;
                                  }

                                  setState(() {});
                                },
                                icon: Icon(Icons.arrow_back_ios),
                              ),

                              Text(buyCount.toString()),

                              IconButton(
                                onPressed: () {
                                  buyCount += 1;
                                  setState(() {});
                                },
                                icon: Icon(Icons.arrow_forward_ios),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: 120,
                    left: 120,
                    child: Text(
                      "결제 가격 : ${data[0].model.saleprice * buyCount}원",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: 52,
                    left: 28,
                    child: SizedBox(
                      width: 346,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          // 구매 버튼
                          Get.to(
                            Payment(),
                            arguments: [
                              data[0].product.code,
                              buyCount,
                            ]
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          '구매',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
    );
  }
}
