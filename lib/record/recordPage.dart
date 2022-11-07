import 'dart:developer';

import 'package:coacheers/component/coachingDater.dart';
import 'package:coacheers/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:logger/logger.dart';

import '../graph/recordbarchart.dart';

class RecordPage extends StatefulWidget {
  const RecordPage({Key? key}) : super(key: key);

  @override
  _RecordPageState createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  @override
  final DateRangePickerController _controller = DateRangePickerController();
  late String _startDate, _endDate;
  late DateTime _start, _end;

  var dateitems = <String>[];
  var companyitems = <String>[];
  var scoreitems = <String>[];

  late double Totalsum = 0.0;
  late double Facesum = 0.0;
  late double Voicesum = 0.0;

  void initState() {
    final DateTime today = DateTime.now();
    _startDate = DateFormat('yyyy. MM. dd')
        .format(today.subtract(Duration(days: 4)))
        .toString();
    _endDate = DateFormat('yyyy. MM. dd')
        .format(today.add(Duration(days: 3)))
        .toString();
    _controller.selectedRange = PickerDateRange(
        today.subtract(Duration(days: 4)), today.add(Duration(days: 3)));

    filterSearchResults(
        today.subtract(Duration(days: 4)), today.add(Duration(days: 3)));

    super.initState();
  }

  void selectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      _start = args.value.startDate;
      _startDate =
          DateFormat('yyyy. MM. dd').format(args.value.startDate).toString();

      _end = args.value.endDate ?? args.value.startDate;
      _end = new DateTime(_end.year,_end.month,_end.day + 1,_end.hour,_end.minute,_end.second - 1);
      _endDate = DateFormat('yyyy. MM. dd')
          .format(args.value.endDate ?? args.value.startDate)
          .toString();
    });
    //filterSearchResults(args.value.startDate, args.value.endDate ?? args.value.startDate);
  }

  void viewChanged(DateRangePickerViewChangedArgs args) {
    _startDate = DateFormat('yyyy. MM. dd')
        .format(args.visibleDateRange.startDate!)
        .toString();
    _endDate = DateFormat('yyyy. MM. dd')
        .format(args.visibleDateRange.endDate!)
        .toString();
    SchedulerBinding.instance!.addPostFrameCallback((duration) {
      setState(() {});
    });
  }

  _showSimpleModalDialog(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: Container(
              constraints: BoxConstraints(maxHeight: 340),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: SfDateRangePicker(
                        onSelectionChanged: selectionChanged,
                        selectionMode: DateRangePickerSelectionMode.range,
                        initialSelectedRange: PickerDateRange(
                            DateTime.now().subtract(Duration(days: 4)),
                            DateTime.now().add(Duration(days: 3))),
                        headerStyle: DateRangePickerHeaderStyle(
                          textAlign: TextAlign.center,
                        ),
                        showActionButtons: true,
                        onSubmit: (args) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text(
                              '기간이 설정되었습니다.',
                            ),
                            duration: Duration(milliseconds: 500),
                          ));
                          filterSearchResults(_start, _end);
                          Navigator.of(context).pop();
                        },

                        onCancel: () {
                          Navigator.of(context).pop();
                        },
                        controller: _controller,
                        view: DateRangePickerView.month,
                        //onViewChanged: viewChanged,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  void filterSearchResults(DateTime startDate, DateTime endDate) {
    var index = 0;

    List<DateTime> dummyDateSearchList = <DateTime>[];
    List<String> dummyCompanySearchList = <String>[];
    List<String> dummyScoreSearchList = <String>[];
    List<double> dummyFaceScoreSearchList = <double>[];
    List<double> dummyVoiceScoreSearchList = <double>[];

    dummyDateSearchList.addAll(searchDateList);
    dummyCompanySearchList.addAll(searchCompanyList);
    dummyScoreSearchList.addAll(searchScoreList);
    dummyFaceScoreSearchList.addAll(searchFaceScoreList);
    dummyVoiceScoreSearchList.addAll(searchVoiceScoreList);

    // for(int i = 0; i< searchVoiceScoreList.length; i++){
    //   print("회사이름${searchCompanyList[i]}표정점수${searchFaceScoreList[i]}목소리점수${searchVoiceScoreList[i]}");
    // }

    List<String> dummyDateListData = <String>[];
    List<String> dummyCompanyListData = <String>[];
    List<String> dummyScoreListData = <String>[];
    List<double> dummyFaceScoreListData = <double>[];
    List<double> dummyVoiceScoreListData = <double>[];

    //print("start : ${startDate}");
    //print("end : ${endDate}");

    dummyDateSearchList.forEach((item) {

      //print("item : ${item}");
      if (item.compareTo(startDate) > 0 && item.compareTo(endDate) <= 0) {
        dummyDateListData
            .add(DateFormat('yyyy. MM. dd').format(item).toString());
        dummyCompanyListData.add(dummyCompanySearchList[index]);
        dummyScoreListData.add(dummyScoreSearchList[index]);
        dummyFaceScoreListData.add(dummyFaceScoreSearchList[index]);
        dummyVoiceScoreListData.add(dummyVoiceScoreSearchList[index]);
      }
      index++;
    });

    print(dummyCompanyListData.length);

    double sum1 = dummyFaceScoreListData.fold(0, (vTotal, value) {
      return vTotal + value;
    });

    double sum2 = dummyVoiceScoreListData.fold(0, (vTotal, value) {
      return vTotal + value;
    });

    print(sum1);
    print(sum2);

    Facesum = sum1 / dummyFaceScoreListData.length;
    Voicesum = sum1 / dummyVoiceScoreListData.length;
    Totalsum = (Facesum + Voicesum) / 2;

    // List<RecordBarChartData> recordchartData = [
    // RecordBarChartData("Total",((sum1 / ( dummyCompanyListData.length)) + (sum2 / (dummyCompanyListData.length)))/2,Color(0xff2980B9)),
    // RecordBarChartData("표정", sum1 / ( dummyCompanyListData.length),Color(0xff2980B9)),
    // RecordBarChartData("목소리", sum2 / (dummyCompanyListData.length),Color(0xff3498DB)),
    // ];

    // print("레코드 데이타 길이 ${recordchartData.length}");

    //10 20  15
    //20 30  25
    //30 40  35
    //20 30  25

    setState(() {
      dateitems.clear();
      dateitems.addAll(dummyDateListData);

      companyitems.clear();
      companyitems.addAll(dummyCompanyListData);

      scoreitems.clear();
      scoreitems.addAll(dummyScoreListData);
    });
  }

  @override
  Widget build(BuildContext context) {
    print("메인 페이지 - 기록 페이지\n");
    //print(searchlist.toString());
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: Container(
              height: 1.0,
              width: 300.0,
              color: Colors.grey,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Container(
              width: 200,
              height: 90,
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Row(
                      children: [
                        Image(
                            image: AssetImage('assets/Vector.png'), width: 24),
                        Container(
                          child: Text(
                            " 기간별 기록",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('$_startDate' ' - ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15)),
                          Text('$_endDate',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15)),
                          // Text('$RangeStart' ' - ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                          // Text('$RangeEnd', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                          IconButton(
                            icon: Image.asset('assets/calendar.png'),
                            iconSize: 24,
                            onPressed: () {
                              _showSimpleModalDialog(context);
                            },
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Container(
              width: 200,
              height: 200,
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(5),
              child: RecordBarchart(Totalsum, Facesum, Voicesum),
              // decoration: BoxDecoration(
              //     color: Colors.white,
              //     border: Border.all(
              //       color: Colors.blue,
              //       width: 5,
              //     )),
              //   child:  Image(
              //       image: AssetImage('assets/Group 3002.png')),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: Container(
              height: 1.0,
              width: 300.0,
              color: Colors.grey,
            ),
          ),
          Container(
            width: 200,
            height: 500,
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(5),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 20),
                  child: Row(
                    children: [
                      Container(
                          child: Text(
                        "${dateitems.length}건의 검색 결과",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12),
                      )),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: dateitems.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                          title: Text('${companyitems[index]}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17)),
                          subtitle: Text('${dateitems[index]}',
                              style: TextStyle(
                                  color: Color(0xff0066FF),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12)),
                          trailing: ElevatedButton(
                            onPressed: () {},
                            child: Text("${scoreitems[index]}점"),
                          ));
                    },
                  ),
                ),
              ],
            ),
            // decoration: BoxDecoration(
            //     color: Colors.white,
            //     border: Border.all(
            //       color: Colors.blue,
            //       width: 5,
            //     )),
            //   child:  Image(
            //       image: AssetImage('assets/Group 3002.png')),
          ),
        ],
      ),
    );
  }
}
