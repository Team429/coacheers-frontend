import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class RecordPage extends StatefulWidget {
  const RecordPage({Key? key}) : super(key: key);

  @override
  _MyModalPageState createState() => _MyModalPageState();
}

class _MyModalPageState extends State<RecordPage> {
  @override
  final DateRangePickerController _controller = DateRangePickerController();

  String _Rangestart =
  DateFormat('dd, MMMM yyyy').format(DateTime.now()).toString();
  String _Rangeend =
  DateFormat('dd, MMMM yyyy').format(DateTime.now()).toString();

  String _startDate = '', _endDate = '';

  void initState() {
    super.initState();
  }

  void viewChanged(DateRangePickerViewChangedArgs args) {
    _startDate = DateFormat('dd, MMMM yyyy')
        .format(args.visibleDateRange.startDate!)
        .toString();
    _endDate = DateFormat('dd, MMMM yyyy')
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
                        selectionMode: DateRangePickerSelectionMode.range,
                        headerStyle: DateRangePickerHeaderStyle(
                          textAlign: TextAlign.center,
                        ),
                        showActionButtons: true,
                        onSubmit: (args) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text(
                              'Selection Confirmed',
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
                        onViewChanged: viewChanged,
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
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Container(
              width: 200,
              height: 100,
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.blue,
                    width: 5,
                  )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "기간별 기록",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  Row(
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
            child: Text("검색 결과"),
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
