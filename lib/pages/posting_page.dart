import 'package:danvery/settings/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class PostingPage extends StatelessWidget {
  const PostingPage({super.key});

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
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
        body: const PostingView(
          title: '여기는 제목 1',
          poster: '123',
          content: '여기는 내용이 나올 곳',
          publishDate: " 날짜는 01/15 12:39",
          commentCnt: 3,
          likeCnt: 10,
        ),
      ),
    );
  }
}

class PostingView extends StatelessWidget {
  final String title;
  final String poster; // 글쓴이
  final String content;
  final String? publishDate; // null 수정 예정
  final String? imageUrl;
  final int? commentCnt;
  final int? likeCnt;

  const PostingView(
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
            return CupertinoAlertDialog(
              title: Text("작성한 댓글이 지워집니다.\n삭제하시겠습니까?"),
              actions: [
                CupertinoDialogAction(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("취소")),
                CupertinoDialogAction(
                    onPressed: () {
                      //삭제기능 추가하기
                      Navigator.pop(context);
                    },
                    child: Text(
                      "삭제하기",
                      style: TextStyle(color: Palette.blue),
                    )),
              ],
            );
          });
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: ListTile(
              shape: Border(
                bottom: BorderSide(
                  width: 0.5,
                  color: Palette.lightGrey,
                ),
              ),
              title: Text(title),
              subtitle: Text(poster +
                  " " +
                  (publishDate != null ? publishDate.toString() : "")),
              trailing: GestureDetector(
                  onTap: () => dialog(), child: Icon(Icons.more_vert)),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 10.0, bottom: 40.0),
            child: Text(content),
          ),
          Row(
            children: <Widget>[
              Wrap(
                spacing: 12,
                children: [
                  commentCnt != null
                      ? Row(
                          children: [
                            Icon(Icons.chat_outlined),
                            Text(
                              commentCnt.toString(),
                              style: TextStyle(
                                  fontSize: 20, color: Palette.lightGrey),
                            ),
                          ],
                        )
                      : Row(),
                  likeCnt != null
                      ? Row(
                          children: [
                            Icon(Icons.thumb_up_off_alt),
                            Text(
                              likeCnt.toString(),
                              style: TextStyle(
                                  fontSize: 20, color: Palette.lightGrey),
                            ),
                          ],
                        )
                      : Row(),
                ],
              ),
            ],
          ),
          Divider(thickness: 5, color: Palette.brightGrey),
          Padding(
            //대댓글 컴포넌트
            padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 40.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Palette.whiteGrey,
              ),
              child: Column(
                children: [
                  // 대댓글 Listtile 2개 들어갈 자리
                  ListTile(
                    title: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      content,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.6), fontSize: 15.0),
                    ),
                  ),
                  ListTile(
                    subtitle: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
