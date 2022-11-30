import 'dart:convert';
import 'package:coacheers/coaching/camera/video.dart';
import 'package:http/http.dart' as http;
import 'package:coacheers/coaching/camera/camerademo.dart';
import 'package:coacheers/component/graph/raderchart.dart';
import 'package:coacheers/component/graph/recordbarchart.dart';
import 'package:coacheers/frame/mainFrame.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String Server_URL = 'https://6edb-210-113-120-46.jp.ngrok.io';

class recordResultPage extends StatefulWidget {
  final int id;
  final int video_id;
  final String name;
  final String profileURL;

  final DateTime date;
  final int recordIndex;

  recordResultPage({
    Key? key,
    required this.recordIndex,
    required this.video_id,
    required this.id,
    required this.name,
    required this.profileURL,
    // required this.companyName,
    required this.date,
    // required this.total_score,
    // required this.face_score,
    // required this.voice_score
  }) : super(key: key);

  @override
  State<recordResultPage> createState() => _recordResultPageState();
}

class _recordResultPageState extends State<recordResultPage> {
  @override
  late String companyName = "";
  late double total_score = 0;
  late double face_score = 0;
  late double voice_score = 0;
  late double joy_score = 0;
  late String Filepath = "";

  void initState() {
    get_records_byrecordID(widget.recordIndex);
    super.initState();
  }

  Widget build(BuildContext context) {
    bool shouldPop = false;
    //print(Filepath);
    //get_records_byrecordID(widget.id);
    return WillPopScope(
        onWillPop: () async {
          return shouldPop;
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              "Coacheers",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                icon: Icon(
                  Icons.home_outlined,
                  color: Colors.black,
                  size: 24,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MainFrame(
                              id: widget.id,
                              name: widget.name,
                              profileURL: widget.profileURL,
                              subindex: 2,
                            )),
                  );
                },
              ),
            ],
            backgroundColor: Color(0xfffffffff),
            elevation: 0.0,
          ),
          body: ListView(
            children: [
              underline(),
              video(),
              info(),
              score(),
              barchart(),
              underline(),
              item_evaluation(),
              underline(),
              // time_evaluation(),
              // underline(),
              feedback(),
            ],
          ),
          bottomNavigationBar: Container(
            color: Color(0xff1877F2),
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Column(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          child: FloatingActionButton(
                            heroTag: "record",
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MainFrame(
                                      id: widget.id,
                                      name: widget.name,
                                      profileURL: widget.profileURL,
                                      subindex: 0,
                                    ),
                                  ));
                            },
                            child: Icon(
                              Icons.history,
                              size: 24,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "기록",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 30),
                  child: FloatingActionButton.extended(
                    elevation: 4.0,
                    icon: const Icon(Icons.wifi_tethering),
                    heroTag: "coaching start",
                    label: Text("모의 면접 코칭 시작"),
                    onPressed: () {
                      CoachingButtonDialog(context);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Column(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        child: FloatingActionButton(
                          heroTag: "my",
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MainFrame(
                                          id: widget.id,
                                          name: widget.name,
                                          profileURL: widget.profileURL,
                                          subindex: 1,
                                        )));
                          },
                          child: Icon(
                            Icons.person,
                            size: 24,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "마이",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  CoachingButtonDialog(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            //Dialog Main Title
            title: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text("코칭 영상 선택"),
              ],
            ),
            //
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new TextButton(
                  child: new Text("앨범에서 영상 선택"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                new TextButton(
                  child: new Text("영상 녹화 시작"),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CamerademoPage(
                              id: widget.id,
                              name: widget.name,
                              profileURL: widget.profileURL)),
                    );
                  },
                ),
              ],
            ),
            actions: <Widget>[
              new TextButton(
                child: new Text("취소"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  Widget underline() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
      child: Container(
        height: 1.0,
        width: 300.0,
        color: Colors.grey,
      ),
    );
  }

  Widget video() {
    //print(Filepath);
    return Container(
      width: 320,
      height: 715,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(5),
      child: FutureBuilder(
          future: get_video_path(widget.recordIndex),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData == false) {
              return Text(
                "0%",
                style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }
            return VideoPage(filePath: snapshot.data);
          }),

      // child: Text(' 영상'),
      // decoration: BoxDecoration(
      //     color: Colors.white,
      //     border: Border.all(
      //       color: Colors.blue,
      //       width: 5,
      //     )),
    );
  }

  Widget info() {
    // print(companyName);
    return Container(
      height: 100,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(5),
      // decoration: BoxDecoration(
      //     color: Colors.white,
      //     border: Border.all(
      //       color: Colors.blue,
      //       width: 5,
      //     )),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
              child: Row(
                children: [
                  Image(
                      image: AssetImage('assets/images/feather.png'),
                      width: 24),
                  Container(
                    child: Text(
                      ' ${companyName}',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 34),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Row(
                    children: [
                      Image(
                          image: AssetImage('assets/images/calendar.png'),
                          width: 24),
                      Container(
                        child: Text(
                          ' ${DateFormat('yyyy. MM. dd').format(widget.date).toString()}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                  child: Row(
                    children: [
                      Image(
                          image: AssetImage('assets/images/alarm.png'),
                          width: 24),
                      Container(
                        child: Text(
                          ' ${DateFormat('aa hh : mm', 'ko').format(widget.date).toString()}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget score() {
    return Center(
      child: Container(
        width: 151,
        height: 84,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(17),
            color: Colors.blue,
            border: Border.all(
              color: Colors.white,
              width: 0,
            )),
        child: Center(
          child: Text(
            "${total_score.toStringAsFixed(1)} 점",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      ),
    );
  }

  Widget barchart() {
    return Container(
      width: 200,
      height: 360,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 20),
            child: Row(
              children: [
                Image(image: AssetImage('assets/images/chart.png'), width: 24),
                Container(
                  child: Text(
                    " 총점",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
          RecordBarchart(total_score, face_score, voice_score)
        ],
      ),
    );
  }

  Widget item_evaluation() {
    // bool darkMode = false;
    // bool useSides = false;
    // double numberOfFeatures = 3;
    // const ticks = [7, 14, 21, 28, 35];
    // var features = ["AA", "BB", "CC", "DD", "EE", "FF", "GG", "HH"];
    // var data = [
    //   [10.0, 20, 28, 5, 16, 15, 17, 6],
    //   [14.5, 1, 4, 14, 23, 10, 6, 19]
    // ];
    // features = features.sublist(0, numberOfFeatures.floor());
    // data = data
    //     .map((graph) => graph.sublist(0, numberOfFeatures.floor()))
    //     .toList();
    return Container(
      width: 200,
      height: 360,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 20),
            child: Row(
              children: [
                Image(image: AssetImage('assets/images/chart.png'), width: 24),
                Container(
                  child: Text(
                    " 항목별 평가",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
                //       Container(
                //         color: darkMode ? Colors.black : Colors.white,
                //         child: Column(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: <Widget>[
                //             Padding(
                //               padding: const EdgeInsets.symmetric(horizontal: 8.0),
                //               child: Row(
                //                 mainAxisAlignment: MainAxisAlignment.start,
                //                 children: [
                //                   darkMode
                //                       ? Text(
                //                     'Light mode',
                //                     style: TextStyle(color: Colors.white),
                //                   )
                //                       : Text(
                //                     'Dark mode',
                //                     style: TextStyle(color: Colors.black),
                //                   ),
                //                   Switch(
                //                     value: darkMode,
                //                     onChanged: (value) {
                //                       setState(() {
                //                         darkMode = value;
                //                       });
                //                     },
                //                   ),
                //                 ],
                //               ),
                //             ),
                //             Padding(
                //               padding: const EdgeInsets.symmetric(horizontal: 8.0),
                //               child: Row(
                //                 mainAxisAlignment: MainAxisAlignment.start,
                //                 children: [
                //                   useSides
                //                       ? Text(
                //                     'Polygon border',
                //                     style: darkMode
                //                         ? TextStyle(color: Colors.white)
                //                         : TextStyle(color: Colors.black),
                //                   )
                //                       : Text(
                //                     'Circular border',
                //                     style: darkMode
                //                         ? TextStyle(color: Colors.white)
                //                         : TextStyle(color: Colors.black),
                //                   ),
                //                   Switch(
                //                     value: useSides,
                //                     onChanged: (value) {
                //                       setState(() {
                //                         useSides = value;
                //                       });
                //                     },
                //                   ),
                //                 ],
                //               ),
                //             ),
                //             Padding(
                //               padding: const EdgeInsets.symmetric(horizontal: 8.0),
                //               child: Row(
                //                 mainAxisAlignment: MainAxisAlignment.end,
                //                 children: <Widget>[
                //                   Text(
                //                     'Number of features',
                //                     style: TextStyle(
                //                         color: darkMode ? Colors.white : Colors.black),
                //                   ),
                //                   Expanded(
                //                     child: Slider(
                //                       value: numberOfFeatures,
                //                       min: 3,
                //                       max: 8,
                //                       divisions: 5,
                //                       onChanged: (value) {
                //                         setState(() {
                //                           numberOfFeatures = value;
                //                         });
                //                       },
                //                     ),
                //                   ),
                //                 ],
                //               ),
                //             ),
                //             Expanded(
                //               child: darkMode
                //                   ? RadarChart.dark(
                //                 ticks: ticks,
                //                 features: features,
                //                 data: data,
                //                 reverseAxis: true,
                //                 useSides: useSides,
                //               )
                //                   : RadarChart.light(
                //                 ticks: ticks,
                //                 features: features,
                //                 data: data,
                //                 reverseAxis: true,
                //                 useSides: useSides,
                //               ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
          RadarChartExample(),
        ],
      ),
    );
  }

  Widget time_evaluation() {
    return Container(
      width: 200,
      height: 360,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 20),
            child: Row(
              children: [
                Image(
                    image: AssetImage('assets/images/support.png'), width: 24),
                Container(
                  child: Text(
                    " 시간별 평가",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget feedback() {
    return FutureBuilder(
          future: get_feedback_byrecordID(widget.recordIndex),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData == false) {
              return Text(
                "피드백 내용이 없습니다.",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else {
              return Container(
                  width: 200,
                  height: 150,
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 20),
                        child: Row(
                          children: [
                            Image(
                                image: AssetImage('assets/images/support.png'),
                                width: 24),
                            Container(
                              child: Text(
                                " 피드백",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 20),
                        child: Text(
                          "${snapshot.data}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      )
                    ],
                  ));
            }
          },
    );
  }

  void get_records_byrecordID(int record_index) async {
    //print(id);
    String url = '${Server_URL}/records/${record_index}';

    //print(url);
    //print(start.millisecondsSinceEpoch);
    //print(end.millisecondsSinceEpoch);

    var response = await http.post(Uri.parse(url));
    var statusCode = response.statusCode;
    var responseHeaders = response.headers;
    var responseBody = utf8.decode(response.bodyBytes);

    //print("statusCode: ${statusCode}");
    //print("responseHeader: ${responseHeaders}");
    //print("responseBody: ${responseBody}");

    print(json.decode(responseBody));

    setState(() {
      companyName = json.decode(responseBody)["label"];
      total_score = (json.decode(responseBody)['total_score']) / 2;
      face_score = json.decode(responseBody)['face_score'];
      voice_score = json.decode(responseBody)['voice_score'];
    });
  }

  Future<String> get_video_path(int record_index) async {
    //print(id);
    String url = '${Server_URL}/records/${record_index}';

    //print(url);
    //print(start.millisecondsSinceEpoch);
    //print(end.millisecondsSinceEpoch);

    var response = await http.post(Uri.parse(url));
    var statusCode = response.statusCode;
    var responseHeaders = response.headers;
    var responseBody = utf8.decode(response.bodyBytes);

    //print("statusCode: ${statusCode}");
    //print("responseHeader: ${responseHeaders}");
    //print("responseBody: ${responseBody}");

    //print(json.decode(responseBody));

    String filepath = json.decode(responseBody)['filepath'];

    //print(filepath);

    return filepath;
  }

  Future<String> get_feedback_byrecordID(int record_index) async {
    //print(id);
    String url = '${Server_URL}/records/${record_index}';

    var response = await http.post(Uri.parse(url));
    var statusCode = response.statusCode;
    var responseHeaders = response.headers;
    var responseBody = utf8.decode(response.bodyBytes);

    print(json.decode(responseBody));

    joy_score = json.decode(responseBody)['voice_score'];
    String feedback = "";

    if (joy_score >= 60 && joy_score < 80) {
      feedback = "좀 더 밝은 표정을 지어볼까요?";
    } else if (joy_score >= 80 && joy_score < 90) {
      feedback = "좀 더 자신감을 가지세요!";
    } else if (joy_score >= 90 && joy_score < 100) {
      feedback = "지금 이대로가 좋습니다.";
    } else if (joy_score >= 100 && joy_score < 110) {
      feedback = "조금만 차분하게 하면 좋을 것 같아요!";
    } else {
      feedback = "너무 밝은 표정은 오히려 역효과에요!";
    }

    return feedback;
  }
}
