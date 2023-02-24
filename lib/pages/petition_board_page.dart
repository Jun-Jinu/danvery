import 'package:flutter/material.dart';
import 'package:danvery/settings/font_size.dart';
import 'package:danvery/settings/palette.dart';
import 'package:danvery/pages/newpost_page.dart';
import 'package:danvery/pages/search_board_page.dart';
import 'package:danvery/pages/petition_post_page.dart';
import 'package:danvery/pages/sliding_button_bar.dart';

class PetitionBoardPage extends StatefulWidget {
  @override
  _PetitionBoardPageState createState() => _PetitionBoardPageState();
}

class _PetitionBoardPageState extends State<PetitionBoardPage> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final categoryButtonWidth = deviceWidth / 5.0;
    final categoryButtonPadding = (deviceWidth - 40.0) / 24.0;

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              SlidingButtonBar(),
              PetitionCard(
                title: "셔틀버스 실시간 위치 정보 공유 청원",
                dueDate: "D - 30",
                petitionPeriod: "2023-01-15 ~ 2023-02-15",
                numberOfPeople: "143",
                petitionStatus: "답변완료",
              ),
              PetitionCard(
                title: "셔틀버스 실시간 위치 정보 공유 청원",
                dueDate: "D - 30",
                petitionPeriod: "2023-01-15 ~ 2023-02-15",
                numberOfPeople: "143",
                petitionStatus: "청원 중",
              ),
              PetitionCard(
                title: "셔틀버스 실시간 위치 정보 공유 청원",
                dueDate: "D - 30",
                petitionPeriod: "2023-01-15 ~ 2023-02-15",
                numberOfPeople: "143",
                petitionStatus: "답변 대기 중",
              ),
              PetitionCard(
                title: "셔틀버스 실시간 위치 정보 공유 청원",
                dueDate: "D - 30",
                petitionPeriod: "2023-01-15 ~ 2023-02-15",
                numberOfPeople: "143",
                petitionStatus: "답변완료",
              ),
              PetitionCard(
                title: "셔틀버스 실시간 위치 정보 공유 청원",
                dueDate: "D - 30",
                petitionPeriod: "2023-01-15 ~ 2023-02-15",
                numberOfPeople: "143",
                petitionStatus: "기간만료",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StatusFillter extends StatelessWidget {
  final double categoryButtonWidth;
  final double categoryButtonPadding;
  final String fillterText;

  const StatusFillter({
    super.key,
    required this.categoryButtonWidth,
    required this.categoryButtonPadding,
    required this.fillterText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: categoryButtonPadding, bottom: 30.0),
      child: SizedBox(
        width: categoryButtonWidth,
        height: 30,
        child: ElevatedButton(
          child: Text(
            fillterText,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Palette.blue,
            foregroundColor: Palette.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}

class PetitionCard extends StatelessWidget {
  final String title; // 제목
  final String dueDate; // 마감 일자
  final String petitionPeriod; // 청원 기간
  final String numberOfPeople; // 참여 인원
  final String petitionStatus; // 청원 상태

  const PetitionCard({
    super.key,
    required this.title,
    required this.dueDate,
    required this.petitionPeriod,
    required this.numberOfPeople,
    required this.petitionStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15.0),
      child: InkWell(
        onTap: () => {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => PetitionPostPage()))
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: petitionStatus == "답변완료" // 답변완료의 경우 테두리가 파란색으로 강조
                ? BorderSide(
                    color: Palette.lightBlue,
                  )
                : BorderSide.none,
          ),
          elevation: petitionStatus == "답변완료" ? 0 : 4.0, // 답변완료의 경우 카드 그림자 없음

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
                  title,
                  style: TextStyle(
                    color: Palette.black,
                    fontSize: FontSize.titleFont,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    dueDate,
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
                        numberOfPeople + "명",
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
                        petitionPeriod,
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
                        petitionStatus,
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
    );
  }
}
