import 'package:flutter/material.dart';
import 'package:danvery/settings/font_size.dart';
import 'package:danvery/settings/palette.dart';

class SearchBoardPage extends StatefulWidget {
  @override
  _SearchBoardPageState createState() => _SearchBoardPageState();
}

class _SearchBoardPageState extends State<SearchBoardPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController searchTextController = TextEditingController();

    void clearSearchText() {
      searchTextController.clear();
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
                onPressed: () => {Navigator.pop(context)}),
            title: TextFormField(
              controller: searchTextController,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Palette.whiteGrey,
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  hintText: '글의 제목, 내용, 키워드를 입력하세요',
                  hintStyle: TextStyle(color: Palette.grey),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.cancel),
                    onPressed: () => {clearSearchText()},
                  )),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
      ),
      body: Center(
        child: Text(
          "자유게시판에서\n원하는 글을 검색해보세요",
          style: TextStyle(
            color: Palette.lightGrey,
            fontSize: FontSize.titleFont,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
