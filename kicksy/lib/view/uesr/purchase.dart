import 'package:flutter/material.dart';
import 'package:kicksy/vm/database_handler.dart';

class Purchase extends StatefulWidget {
  const Purchase({super.key});

  @override
  State<Purchase> createState() => _PurchaseState();
}

class _PurchaseState extends State<Purchase> {
  DatabaseHandler handler  = DatabaseHandler();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('구매하기'),
      ),
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width ,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Stance'
                ),
                Text(
                  'Vans'
                ),
                Text(
                  'VN000D3HY28'
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    width: 346,
                    height: 250,
                    color: Colors.amber,
                  ),
                ),
                Text(
                  '69,000'
                ),
              ],
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
                  //
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