import 'package:coacheers/component/web_kakaoLogin.dart';
import 'package:coacheers/login/loginPage.dart';
import 'package:coacheers/onwillpop.dart';
import 'package:coacheers/compress.dart';
import 'package:coacheers/record/result.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

void main() {
  KakaoSdk.init(nativeAppKey: '2b589948139859bf81d448bd9c18ea11');
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
