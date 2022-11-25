import 'package:coacheers/coaching/camera/camerademo.dart';
import 'package:coacheers/component/graph/raderchart.dart';
import 'package:coacheers/component/graph/recordbarchart.dart';
import 'package:coacheers/frame/mainFrame.dart';
import 'package:flutter/material.dart';

class recordResultPage extends StatefulWidget {
  final int id;
  final String name;
  final String profileURL;
  final String companyName;
  final String date;
  final double total_score;
  final double face_score;
  final double voice_score;

  recordResultPage(
      {Key? key,
      required this.id,
      required this.name,
      required this.profileURL,
      required this.companyName,
      required this.date,
      required this.total_score,
      required this.face_score,
      required this.voice_score})
      : super(key: key);

  @override
  State<recordResultPage> createState() => _recordResultPageState();
}

class _recordResultPageState extends State<recordResultPage> {
  @override
  Widget build(BuildContext context) {
    bool shouldPop = false;

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
              time_evaluation(),
              underline(),
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
                              Navigator.pop(
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
    return Container(
      width: 320,
      height: 220,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(5),
      child: Text(' 영상'),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.blue,
            width: 5,
          )),
    );
  }

  Widget info() {
    return Container(
      height: 150,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.blue,
            width: 5,
          )),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image(image: AssetImage('assets/feather.png'), width: 34),
                Container(
                  child: Text(
                    ' ${widget.companyName}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 34),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image(image: AssetImage('assets/chart.png'), width: 24),
                    Container(
                      child: Text(
                        ' ${widget.date}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Row(
                    children: [
                      Image(image: AssetImage('assets/chart.png'), width: 24),
                      Container(
                        child: Text(
                          ' ${widget.date}',
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
            "90점",
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
                Image(image: AssetImage('assets/chart.png'), width: 24),
                Container(
                  child: Text(
                    " 총점",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
          RecordBarchart(
              widget.total_score, widget.face_score, widget.voice_score)
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
                Image(image: AssetImage('assets/chart.png'), width: 24),
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
                Image(image: AssetImage('assets/support.png'), width: 24),
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
    return Container(
      width: 200,
      height: 200,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(5),
      child: Text(
        "피드백",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.blue,
            width: 5,
          )),
    );
  }
}
