import 'package:danvery/settings/font_size.dart';
import 'package:danvery/settings/palette.dart';
import 'package:danvery/pages/newpost_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class PetitionPostPage extends StatefulWidget {
  @override
  _PetitionPostPageState createState() => _PetitionPostPageState();
}

class _PetitionPostPageState extends State<PetitionPostPage> {
  @override
  Widget build(BuildContext context) {
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
              '청원게시판',
              style: TextStyle(
                fontSize: FontSize.titleFont,
                color: Palette.black,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
      ),
      body: const PetitionPostView(
        title: '여기는 제목 1',
        poster: '123',
        content: '여기는 내용이 나올 곳',
        publishDate: " 날짜는 01/15 12:39",
        commentCnt: 3,
        likeCnt: 10,
      ),
    );
  }
}

class PetitionPostView extends StatelessWidget {
  final String title;
  final String poster; // 글쓴이
  final String content;
  final String? publishDate; // null 수정 예정
  final String? imageUrl;
  final int? commentCnt;
  final int? likeCnt;

  const PetitionPostView(
      {super.key,
      required this.title,
      required this.poster,
      required this.content,
      this.publishDate,
      this.imageUrl,
      this.commentCnt,
      this.likeCnt});

  @override
  Widget build(BuildContext context) {
    void dialog() {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              icon: Icon(
                Icons.check_circle_outline,
                color: Colors.blue,
                size: 30.0,
              ),
              title: Text("동의가 완료되었습니다."),
            );
          });
    }

    TextEditingController agreementTextController = TextEditingController();
    String agreement = "동의합니다.";

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "[학생복지]",
            style: TextStyle(
              color: Palette.lightBlue,
              fontSize: FontSize.lightFont,
            ),
          ),
          Text(
            "셔틀버스 실시간 위치 정보 공유 청원",
            style: TextStyle(
              color: Palette.black,
              fontSize: FontSize.titleFont,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "청원기간",
                    style: TextStyle(
                      color: Palette.grey,
                      fontSize: FontSize.regularFont,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  flex: 1,
                ),
                Expanded(
                  child: Text(
                    "2023-01-15 ~ 2023-02-15",
                    style: TextStyle(
                      color: Palette.grey,
                      fontSize: FontSize.regularFont,
                    ),
                  ),
                  flex: 4,
                ),
                Expanded(
                  child: Text(
                    "청원상태",
                    style: TextStyle(
                      color: Palette.grey,
                      fontSize: FontSize.regularFont,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  flex: 1,
                ),
                Expanded(
                  child: Text(
                    "답변완료",
                    style: TextStyle(
                      color: Palette.blue,
                      fontSize: FontSize.regularFont,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  flex: 1,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Divider(thickness: 1, color: Palette.brightGrey),
          ),
          Container(
            padding: const EdgeInsets.only(top: 10.0, bottom: 40.0),
            child: Text(content),
          ),
          Row(
            children: [
              Text(
                "참여인원 ",
                style: TextStyle(
                  color: Palette.grey,
                  fontSize: FontSize.titleFont,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "10명",
                style: TextStyle(
                  color: Palette.blue,
                  fontSize: FontSize.titleFont,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 5,
                  child: Container(
                    height: 50,
                    child: TextField(
                      controller: agreementTextController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 3,
                            color: Palette.brightGrey,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 3,
                            color: Palette.brightGrey,
                          ),
                        ),
                        hintText: '동의합니다.',
                        hintStyle: TextStyle(
                          color: Palette.brightGrey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 50,
                    padding: const EdgeInsets.only(left: 10.0),
                    child: ElevatedButton(
                      child: Text(
                        "동의",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () => {dialog()},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Palette.blue,
                        foregroundColor: Palette.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(thickness: 5, color: Palette.brightGrey),

          //여기서부터 댓글 위젯
          ListTile(
            title: Text(
              "OO과",
              style: TextStyle(
                color: Palette.black,
                fontSize: FontSize.titleFont,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              "동의합니다.",
              style: TextStyle(
                color: Palette.black,
                fontSize: FontSize.titleFont,
              ),
            ),
            trailing: Text(
              "01/15 12:39",
              style: TextStyle(
                color: Palette.lightGrey,
                fontSize: FontSize.titleFont,
              ),
            ),
          ),
          Divider(
            thickness: 1,
            color: Palette.brightGrey,
          ),
        ],
      ),
    );
  }
}
