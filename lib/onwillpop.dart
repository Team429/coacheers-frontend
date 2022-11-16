import 'package:flutter/material.dart';

class MyListPage extends StatefulWidget {
  MyListPage({Key? key}) : super(key: key);

  @override
  _MyListPageState createState() => _MyListPageState();
}

class _MyListPageState extends State<MyListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("제목"),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.red,
            height: 30,
          ),
          Expanded(child: MyListView()),
          Container(
            color: Colors.green,
            height: 30,
          ),
        ],
      ),
    );
  }
}

class MyListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return Text("Row $index");
      },
      itemCount: 10,
    );
  }
}
