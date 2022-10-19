import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import '../frame/mainFrame.dart';

void _get_user_info() async {
  try {
    User user = await UserApi.instance.me();
    print('사용자 정보 요청 성공'
        '\n회원번호: ${user.id}'
        '\n닉네임: ${user.kakaoAccount?.profile?.nickname}');
  } catch (error) {
    print('사용자 정보 요청 실패 $error');
  }
}

void KakaoLogin(context) async {
  // 카카오 로그인 구현 예제
  // 카카오톡 실행 가능 여부 확인
  // 카카오톡 실행이 가능하면 카카오톡으로 로그인, 아니면 카카오계정으로 로그인
  if (await isKakaoTalkInstalled()) {
    try {
      await UserApi.instance.loginWithKakaoTalk();
      print('카카오톡으로 로그인 성공');
      _get_user_info();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MainFrame()),
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
        _get_user_info();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MainFrame()),
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
      _get_user_info();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MainFrame()),
      );
    } catch (error) {
      print('카카오계정으로 로그인 실패 $error');
    }
  }
}