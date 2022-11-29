import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:coacheers/coaching/camera/camerademo.dart';
import 'package:coacheers/coaching/coachingSavePage.dart';
import 'package:coacheers/frame/mainFrame.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class modalpage extends StatefulWidget {
  const modalpage({Key? key}) : super(key: key);

  @override
  State<modalpage> createState() => _modalpageState();
}

class _modalpageState extends State<modalpage> {
  @override
  List _items = [];
  Random random = new Random();
  // int randomNumber = random.nextInt(100);

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/wise.json');
    final data = await json.decode(response);
    setState(() {
      _items = data;
    });
  }
  Widget build(BuildContext context) {
    //print(_items[0]['message']);
    readJson();
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: readJson,
              child: const Text('Load Data'),
            ),
            Text(_items[0]['message']),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
          child: FloatingActionButton.extended(
              backgroundColor: Color(0xff1ABC9C),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              elevation: 4.0,
              icon: const Icon(
                Icons.save,
              ),
              heroTag: "Save",
              label: Text("저장하기"),
              onPressed: () async {
                //print(widget.filePath);
                //print(_commentController.text);
                //print(DateTime.now().toString());
                _onLoading();
              }
          ),
        )
            // Display the data loaded from sample.json
            // _items.isNotEmpty
            //     ? Expanded(
            //   // child: Text("${_items}")
            // )
            //    : Container()
          ],
        ),
      ),
    );

  }

  void _onLoading() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: new Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              new CircularProgressIndicator(),
              new Text("Loading"),
            ],
          ),
        );
      },
    );
    new Future.delayed(new Duration(seconds: 3), () {
      Navigator.pop(context); //pop dialog

    });
  }
}

