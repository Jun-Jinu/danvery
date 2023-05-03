
import 'package:danvery/domain/board/post/general_post/model/general_post_model.dart';

class UserPostListModel{
  int totalElements;
  int page;
  int size;
  int totalPages;
  bool last;
  bool first;
  bool hasNext;
  List<GeneralPostModel> generalPosts;

  UserPostListModel({
    required this.totalElements,
    required this.page,
    required this.size,
    required this.totalPages,
    required this.last,
    required this.first,
    required this.hasNext,
    required this.generalPosts,
  });

  factory UserPostListModel.fromJson(Map<String, dynamic> json) {
    return UserPostListModel(
      totalElements: json['totalElements'],
      page: json['page'],
      size: json['size'],
      totalPages: json['totalPages'],
      last: json['last'],
      first: json['first'],
      hasNext: json['hasNext'],
      generalPosts: (json['content'] as List).map((e) => GeneralPostModel.fromJson(e)).toList(),
    );
  }

}
