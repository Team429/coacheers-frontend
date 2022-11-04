import 'package:coacheers/component/coachingDater.dart';
import 'package:coacheers/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:logger/logger.dart';

class RecordPage extends StatefulWidget {
  const RecordPage({Key? key}) : super(key: key);

  @override
  _RecordPageState createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  @override
  final DateRangePickerController _controller = DateRangePickerController();
  late String _startDate, _endDate;

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
    super.initState();
  }

  void selectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      _startDate =
          DateFormat('yyyy. MM. dd').format(args.value.startDate).toString();
      _endDate = DateFormat('yyyy. MM. dd')
          .format(args.value.endDate ?? args.value.startDate)
          .toString();
    });
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

  @override
  Widget build(BuildContext context) {
    print("메인 페이지 - 기록 페이지\n");
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
                    padding: const EdgeInsets.fromLTRB(10,0,0,0),
                    child: Row(
                      children: [
                        Image(
                            image: AssetImage('assets/Vector.png'), width: 24),
                        Container(
                          child: Text(
                            " 기간별 기록",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10,0,0,0),
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
              //   child:  Image(
              //       image: AssetImage('assets/Group 3002.png')),
            ),
          ),
          Container(
            width: 200,
            height: 200,
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(5),
            child: Text("그래프"),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.blue,
                  width: 5,
                )),
            //   child:  Image(
            //       image: AssetImage('assets/Group 3002.png')),
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
                              "검색 결과",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12),
                          )
                      ),
                    ],
                  ),
                ),
                Column(
                    children: [
                      Text("검색 결과 들어감")
                    ]
                ),
              ],
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.blue,
                  width: 5,
                )),
            //   child:  Image(
            //       image: AssetImage('assets/Group 3002.png')),
          ),
        ],
      ),
    );
  }
}

_getBody() {
  return productMap.map((e) => Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
    Text(e["numOfDay"].toString()),
    Text(e["amount"].toString()),
    Text(e["amount"].toString()),
  ]));
}
