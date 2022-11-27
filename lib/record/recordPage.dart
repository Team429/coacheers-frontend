import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:coacheers/component/coachingDater.dart';
import 'package:coacheers/component/graph/recordbarchart.dart';
import 'package:coacheers/record/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class RecordPage extends StatefulWidget {
  final int id;
  final String nickname;
  final String profileURL;

  const RecordPage({Key? key, required this.id, required this.nickname, required this.profileURL}) : super(key: key);

  @override
  _RecordPageState createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  @override
  final DateRangePickerController _controller = DateRangePickerController();

  late String _startDate, _endDate;
  late DateTime _start, _end;

  late double Totalsum = 0.0;
  late double Facesum = 0.0;
  late double Voicesum = 0.0;

  late List<SearchData> searchitems = [];

  void initState() {
    final DateTime today = DateTime.now();
    _startDate = DateFormat('yyyy. MM. dd')
        .format(today.subtract(Duration(days: 7)))
        .toString();
    _endDate = DateFormat('yyyy. MM. dd').format(today).toString();
    _controller.selectedRange =
        PickerDateRange(today.subtract(Duration(days: 7)), today);

    get_records_search(widget.id, today.subtract(Duration(days: 7)), today);
    // filterSearchResults(
    //     today.subtract(Duration(days: 8)), today.add(Duration(days: 0)));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("메인 페이지 - 기록 페이지\n");
    //print(searchlist.toString());
    //print(widget.id);
    get_records(widget.id);
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          underline(),
          daterange(),
          searchbargraph(),
          underline(),
          searchresult(),
        ],
      ),
    );
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

  Widget searchbargraph() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Container(
        width: 200,
        height: 200,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(5),
        child: RecordBarchart(Totalsum, Facesum, Voicesum),
      ),
    );
  }

  Widget daterange() {
    return Padding(
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
                  Image(image: AssetImage('assets/Vector.png'), width: 24),
                  Container(
                    child: Text(
                      " 기간별 기록",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
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
    );
  }

  Widget searchresult() {
    return Container(
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
                  "${searchitems.length}건의 검색 결과",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                )),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: searchitems.length,
              itemBuilder: (context, index) {
                return ListTile(
                    title: Text('${searchitems[index].companyName}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17)),
                    subtitle: Text('${DateFormat('yyyy. MM. dd').format(searchitems[index].date).toString()}',
                        style: TextStyle(
                            color: Color(0xff0066FF),
                            fontWeight: FontWeight.bold,
                            fontSize: 12)),
                    trailing: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>
                              recordResultPage(recordIndex : searchitems[index].record_index,
                                  id: widget.id,
                                  name: widget.nickname,
                                  profileURL: widget.profileURL,
                                  // companyName: searchitems[index].companyName,
                                  date: searchitems[index].date,
                                  // total_score: searchitems[index].totalscore,
                                  // face_score: searchitems[index].facescore,
                                  // voice_score: searchitems[index].voicescore)
                          )
                        )
                        );
                      },
                      child: Text("${searchitems[index].totalscore}점"),
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
    );
  }

  void selectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      _start = args.value.startDate;
      _startDate =
          DateFormat('yyyy. MM. dd').format(args.value.startDate).toString();

      _end = args.value.endDate ?? args.value.startDate;
      _end = new DateTime(_end.year, _end.month, _end.day + 1, _end.hour,
          _end.minute, _end.second - 1);
      _endDate = DateFormat('yyyy. MM. dd')
          .format(args.value.endDate ?? args.value.startDate)
          .toString();
    });
    get_records_search(widget.id, _start, _end);
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
                            DateTime.now().subtract(Duration(days: 8)),
                            DateTime.now().add(Duration(days: 0))),
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
                          //filterSearchResults(_start, _end);
                          get_records_search(widget.id, _start, _end);
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

  // void filterSearchResults(DateTime startDate, DateTime endDate) {
  //
  //   List<CoachingData> coachData = getDataSource();
  //   searchData.clear();
  //
  //   coachData.forEach((item) {
  //     if (item.time.compareTo(startDate) > 0 && item.time.compareTo(endDate) <= 0) {
  //       searchData.add(SearchData(
  //           DateFormat('yyyy. MM. dd').format(item.time).toString(),
  //          item.companyName,
  //           (item.face_point + item.voice_point) / 2,
  //           item.face_point,
  //           item.voice_point
  //       ));
  //     }
  //   });
  //
  //   double sumA = 0;
  //   for(int i = 0; i < searchData.length; i++){
  //     sumA = sumA + searchData[i].facescore;
  //   }
  //
  //   double sumB = 0;
  //   for(int i = 0; i < searchData.length; i++){
  //     sumB = sumB + searchData[i].voicescore;
  //   }
  //   if(searchData.length == 0){
  //     Facesum = 0;
  //     Voicesum = 0;
  //     Totalsum = 0;
  //   }
  //   else {
  //     Facesum = sumA / searchData.length;
  //     Voicesum = sumB / searchData.length;
  //     Totalsum = (Facesum + Voicesum) / 2;
  //   }
  //   setState(() {
  //     searchitems.clear();
  //     searchitems.addAll(searchData);
  //
  //   });
  // }

  void get_records(int id) async {
    // print(id);
    String url = 'http://localhost:8000/records/${id}';
    var response = await http.post(Uri.parse(url));
    var statusCode = response.statusCode;
    var responseHeaders = response.headers;
    var responseBody = utf8.decode(response.bodyBytes);



  }

  void get_records_search(int id, DateTime start, DateTime end) async {
    //print(id);
    String url = 'http://localhost:8000/records/search';
    //print(start.millisecondsSinceEpoch);
    //print(end.millisecondsSinceEpoch);
    var jsonEncode2 = jsonEncode({
      "user_id": id,
      "start_date": start.add(Duration(hours : 9)).millisecondsSinceEpoch,
      "end_date":  end.add(Duration(hours : 9)).millisecondsSinceEpoch
    });

    http.Response response = await http.post(Uri.parse(url),
        headers: <String, String>{"content-type": "application/json"},
        body: jsonEncode2);

    var decode = utf8.decode(response.bodyBytes);

    int list_cnt = json.decode(decode).length;
    //print("오잉:${json.decode(decode)[0]['created_at']}");
    //print("내가 원하는 거임 : ${response.body}");
    searchData.clear();

    try{

      //print(decode[0].length);
      for(int i = 0; i < list_cnt; i++){
        DateTime Date = DateTime.parse(json.decode(decode)[i]['created_at']);
        //print(Date);
        //print(Date.add(Duration(hours : 9)));
        String companyName = json.decode(decode)[i]["label"];
        double total_point = json.decode(decode)[i]["total_score"];
        double face_point = json.decode(decode)[i]["face_score"];
        double voice_point = json.decode(decode)[i]["voice_score"];
        int record_index = json.decode(decode)[i]["id"];
        searchData.add(SearchData(
          record_index,
            Date,
            companyName,
            total_point,
            face_point,
            voice_point
        ));
      }
    }
    catch (error) {
      print('기록이 없어서 데이터에 아무것도 안담겨요');
    }

    setState(() {
      searchitems.clear();
      searchitems.addAll(searchData);
    });

  }

}

