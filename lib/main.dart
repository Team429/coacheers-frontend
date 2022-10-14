import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:math';


int _selectedIndex = 3;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainFrame extends StatefulWidget {
  const MainFrame({Key? key}) : super(key: key);

  @override
  State<MainFrame> createState() => _MainFrameWidget();
}

class _MainFrameWidget extends State<MainFrame> {
// 탭을 이동할 때 쓸 변수!

  static const TextStyle optionStyle =
      TextStyle(fontSize: 40, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    RecordPage(),
    CoachingPage(),
    Profile(),
    Home(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Coacheers",
          style: TextStyle(
              color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
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
              _onItemTapped(3);
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => Home()),
              //);
            },
          ),
        ],
        backgroundColor: Color(0xfffffffff),
        elevation: 0.0,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
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
                        _onItemTapped(0);
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
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 30),
              child: FloatingActionButton.extended(
                elevation: 4.0,
                icon: const Icon(
                  Icons.wifi_tethering,
                ),
                heroTag: "coaching start",
                label: Text("모의 면접 코칭 시작"),
                onPressed: () {
                  _onItemTapped(1);
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
                        _onItemTapped(2);
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
            ),
          ],
        ),
        // child: BottomNavigationBar(
        //   type: BottomNavigationBarType.fixed,
        //   backgroundColor: Color(0xff1877F2),
        //   selectedItemColor: Colors.white,
        //   unselectedItemColor: Colors.white.withOpacity(.60),
        //   items:  <BottomNavigationBarItem>[
        //     BottomNavigationBarItem(
        //       icon: Padding(
        //         padding: const EdgeInsets.fromLTRB(0,10,0,0),
        //         child: Container(
        //             // decoration: BoxDecoration(
        //             //     color: Colors.white,
        //             //     border: Border.all(
        //             //       color: Colors.black,
        //             //       width: 1,
        //             //     )),
        //             child: Icon(Icons.history, size: 24)),
        //       ),
        //       label: '기록',
        //     ),
        //     // BottomNavigationBarItem(
        //     //   icon: Padding(
        //     //     padding: const EdgeInsets.fromLTRB(0,10,0,0),
        //     //     child: Container(
        //     //       decoration: BoxDecoration(
        //     //           color: Colors.white,
        //     //           border: Border.all(
        //     //             color: Colors.black,
        //     //             width: 1,
        //     //           )),
        //     //       child: Row(
        //     //         children: [
        //     //           Icon(Icons.wifi_tethering, size: 24),
        //     //           Padding(padding: EdgeInsets.fromLTRB(0, 0, 4, 0)),
        //     //           Text(
        //     //             "모의 면접 코칭 시작",
        //     //             style: TextStyle(
        //     //               color: Colors.white,
        //     //               fontSize: 13,
        //     //               fontWeight: FontWeight.w400,
        //     //             ),
        //     //           ),
        //     //         ],
        //     //       ),
        //     //     ),
        //     //   ),
        //     //   label: '',
        //     // ),
        //     BottomNavigationBarItem(
        //       icon: Padding(
        //         padding: const EdgeInsets.fromLTRB(0,10,0,0),
        //         child: Container(
        //             // decoration: BoxDecoration(
        //             //     color: Colors.white,
        //             //     border: Border.all(
        //             //       color: Colors.black,
        //             //       width: 1,
        //             //     )),
        //             child: Icon(Icons.history, size: 24)),
        //       ),
        //       label: '',
        //
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Padding(
        //         padding: const EdgeInsets.fromLTRB(0,10,0,0),
        //         child: Container(
        //             decoration: BoxDecoration(
        //                 color: Colors.white,
        //                 border: Border.all(
        //                   color: Colors.black,
        //                   width: 1,
        //                 )),
        //             child: Icon(Icons.history, size: 24)),
        //       ),
        //       label: '기록',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Padding(
        //         padding: const EdgeInsets.fromLTRB(0,10,0,0),
        //         child: Container(
        //             // decoration: BoxDecoration(
        //             //     color: Colors.white,
        //             //     border: Border.all(
        //             //       color: Colors.black,
        //             //       width: 1,
        //             //     )),
        //             child: Icon(Icons.person, size: 24)),
        //       ),
        //       label: '마이',
        //     ),
        //   ],
        //   currentIndex: _selectedIndex,
        //   onTap: _onItemTapped,
        //   // 아랫줄을 쓰지 않아도 탭이 4개 미만인 경우 기본으로 설정된다.
        //   // type: BottomNavigationBarType.fixed,
        //
        //   // selectedItemColor: Colors.amber[800],
        //   // unselectedItemColor: Colors.blue,
        //   // backgroundColor: Colors.black,
        // ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: Row(
      //
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     Padding(
      //       padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
      //       child: FloatingActionButton.extended(
      //         elevation: 4.0,
      //         icon: const Icon(
      //           Icons.history,
      //         ),
      //         label: Text(""),
      //         onPressed: () {
      //           _onItemTapped(1);
      //         },
      //       ),
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
      //       child: FloatingActionButton.extended(
      //         elevation: 4.0,
      //         icon: const Icon(
      //           Icons.wifi_tethering,
      //         ),
      //         label: Text("모의 면접 코칭 시작"),
      //         onPressed: () {
      //           _onItemTapped(1);
      //         },
      //       ),
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
      //       child: FloatingActionButton.extended(
      //         elevation: 4.0,
      //         icon: const Icon(
      //           Icons.person,
      //         ),
      //         label: Text(""),
      //         onPressed: () {
      //           _onItemTapped(1);
      //         },
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0xfffffffff),
          elevation: 0.0,
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(
                child: Column(
                  children: [
                    Image(
                        image: AssetImage('assets/Coacheers.png'), width: 300),
                    Text(
                      "Coacheers",
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 80, 0, 0),
                child: SizedBox(
                  width: 300,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                        child: SizedBox(
                          height: 60,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MainFrame()),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image(
                                    image: AssetImage('assets/Facebook.png'),
                                    width: 40,
                                  ),
                                  Text(
                                    "Facebook 로그인",
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  Color(0xff569BF5),
                                ),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        side: BorderSide(
                                            color: Color(0xff569BF5))))),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                        child: SizedBox(
                          height: 60,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MainFrame()),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image(
                                      image: AssetImage('assets/kakaotalk.png'),
                                      width: 40),
                                  Text(
                                    "Kakao 로그인",
                                    style: TextStyle(
                                      color: Color(0xff392020),
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color(0xffFEE500)),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        side: BorderSide(
                                            color: Color(0xffFEE500))))),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainFrame()),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(
                                    image: AssetImage('assets/Google.png'),
                                    width: 40),
                                Text(
                                  "Google 로그인",
                                  style: TextStyle(
                                    color: Color(0xff000000),
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Color(0xffF7F7F7)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      side: BorderSide(
                                          color: Color(0xffF7F7F7))))),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

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
                    padding: const EdgeInsets.fromLTRB(20,0,0,20),
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
                          child : Text("최근 코치 기록", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
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
                              Text("Total", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
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
                              Text("표정", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
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
                              Text("목소리", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
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
            height: 385,
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20,0,0,20),
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
                        child : Text("이번달 출석부", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
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
                  child: TableCalendar(
                    firstDay: DateTime.utc(2010, 10, 16),
                    lastDay: DateTime.utc(2030, 3, 14),
                    focusedDay: DateTime.now(),
                    headerVisible: false,

                    calendarBuilders:
                    CalendarBuilders(markerBuilder: (context, date, dynamic event) {
                      if (event.isNotEmpty) {
                        return Container(
                          width: 35,
                          decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.2),
                              shape: BoxShape.circle),
                        );
                      }
                    }),
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

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Color(0xff1877F2),
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(50),
                      )),
                  child: Column(children: [
                    SizedBox(
                      height: 28.0,
                    ),
                    CircleAvatar(
                      radius: 50.0,
                      backgroundImage: AssetImage('assets/user.jpg'),
                      backgroundColor: Colors.white,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text('사용자',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        )),
                    SizedBox(
                      height: 10.0,
                    ),
                    // Text(
                    //   'S Class Mage',
                    //   style: TextStyle(
                    //     color: Colors.white,
                    //     fontSize: 15.0,
                    //   ),
                    // )
                  ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                child: Container(
                  height: 1.0,
                  width: 300.0,
                  color: Colors.grey,
                ),
              ),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 140,
                            height: 165,
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.all(5),
                            child: Text("이번달 출석률"),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.blue,
                                  width: 5,
                                )),
                          ),
                          Container(
                            width: 140,
                            height: 165,
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.all(5),
                            child: Text("누적 평균 점수"),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.blue,
                                  width: 5,
                                )),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                            child: Container(
                              width: 300,
                              height: 120,
                              margin: EdgeInsets.all(10),
                              padding: EdgeInsets.all(5),
                              child: Text("오늘의 명언"),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.blue,
                                    width: 5,
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CoachingPage extends StatelessWidget {
  const CoachingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(),
    );
  }
}

class RecordPage extends StatefulWidget {
  const RecordPage({Key? key}) : super(key: key);

  @override
  _MyModalPageState createState() => _MyModalPageState();
}

class _MyModalPageState extends State<RecordPage> {
  @override
  void initState() {
    super.initState();
  }

  _showSimpleModalDialog(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: Container(
              constraints: BoxConstraints(maxHeight: 420),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TableCalendar(
                      firstDay: DateTime.utc(2010, 10, 16),
                      lastDay: DateTime.utc(2030, 3, 14),
                      focusedDay: DateTime.now(),
                      headerStyle: HeaderStyle(
                        formatButtonVisible: false,
                        titleCentered: true,
                      ),
                      calendarBuilders:
                      CalendarBuilders(markerBuilder: (context, date, dynamic event) {
                        if (event.isNotEmpty) {
                          return Container(
                            width: 35,
                            decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.2),
                                shape: BoxShape.circle),
                          );
                        }
                      }),
                    ),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("기간별 기록", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                  Row(
                    mainAxisAlignment : MainAxisAlignment.start,
                    children: [
                      Text("2022.09.20 - 2020.09.26 ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                      IconButton(
                        icon : Image.asset('assets/calendar.png'),
                        iconSize: 24,
                        onPressed: () {
                          _showSimpleModalDialog(context);
                        },
                      ),
                    ],
                  )
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

class PieChart extends CustomPainter {
  int percentage = 0;
  double textScaleFactor = 1.0;
  Color textColor;

  PieChart(
      {required this.percentage,
        required this.textScaleFactor,
        required this.textColor});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Color(0xffD8D8D8)
      ..strokeWidth = 10.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    double radius = min(size.width / 2 - paint.strokeWidth / 2,
        size.height / 2 - paint.strokeWidth / 2);
    Offset center = Offset(size.width / 2, size.height / 2);

    canvas.drawCircle(center, radius, paint);
    drawArc(paint, canvas, center, radius);
    drawText(canvas, size, "$percentage%");
  }

  void drawArc(Paint paint, Canvas canvas, Offset center, double radius) {
    double arcAngle = 2 * pi * (percentage / 100);
    paint..color = Color(0xff4F98FF);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        arcAngle, false, paint);
  }

  void drawText(Canvas canvas, Size size, String text) {
    double fontSize = getFontSize(size, text);

    TextSpan sp = TextSpan(
        style: TextStyle(
            fontSize: fontSize, fontWeight: FontWeight.bold, color: textColor),
        text: text);
    TextPainter tp = TextPainter(text: sp, textDirection: TextDirection.ltr);

    tp.layout();
    double dx = size.width / 2 - tp.width / 2;
    double dy = size.height / 2 - tp.height / 2;

    Offset offset = Offset(dx, dy);
    tp.paint(canvas, offset);
  }

  double getFontSize(Size size, String text) {
    return size.width / text.length * textScaleFactor;
  }

  @override
  bool shouldRepaint(PieChart old) {
    return old.percentage != percentage;
  }
}

// class ChartPage extends StatelessWidget {
//   //List<double> points = [50, 0, 73, 100, 150, 120, 200, 80];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Chart Page"),
//       ),
//       body: Container(
//         padding: const EdgeInsets.symmetric(vertical: 8.0),
//         child: Center(
//           child: Column(
//             children: <Widget>[
//               Container(
//                 child: CustomPaint(
//                   // CustomPaint를 그리고 이 안에 차트를 그려줍니다..
//                   size: Size(150, 150),
//                   // CustomPaint의 크기는 가로 세로 150, 150으로 합니다.
//                   painter: PieChart(
//                       percentage: 55,
//                       textScaleFactor: 1.5,
//                       textColor: Colors.blueGrey),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class AppBarArea extends StatelessWidget implements PreferredSizeWidget {
//   const AppBarArea({
//     Key? key,
//     required this.appBar,
//   }) : super(key: key);
//
//   final AppBar appBar;
//
//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       title: Text(
//         "Coacheers",
//         style: TextStyle(
//             color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
//       ),
//       centerTitle: true,
//       actions: [
//         IconButton(
//           icon: Icon(
//             Icons.home_outlined,
//             color: Colors.black,
//             size: 24,
//           ),
//           onPressed: () {
//             _selectedIndex = 3;
//             // Navigator.push(
//             //   context,
//             //   MaterialPageRoute(builder: (context) => Home()),
//           },
//         ),
//       ],
//       backgroundColor: Color(0xfffffffff),
//       elevation: 0.0,
//     );
//   }
//
//   Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
// }

// class HomeAppBarArea extends StatelessWidget implements PreferredSizeWidget {
//   const HomeAppBarArea({
//     Key? key,
//     required this.appBar,
//   }) : super(key: key);
//
//   final AppBar appBar;
//
//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       title: Text(
//         "Coacheers",
//         style: TextStyle(
//             color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
//       ),
//       centerTitle: true,
//       backgroundColor: Color(0xfffffffff),
//       elevation: 0.0,
//       automaticallyImplyLeading: false,
//     );
//   }
//
//   Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
// }

// class BottomBar extends StatelessWidget {
//   const BottomBar({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       child: BottomAppBar(
//         color: Color(0xff1877F2),
//         child: new Row(
//           mainAxisSize: MainAxisSize.max,
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.fromLTRB(20, 5, 0, 0),
//               child: IconButton(
//                 icon: Icon(Icons.history, size: 40, color: Colors.white),
//                 onPressed: () {},
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.fromLTRB(0, 5, 20, 0),
//               child: IconButton(
//                 icon: Icon(Icons.person, size: 40, color: Colors.white),
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => const profile()),
//                   );
//                 },
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// class BottomButton extends StatelessWidget {
//   const BottomButton({
//     Key? key,
//     required this.text,
//   }) : super(key: key);
//   final String text;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(0, 65, 0, 0),
//       child: FloatingActionButton.extended(
//         elevation: 4.0,
//         icon: const Icon(
//           Icons.wifi_tethering,
//         ),
//         label: Text("$text"),
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => const CoachingPage()),
//           );
//         },
//       ),
//     );
//   }
// }
