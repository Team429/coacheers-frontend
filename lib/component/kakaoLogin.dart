import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:coacheers/frame/mainFrame.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

String user_code = "";
String name = "";
String profileURL = "";
int id = 0;

// void _get_user_info() async {
//   try {
//     User user = await UserApi.instance.me();
//     user_code = user.id.toString();
//     name = (user.kakaoAccount?.profile?.nickname).toString();
//     profileURL = (user.kakaoAccount?.profile?.thumbnailImageUrl).toString();
//     //print("user_code${user_code}");
//     _post_user_info(user_code);
//     // print('사용자 정보 요청 성공'
//     //     '\n회원번호: ${user.id}'
//     //     '\n닉네임: ${user.kakaoAccount?.profile?.nickname}');
//   } catch (error) {
//     print('사용자 정보 요청 실패 $error');
//   }
// }

// Future<int> get_user_me(String user_code) async {
//   String url = 'http://localhost:8000/users';
//   var response = await http.get(Uri.parse(url));
//   //var statusCode = response.statusCode;
//   //var responseHeaders = response.headers;
//   var responseBody = utf8.decode(response.bodyBytes);
//   var id;
//
//   final user = jsonDecode(responseBody);
//
//   //print("statusCode: ${statusCode}");
//   //print("responseHeader: ${responseHeaders}");
//   //print("responseBody: ${responseBody}");
//
//   print(user[0]['email']);
//   for(int i = 0; i< user.length; i++){
//     if(user[i]['email'] == user_code){
//       print("db유저 아이디값: ${user[i]['id']}");
//       id = user[i]['id'];
//     }
//   }
//   return id;
//   //print(responseBody[0]);
//
//   // Map<String, dynamic> user_info = jsonDecode(user['1']);
//   // print(user_info['name']);
// }

void _post_user_info(String string) async {
  String url = 'http://localhost:8000/users/';
  var jsonEncode2 = jsonEncode({
    "email": string,
  });
  http.Response response = await http.post(Uri.parse(url),
      headers: <String, String>{"content-type": "application/json"},
      body: jsonEncode2);
  var decode = utf8.decode(response.bodyBytes);
  print("Response : ${response.statusCode} ${decode}");
  print(response.headers);
  print("user info post 완료");
}

void _post_attendance_info(int id) async {
  String url = 'http://localhost:8000/attendances/';
  var jsonEncode2 = jsonEncode({
    "user_id": id,
    "created_at": DateTime.now().millisecondsSinceEpoch,
  });
  http.Response response = await http.post(Uri.parse(url),
      headers: <String, String>{"content-type": "application/json"},
      body: jsonEncode2);
  var decode = utf8.decode(response.bodyBytes);
  print("Response : ${response.statusCode} ${decode}");
  print(response.headers);
  print("attendance info post 완료");
}

void KakaoLogin(context) async {
  // 카카오 로그인 구현 예제
  // 카카오톡 실행 가능 여부 확인
  // 카카오톡 실행이 가능하면 카카오톡으로 로그인, 아니면 카카오계정으로 로그인
  if (await isKakaoTalkInstalled()) {
    try {
      await UserApi.instance.loginWithKakaoTalk();
      //카카오 로그인 화면 호출 -> 사용자가 토큰 가져오는 것 까지
      print('카카오톡으로 로그인 성공');
      User user = await UserApi.instance.me();
      user_code = user.id.toString();
      name = (user.kakaoAccount?.profile?.nickname).toString();
      profileURL = (user.kakaoAccount?.profile?.thumbnailImageUrl).toString();
      _post_user_info(user_code);

      String url = 'http://localhost:8000/users';
      var response = await http.get(Uri.parse(url));
      var responseBody = utf8.decode(response.bodyBytes);
      final userinfo = jsonDecode(responseBody);

      //print(userinfo[0]['email']);
      for(int i = 0; i< userinfo.length; i++){
        if(userinfo[i]['email'] == user_code){
          //print("db유저 아이디값: ${userinfo[i]['id']}");
          id = userinfo[i]['id'];
        }
      }
      //print("id : ${id}");

      _post_attendance_info(id);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => MainFrame(id : id, name: name,profileURL: profileURL,subindex: 2,)),
      );
    } catch (error) {
      print('카카오톡으로 로그인 실패 $error');

      // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서
      // 로그인을 취소한 경우,
      // 의도적인 로그인 취소로 보고 카카오계정으로
      // 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
      if (error is PlatformException && error.code == 'CANCELED') {
        return;
      }
      // 카카오톡이 실행이 가능하지만,
      // 카카오톡에 연결된 카카오계정이 없는 경우,
      // 카카오계정으로 로그인
      try {
        await UserApi.instance.loginWithKakaoAccount();
        print('카카오계정으로 로그인 성공');
        User user = await UserApi.instance.me();
        user_code = user.id.toString();
        name = (user.kakaoAccount?.profile?.nickname).toString();
        profileURL = (user.kakaoAccount?.profile?.thumbnailImageUrl).toString();

        _post_user_info(user_code);

        String url = 'http://localhost:8000/users';
        var response = await http.get(Uri.parse(url));
        var responseBody = utf8.decode(response.bodyBytes);
        final userinfo = jsonDecode(responseBody);

        //print(userinfo[0]['email']);
        for(int i = 0; i< userinfo.length; i++){
          if(userinfo[i]['email'] == user_code){
            //print("db유저 아이디값: ${userinfo[i]['id']}");
            id = userinfo[i]['id'];
          }
        }
        //print("id : ${id}");

        _post_attendance_info(id);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => MainFrame(id : id, name: name,profileURL: profileURL,subindex: 2,)),
        );
      } catch (error) {
        print('카카오계정으로 로그인 실패 $error');
      }
    }
    //카카오톡이 디바이스에서 실행되지 않는 경우
  } else {
    try {
      await UserApi.instance.loginWithKakaoAccount();
      print('카카오계정으로 로그인 성공');
      User user = await UserApi.instance.me();
      user_code = user.id.toString();
      name = (user.kakaoAccount?.profile?.nickname).toString();
      profileURL = (user.kakaoAccount?.profile?.thumbnailImageUrl).toString();

      _post_user_info(user_code);

      String url = 'http://localhost:8000/users';
      var response = await http.get(Uri.parse(url));
      var responseBody = utf8.decode(response.bodyBytes);
      final userinfo = jsonDecode(responseBody);

      //print(userinfo[0]['email']);
      for(int i = 0; i< userinfo.length; i++){
        if(userinfo[i]['email'] == user_code){
          //print("db유저 아이디값: ${userinfo[i]['id']}");
          id = userinfo[i]['id'];
        }
      }
      //print("id : ${id}");

      _post_attendance_info(id);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => MainFrame(id : id, name: name,profileURL: profileURL, subindex: 2,)),
      );
    } catch (error) {
      print('카카오계정으로 로그인 실패 $error');
    }
  }
}
