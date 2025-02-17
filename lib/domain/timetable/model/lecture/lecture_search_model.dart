
import 'schedule_time.dart';

class LectureSearchModel{
  String? major;
  String? grade;
  String lectureCode;
  String name;
  String? category;
  String? professor;
  int? classNumber;
  int? credit;
  List<ScheduleTime> times;

  LectureSearchModel({
    required this.lectureCode,
    required this.name,
    this.category,
    this.professor,
    this.classNumber,
    this.credit,
    required this.times,
    this.major,
  });

  factory LectureSearchModel.fromJson(Map<String, dynamic> json) {
    return LectureSearchModel(
      lectureCode: json['lectureCode'] as String,
      name: json['name'] as String,
      category: json['category'] as String?,
      professor: json['professor'] as String?,
      classNumber: json['classNumber'] as int,
      credit: json['credit'] as int,
      times: (json['times'] as List).map((e) => ScheduleTime.fromJson(e)).toList(),
      major: json['major'] as String?,
    );
  }

}
