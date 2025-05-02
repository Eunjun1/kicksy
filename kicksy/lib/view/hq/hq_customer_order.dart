import 'dart:ffi';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:kicksy/vm/database_handler.dart';

class HqCustomerOrder extends StatefulWidget {
  const HqCustomerOrder({super.key});

  @override
  State<HqCustomerOrder> createState() => _HqCustomerOrderState();
}

class _HqCustomerOrderState extends State<HqCustomerOrder> {
  DatabaseHandler handler = DatabaseHandler();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: handler.queryModel(), 
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Row(
                    children: [
                      Image.memory(
                        Uint8List(snapshot.data![index].imagecode),
                      ),
                      Column(
                        children: [
                          Text('모델명 : ${snapshot.data![index].code}'),
                          Text('모델명 : ${snapshot.data![index].name}'),
                          Text('모델명 : ${snapshot.data![index].saleprice}'),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          }else{
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}