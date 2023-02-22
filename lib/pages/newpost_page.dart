import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:danvery/settings/font_size.dart';
import 'package:danvery/settings/palette.dart';

import 'dart:io';
import 'package:image_picker/image_picker.dart';

class NewpostPage extends StatefulWidget {
  @override
  _NewpostPageState createState() => _NewpostPageState();
}

class _NewpostPageState extends State<NewpostPage> {
  final changedContent = false; //변경된 내용이 있으면 true
  final ImagePicker _picker = ImagePicker();
  List<XFile> _pickedImgs = []; // 이미지 저장 배열

  Future<void> _pickImg() async {
    //이미지 업로드 함수
    final List<XFile>? images = await _picker.pickMultiImage();
    if (images != null) {
      setState(() {
        _pickedImgs = images;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    void backButtonDialog() {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: Text("작성한 내용이 지워집니다.\n나가시겠습니까?"),
              actions: [
                CupertinoDialogAction(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "취소",
                      style: TextStyle(color: Palette.black),
                    )),
                CupertinoDialogAction(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: Text(
                      "나가기",
                      style: TextStyle(color: Palette.blue),
                    )),
              ],
            );
          });
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: AppBar(
            leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Palette.black,
                ),
                onPressed: () => backButtonDialog()),
            title: Text(
              '글 작성하기',
              style: TextStyle(fontSize: 20, color: Palette.black),
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: <Widget>[
            TextField(
                decoration: InputDecoration(
              border: OutlineInputBorder(borderSide: BorderSide.none),
              hintText: '제목',
            )),
            Divider(thickness: 1, color: Palette.brightGrey),
            TextField(
                maxLines: 20,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  hintText: '내용',
                )),
            Divider(thickness: 1, color: Palette.brightGrey),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "사진 첨부하기",
                  style: TextStyle(
                      fontSize: FontSize.regularFont,
                      fontWeight: FontWeight.bold,
                      color: Palette.grey),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    width: 80,
                    height: 80,
                    margin:
                        EdgeInsets.only(top: 10.0, right: 10.0, bottom: 30.0),
                    decoration: BoxDecoration(
                      color: Palette.whiteGrey,
                    ),
                    child: IconButton(
                        onPressed: () => _pickImg(),
                        icon: Icon(
                          Icons.image_outlined,
                          color: Palette.grey,
                        ))),
              ],
            ),
            ElevatedButton(
              child: Text("게시글 업로드"),
              style: ElevatedButton.styleFrom(
                  fixedSize: Size(screenWidth, 50),
                  textStyle: const TextStyle(fontSize: FontSize.regularFont),
                  backgroundColor: Palette.blue),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
