import 'package:danvery/core/dto/api_response_dto.dart';
import 'package:danvery/domain/user/info/repository/userInfo_repository.dart';
import 'package:danvery/ui/pages/user/find_password_page/views/steps/find_password_step_2.dart';
import 'package:danvery/ui/pages/user/find_password_page/views/steps/find_password_step_3.dart';
import 'package:danvery/ui/pages/user/find_password_page/views/steps/find_password_step_4.dart';
import 'package:danvery/ui/widgets/getx_snackbar/getx_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../views/steps/find_password_step_1.dart';

class FindPasswordPageController extends GetxController {
  final UserInfoRepository _userInfoRepository = UserInfoRepository();

  List<String> stepTitle = [
    "휴대폰 번호 입력",
    "인증번호 입력",
    "비밀번호 재설정",
    "비밀번호 변경이\n완료되었습니다"
  ];

  List<Widget> pages = const [
    FindPasswordStep1(),
    FindPasswordStep2(),
    FindPasswordStep3(),
    FindPasswordStep4(),
  ];

  final RxInt currentStep = 1.obs;

  final Rx<TextEditingController> phoneNumberController =
      TextEditingController().obs;

  final Rx<TextEditingController> phoneAuthCodeController =
      TextEditingController().obs;

  final Rx<TextEditingController> passwordController =
      TextEditingController().obs;

  final Rx<TextEditingController> passwordValidateController =
      TextEditingController().obs;

  late String? token;

  Future<bool> sendAuthCodeToSMS() async {
    final ApiResponseDTO apiResponseDTO = await _userInfoRepository
        .sendAuthCodeToSMS(phoneNumber: phoneNumberController.value.text);
    if (apiResponseDTO.success) {
      token = apiResponseDTO.data as String;
      return true;
    } else {
      GetXSnackBar(
              type: GetXSnackBarType.customError,
              title: "인증번호 전송 오류",
              content: apiResponseDTO.message)
          .show();
      return false;
    }
  }

  Future<bool> verifyAuthCode() async {
    final ApiResponseDTO apiResponseDTO = await _userInfoRepository.verifyAuthCode(
        token: token!, code: phoneAuthCodeController.value.text);
    if (apiResponseDTO.success) {
      return true;
    } else {
      GetXSnackBar(
              type: GetXSnackBarType.customError,
              title: "인증번호 확인 오류",
              content: apiResponseDTO.message)
          .show();
      return false;
    }
  }

  Future<bool> changePassword() async {
    final ApiResponseDTO apiResponseDTO = await _userInfoRepository.resetPassword(
        token: token!, password: passwordController.value.text);
    if (apiResponseDTO.success) {
      return true;
    } else {
      GetXSnackBar(
              type: GetXSnackBarType.customError,
              title: "비밀번호 변경 오류",
              content: apiResponseDTO.message)
          .show();
      return false;
    }
  }
}
