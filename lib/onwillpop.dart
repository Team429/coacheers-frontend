import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:coacheers/coaching/coachingEndPage.dart';
import 'package:coacheers/coaching/coachingSavePage.dart';
import 'package:http/http.dart' as http;
import 'package:video_uploader/video_uploader.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

const primaryColor = Color(0xFFFA5B30);
const secondaryColor = Color(0xFFFFB39E);
String Server_URL = 'https://4e23-220-117-14-181.jp.ngrok.io';

class upload extends StatefulWidget {
  @override
  _uploadState createState() => _uploadState();
}

class _uploadState extends State<upload> {
  var _imagePath;
  final _tokenTextController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  double _progressValue = 0;
  late int video_id = 0;

  void setProgress(double value) async {
    this.setState(() {
      this._progressValue = value;
    });
  }

  @override
  void dispose() {
    _tokenTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primaryColor: primaryColor,
        ),
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColor,
            title: const Text('Uploader Example'),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 52,
                  ),
                  TextField(
                    cursorColor: primaryColor,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colors.white, width: 2.0)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: primaryColor, width: 2.0)),
                      hintText: 'My video token',
                    ),
                    controller: _tokenTextController,
                  ),
                  MaterialButton(
                    color: primaryColor,
                    child: Text(
                      "Pick Video from Gallery",
                      style: TextStyle(
                          color: Colors.white70, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () async {
                      var source = ImageSource.gallery;
                      XFile? image = await _picker.pickVideo(source: source);
                      if (image != null) {
                        print(image.path);
                        setState(() {
                          try {
                            _imagePath = image.path;
                          } catch (e) {
                            log("Failed to get video: $e");
                          }
                        });
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CoachingEnd(
                                id: 1,
                                name: "서동원",
                                profileURL: 'www',
                                filePath: '/assets/videos/Test2.mp4')
                        ),
                      );
                    },
                  ),
                  MaterialButton(
                    color: primaryColor,
                    child: Text(
                      "Upload video",
                      style: TextStyle(
                          color: Colors.white70, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () async {
                      var source = ImageSource.gallery;
                      XFile? image = await _picker.pickVideo(source: source);
                      if (image != null) {
                        print(image.path);
                        setState(() {
                          try {
                            _imagePath = image.path;
                          } catch (e) {
                            log("Failed to get video: $e");
                          }
                        });
                      }
                      print(_imagePath);
                      _onLoading();
                      video_id = await multipartProdecudre(_imagePath);
                      _post_record_info(1, "Test2", "/assets/videos/Test2.mp4", video_id);
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              fullscreenDialog: true,
                              builder: (_) => //VideoPage(filePath: file.path),
                                  //VideoPage(filePath: widget.filePath, name: _commentController.text),
                                  coachingSave(
                                      id: 1,
                                      comment: "Test2",
                                      name: "서동원",
                                      profileURL: "www",
                                      filePath: _imagePath)));
                    },
                  ),
                  LinearProgressIndicator(
                    color: primaryColor,
                    backgroundColor: secondaryColor,
                    value: _progressValue,
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Future<int> multipartProdecudre(String filepath) async {
    String url = '${Server_URL}/videos/';
    DateTime now = DateTime.now();
    String isoDate = now.toIso8601String();

    //for multipartrequest
    var request = http.MultipartRequest('POST', Uri.parse(url));

    //for token
    //request.headers.addAll({"Authorization": "Bearer token"});

    //for image and videos and files
    request.fields['file_path'] = filepath;
    request.fields['create_at'] = isoDate;
    request.files.add(await http.MultipartFile.fromPath(
        'video', "/Users/seodongwon/coacheers/assets/videos/Test.mp4"));

    //for completeing the request

    var response = await request.send();

    //for getting and decoding the response into json format
    var responsed = await http.Response.fromStream(response);
    final responseData = json.decode(responsed.body);

    video_id = await responseData['video_id'];

    return video_id;

    // if (response.statusCode==200) {
    //   print("SUCCESS");
    //   print(responseData['video_id']);
    //
    // }
    // else {
    //   print("ERROR");
    // }
  }

  void _post_record_info(
      int id, String companyName, String filepath, int video_id) async {
    String url = '${Server_URL}/records/';
    DateTime Date = DateTime.now();
    var jsonEncode2 = jsonEncode({
      "user_id": id,
      "created_at": Date.add(Duration(hours: 9)).millisecondsSinceEpoch,
      "label": companyName,
      "filepath": filepath,
      "video_id": video_id,
      "voice_score": 0
    });
    http.Response response = await http.post(Uri.parse(url),
        headers: <String, String>{"content-type": "application/json"},
        body: jsonEncode2);
    var decode = utf8.decode(response.bodyBytes);
    print("Response : ${response.statusCode} ${decode}");
    print(response.headers);

    //print(filepath);
  }

  void _onLoading() {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      // barrierColor: null,
      builder: (BuildContext context) {
        return Dialog(
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 10),
                child: new CircularProgressIndicator(),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: new Text("면접 결과를 저장중입니다.",
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                child: new Text("30 ~ 40초정도 소요 됩니다.",
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        );
      },
    );
  }
}
