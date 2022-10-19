import 'package:coacheers/component/coachingday.dart';
import 'package:coacheers/component/piechart.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // body: ListView.builder(
      //     padding: const EdgeInsets.only(bottom: kFloatingActionButtonMargin + 48),
      //     itemCount: 23,
      //     itemBuilder: (context, index) => ListTile(
      //       trailing: Text('$index'),
      //     )),
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
              height: 200,
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(5),
              // decoration: BoxDecoration(
              //     color: Colors.white,
              //     border: Border.all(
              //       color: Colors.black,
              //       width: 5,
              //     )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 20),
                    child: Row(
                      children: [
                        Image(
                            image: AssetImage('assets/recent.png'), width: 24),
                        Container(
                          // decoration: BoxDecoration(
                          //     color: Colors.white,
                          //     border: Border.all(
                          //       color: Colors.red,
                          //       width: 5,
                          //     )),
                          child: Text(
                            "최근 코치 기록",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // decoration: BoxDecoration(
                    //     color: Colors.white,
                    //     border: Border.all(
                    //       color: Colors.blue,
                    //       width: 5,
                    //     )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: CustomPaint(
                                    // CustomPaint를 그리고 이 안에 차트를 그려줍니다..
                                    size: Size(100, 100),
                                    // CustomPaint의 크기는 가로 세로 150, 150으로 합니다.
                                    painter: PieChart(
                                        percentage: 68,
                                        textScaleFactor: 0.5,
                                        textColor: Colors.black),
                                  ),
                                ),
                              ),
                              Text(
                                "Total",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: CustomPaint(
                                    // CustomPaint를 그리고 이 안에 차트를 그려줍니다..
                                    size: Size(100, 100),
                                    // CustomPaint의 크기는 가로 세로 150, 150으로 합니다.
                                    painter: PieChart(
                                        percentage: 75,
                                        textScaleFactor: 0.5,
                                        textColor: Colors.black),
                                  ),
                                ),
                              ),
                              Text(
                                "표정",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: CustomPaint(
                                    // CustomPaint를 그리고 이 안에 차트를 그려줍니다..
                                    size: Size(100, 100),
                                    // CustomPaint의 크기는 가로 세로 150, 150으로 합니다.
                                    painter: PieChart(
                                        percentage: 56,
                                        textScaleFactor: 0.5,
                                        textColor: Colors.black),
                                  ),
                                ),
                              ),
                              Text(
                                "목소리",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
            height: 360,
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 20),
                  child: Row(
                    children: [
                      Image(
                          image: AssetImage('assets/calendar.png'), width: 24),
                      Container(
                        // decoration: BoxDecoration(
                        //     color: Colors.white,
                        //     border: Border.all(
                        //       color: Colors.red,
                        //       width: 5,
                        //     )),
                        child: Text(
                          "이번달 출석부",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  // decoration: BoxDecoration(
                  //     color: Colors.white,
                  //     border: Border.all(
                  //       color: Colors.red,
                  //       width: 5,
                  //     )),
                  child: SfCalendar(
                    view: CalendarView.month,
                    todayHighlightColor: Color(0xff4F98FF),
                    cellBorderColor: Colors.white,
                    headerHeight: 0,
                    dataSource: MeetingDataSource.test(),
                    monthViewSettings: MonthViewSettings(
                      //appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
                      //showAgenda: true,
                      appointmentDisplayCount: 1,
                    ),
                  ),
                  // child: TableCalendar(
                  //   firstDay: DateTime.utc(2010, 10, 16),
                  //   lastDay: DateTime.utc(2030, 3, 14),
                  //   focusedDay: DateTime.now(),
                  //   headerVisible: false,
                  //
                  //   calendarBuilders:
                  //   CalendarBuilders(markerBuilder: (context, date, dynamic event) {
                  //     if (event.isNotEmpty) {
                  //       return Container(
                  //         width: 35,
                  //         decoration: BoxDecoration(
                  //             color: Colors.blue.withOpacity(0.2),
                  //             shape: BoxShape.circle),
                  //       );
                  //     }
                  //   }),
                  // ),
                ),
              ],
            ),
            // decoration: BoxDecoration(
            //     color: Colors.white,
            //     border: Border.all(
            //       color: Colors.blue,
            //       width: 5,
            //     )),
            // // child:  Image(
            // //     image: AssetImage('assets/Group 3003.png'), width: 300),)
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
            height: 200,
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(5),
            child: Text('일간 기록'),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.blue,
                  width: 5,
                )),
            // child:  Image(
            // image: AssetImage('assets/Group 3004.png'), width: 300),
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
            height: 200,
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(5),
            child: Text('주간 간단 피드백'),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.blue,
                  width: 5,
                )),
            // child:  Image(
            // image: AssetImage('assets/Group 3005.png'), width: 300),
          ),
        ],
      ),
    );
  }
}
