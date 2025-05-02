import 'package:flutter/material.dart';
import 'package:kicksy/vm/database_handler.dart';

class HqMain extends StatefulWidget {
  const HqMain({super.key});

  @override
  State<HqMain> createState() => _HqMainState();
}

class _HqMainState extends State<HqMain> {
  late DatabaseHandler handler;

  @override
  void initState() {
    super.initState();
    handler = DatabaseHandler();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: handler.queryModel(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 500,
                    width: 300,
                    child: ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Text(snapshot.data![index].name),
                            Text(snapshot.data![index].company),
                            Text(snapshot.data![index].color),
                            Text(snapshot.data![index].saleprice.toString()),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
