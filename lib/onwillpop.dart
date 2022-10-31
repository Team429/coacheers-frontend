import 'package:flutter/material.dart';


class MyList extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyListPage(title: 'hello',),
    );
  }
}

class MyListPage extends StatefulWidget {
  MyListPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyListPageState createState() => _MyListPageState();
}

class _MyListPageState extends State<MyListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("hello"),
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
