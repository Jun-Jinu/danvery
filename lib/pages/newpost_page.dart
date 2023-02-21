import 'package:danvery/settings/palette.dart';
import 'package:danvery/settings/font_size.dart';
import 'package:danvery/settings/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class NewpostPage extends StatefulWidget {
  @override
  _NewpostPageState createState() => _NewpostPageState();
}

class _NewpostPageState extends State<NewpostPage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

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
                onPressed: () => {Navigator.pop(context)}),
            title: Text(
              '자유게시판',
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
              enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
              hintText: '제목',
            )),
            Divider(thickness: 1, color: Palette.brightGrey),
            TextField(
                maxLines: 10,
                decoration: InputDecoration(
                  enabledBorder:
                      OutlineInputBorder(borderSide: BorderSide.none),
                  hintText: '내용',
                )),
            Divider(thickness: 1, color: Palette.brightGrey),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "사진 첨부하기",
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
                        onPressed: () {},
                        icon: Icon(
                          Icons.image_outlined,
                          color: Palette.grey,
                        ))),
              ],
            ),
            ElevatedButton(
              child: Text("게시글 업로드"),
              style: ElevatedButton.styleFrom(
                  fixedSize: Size(screenWidth, 60),
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
