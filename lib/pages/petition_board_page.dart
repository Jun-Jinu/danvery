import 'package:flutter/material.dart';
import 'package:danvery/settings/font_size.dart';
import 'package:danvery/settings/palette.dart';
import 'package:danvery/pages/newpost_page.dart';
import 'package:danvery/pages/search_board_page.dart';
import 'package:danvery/pages/petition_post_page.dart';

class PetitionBoardPage extends StatefulWidget {
  @override
  _PetitionBoardPageState createState() => _PetitionBoardPageState();
}

class _PetitionBoardPageState extends State<PetitionBoardPage> {
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
              style: TextStyle(fontSize: 20, color: Palette.black),
            ),
            actions: [
              IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Palette.grey,
                  ),
                  onPressed: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchBoardPage()))
                      }),
              IconButton(
                  icon: Icon(
                    Icons.mode_edit_outline,
                    color: Palette.grey,
                  ),
                  onPressed: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NewpostPage()))
                      }),
            ],
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
      ),
      body: Column(
        children: [
          InkWell(
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PetitionPostPage()))
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
                // side: BorderSide(
                //   color: Palette.lightBlue,
                // ), + elevation 0으로 바꾼것이 답변완료가 되도록
              ),
              elevation: 4.0,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
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
                      child: Text(
                        "D - 30",
                        style: TextStyle(
                          color: Palette.grey,
                          fontSize: FontSize.titleFont,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Row(
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
                          flex: 4,
                        ),
                        Expanded(
                          child: Text(
                            "참여인원",
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
                            "143명",
                            style: TextStyle(
                              color: Palette.grey,
                              fontSize: FontSize.regularFont,
                            ),
                          ),
                          flex: 1,
                        ),
                      ],
                    ),
                    Row(
                      children: [
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
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
