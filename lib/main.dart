import 'package:coacheers/login/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

var logger = Logger();

void main() {
  KakaoSdk.init(nativeAppKey: '2b589948139859bf81d448bd9c18ea11');
  runApp(const MyApp());
}

// void _post_user_info(String string) async {
//   String url = 'http://localhost:8000/users/';
//   var jsonEncode2 = jsonEncode({ "email": string,});
//   http.Response response = await http.post(
//     Uri.parse(url),
//     headers: <String,String> {
//       "content-type" : "application/json"
//     },
//     body: jsonEncode2
//   );
//   var decode = utf8.decode(response.bodyBytes);
//   print("Response : ${response.statusCode} ${decode}");
//   print(response.headers);
// }

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
