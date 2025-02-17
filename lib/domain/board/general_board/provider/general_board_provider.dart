import 'package:danvery/domain/board/general_board/model/general_board_model.dart';
import 'package:danvery/core/dto/api_response_dto.dart';
import 'package:danvery/core/dto/exception/exception_response_dto.dart';
import 'package:danvery/core/dto/success/success_response_dto.dart';
import 'package:danvery/core/interceptor/dio_interceptor.dart';
import 'package:dio/dio.dart';

class GeneralBoardProvider {
  final Dio _dio;

  GeneralBoardProvider._internal(this._dio);

  static final GeneralBoardProvider _singleton =
      GeneralBoardProvider._internal(DioInterceptor().dio);

  factory GeneralBoardProvider() => _singleton;

  Future<ApiResponseDTO> getGeneralBoard(
      String accessToken, int page, int size, String keyword) async {
    String url =
        '/post/general-forum?page=$page&size=$size&keyword=$keyword&sort=createdAt,desc&bodySize=200';

    final headers = {
      'Authorization': "Bearer $accessToken",
    };

    try {
      final Response response = await _dio.get(url, options: Options(headers: headers));

      return SuccessResponseDTO(
          data: GeneralBoardModel.fromJson(response.data));
    } on DioError catch (e) {
      return ExceptionResponseDTO(message: e.message);
    }
  }
}
