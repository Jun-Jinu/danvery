import 'package:danvery/core/theme/palette.dart';
import 'package:danvery/ui/pages/user/register_page/controller/register_page_controller.dart';
import 'package:danvery/ui/widgets/getx_snackbar/getx_snackbar.dart';
import 'package:danvery/ui/widgets/modern/modern_form_button.dart';
import 'package:danvery/ui/widgets/modern/modern_form_field.dart';
import 'package:danvery/core/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterStep1 extends GetView<RegisterPageController> {
  const RegisterStep1({super.key});

  @override
  Widget build(BuildContext context) {
    controller.initRegisterPage();
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              controller: controller.scrollController,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ModernFormField(
                      maxLength: 8,
                      textInputAction: TextInputAction.next,
                      onTextChanged: (value) {
                        controller.studentIdController.update((val) {
                          if (val != null) val.text = value;
                        });
                      },
                      hint: '학번(ID)을 입력하세요',
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 8),
                      child: ModernFormField(
                        maxLength: 24,
                        onTextChanged: (value) {
                          controller.studentPasswordController.update((val) {
                            if (val != null) val.text = value;
                          });
                        },
                        hint: "비밀번호를 입력하세요",
                        isPassword: true,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Icon(
                              Icons.info_outline_rounded,
                              color: Palette.grey,
                            ),
                          ),
                          Text(
                            "단국대학교 웹정보 로그인시 사용하는 ID/PW를 통해서 \n학생인증이 진행됩니다."
                            " \n(단국대학교 웹정보 ID/PW는 학생인증 이후 바로 폐기됩니다.)",
                            style: tinyStyle.copyWith(color: Palette.grey),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: context.isDarkMode
                            ? Palette.darkGrey
                            : Palette.pureWhite,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          context.isDarkMode
                              ? const BoxShadow()
                              : BoxShadow(
                                  color: Palette.lightGrey,
                                  spreadRadius: 3,
                                  blurRadius: 3,
                                  offset: const Offset(
                                      0, 1), // changes position of shadow
                                ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                children: [
                                  Obx(
                                    () => Container(
                                      width: 28,
                                      height: 28,
                                      decoration: BoxDecoration(
                                          color: controller.check1.value &&
                                                  controller.check2.value
                                              ? Palette.blue
                                              : Palette.lightGrey,
                                          shape: BoxShape.circle),
                                      child: Checkbox(
                                        side: BorderSide(
                                            color: Palette.lightGrey),
                                        checkColor: Palette.pureWhite,
                                        fillColor:
                                            MaterialStateProperty.resolveWith(
                                                (states) => Palette.blue),
                                        shape: const CircleBorder(),
                                        onChanged: (bool? value) {
                                          controller.check1.value = value!;
                                          controller.check2.value = value;
                                          if (value) {
                                            controller.scrollController
                                                .animateTo(
                                                    controller
                                                        .scrollController
                                                        .position
                                                        .maxScrollExtent,
                                                    duration: const Duration(
                                                        seconds: 1),
                                                    curve:
                                                        Curves.fastOutSlowIn);
                                          }
                                        },
                                        value: controller.check1.value &&
                                            controller.check2.value,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "약관 전체 동의하기",
                                    style: regularStyle.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: Palette.black),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              color: Palette.lightGrey,
                            ),
                            Theme(
                              data: Theme.of(context).copyWith(
                                dividerColor: Colors.transparent,
                              ),
                              child: ExpansionTile(
                                initiallyExpanded: true,
                                iconColor: Palette.blue,
                                childrenPadding: EdgeInsets.zero,
                                tilePadding: EdgeInsets.zero,
                                title: Row(
                                  children: [
                                    Obx(
                                      () => Container(
                                        width: 28,
                                        height: 28,
                                        decoration: BoxDecoration(
                                            color: controller.check1.value
                                                ? Palette.blue
                                                : Palette.lightGrey,
                                            shape: BoxShape.circle),
                                        child: Checkbox(
                                          side: BorderSide(
                                              color: Palette.lightGrey),
                                          checkColor: Palette.pureWhite,
                                          fillColor:
                                              MaterialStateProperty.resolveWith(
                                                  (states) => Palette.blue),
                                          shape: const CircleBorder(),
                                          onChanged: (bool? value) {
                                            controller.check1.value = value!;
                                          },
                                          value: controller.check1.value,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      "(필수) ",
                                      style: regularStyle.copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: Palette.blue),
                                    ),
                                    Text(
                                      '개인정보 수집, 이용 동의',
                                      style: regularStyle.copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: Palette.black),
                                    ),
                                  ],
                                ),
                                children: <Widget>[
                                  Text.rich(
                                    TextSpan(
                                      style: TextStyle(color: Palette.darkGrey),
                                      children: <TextSpan>[
                                        const TextSpan(
                                            text:
                                                '단국대학교 총학생회 홈페이지는 단국대학교 학생임을 인증하기 위하여 아래와 같이 단국대학교 홈페이지 내 개인정보를 수집, 이용합니다.\n\n',
                                            style: tinyStyle),
                                        TextSpan(
                                            text: '수집목적\n',
                                            style: tinyStyle.copyWith(
                                                fontWeight: FontWeight.bold)),
                                        const TextSpan(
                                            text:
                                                '단국대학교 학생임을 인증, 학번, 이름, 학과, 재학 여부 인증\n\n',
                                            style: tinyStyle),
                                        TextSpan(
                                            text: '수집항목\n',
                                            style: tinyStyle.copyWith(
                                                fontWeight: FontWeight.bold)),
                                        const TextSpan(
                                            text:
                                                '단국대학교 홈페이지 아이디 및 비밀번호, 단국대학교 홈페이지 내에 학번, 이름 학과 재학여부\n\n',
                                            style: tinyStyle),
                                        TextSpan(
                                            text: '수집근거\n',
                                            style: tinyStyle.copyWith(
                                                fontWeight: FontWeight.bold)),
                                        const TextSpan(
                                            text: '개인정보 보호법 제15조 제1항\n\n',
                                            style: tinyStyle),
                                        const TextSpan(
                                            text:
                                                '귀하는 단국대학교 총학생회 서비스 이용에 필요한 최소한의 개인정보 수집 및 이용에 동의하지 않을 수 있으나, '
                                                '동의를 거부 할 경우 회원제 서비스 이용이 불가합니다. 단국대학교 홈페이지 아이디 및 비밀번호는 연동 즉시 폐기됩니다.',
                                            style: tinyStyle),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Theme(
                              data: Theme.of(context)
                                  .copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                initiallyExpanded: true,
                                iconColor: Palette.blue,
                                childrenPadding: EdgeInsets.zero,
                                tilePadding: EdgeInsets.zero,
                                title: Row(
                                  children: [
                                    Obx(
                                      () => Container(
                                        width: 28,
                                        height: 28,
                                        decoration: BoxDecoration(
                                            color: controller.check2.value
                                                ? Palette.blue
                                                : Palette.lightGrey,
                                            shape: BoxShape.circle),
                                        child: Checkbox(
                                          side: BorderSide(
                                              color: Palette.lightGrey),
                                          checkColor: Palette.pureWhite,
                                          fillColor:
                                              MaterialStateProperty.resolveWith(
                                                  (states) => Palette.blue),
                                          shape: const CircleBorder(),
                                          onChanged: (bool? value) {
                                            controller.check2.value = value!;
                                          },
                                          value: controller.check2.value,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      "(필수) ",
                                      style: regularStyle.copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: Palette.blue),
                                    ),
                                    Text(
                                      '개인정보 제 3자 제공 동의',
                                      style: regularStyle.copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: Palette.black),
                                    ),
                                  ],
                                ),
                                children: <Widget>[
                                  Text.rich(
                                    TextSpan(
                                      style: TextStyle(color: Palette.darkGrey),
                                      children: <TextSpan>[
                                        const TextSpan(
                                            text:
                                                '단국대학교 총학생회 홈페이지는 회원님의 개인정보를 개인정보 처리방침에서 고지한 제 3자 제공범위 내에서 제공하며, 정보주체의 사전동의 없이 동 범위를 초과하여 제3자에게 제공하지 않습니다.\n\n',
                                            style: tinyStyle),
                                        TextSpan(
                                            text: '제공받는 자\n',
                                            style: tinyStyle.copyWith(
                                                fontWeight: FontWeight.bold)),
                                        const TextSpan(
                                            text: 'Danvery\n\n',
                                            style: tinyStyle),
                                        TextSpan(
                                            text: '보유기간\n',
                                            style: tinyStyle.copyWith(
                                                fontWeight: FontWeight.bold)),
                                        const TextSpan(
                                            text: '가입일로부터 4년\n\n',
                                            style: tinyStyle),
                                        TextSpan(
                                            text: '제공 목적\n',
                                            style: tinyStyle.copyWith(
                                                fontWeight: FontWeight.bold)),
                                        const TextSpan(
                                            text: '단국대학교 학생 복지 앱 연동\n\n',
                                            style: tinyStyle),
                                        TextSpan(
                                            text: '제공 항목\n',
                                            style: tinyStyle.copyWith(
                                                fontWeight: FontWeight.bold)),
                                        const TextSpan(
                                            text:
                                                '단국대학교 홈페이지 내 학번, 이름, 학과, 재학여부\n\n',
                                            style: tinyStyle),
                                        const TextSpan(
                                            text:
                                                '개인정보 제공에 대한 동의를 거부할 권리가 있으며, 동의를 거부할 경우 회원가입에 제한을 받습니다.',
                                            style: tinyStyle),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Obx(
              () => ModernFormButton(
                isEnabled: controller.check1.value &&
                    controller.check2.value &&
                    controller.studentIdController.value.text.isNotEmpty &&
                    controller.studentPasswordController.value.text.isNotEmpty,
                onPressed: () async {
                  if (controller.studentIdController.value.text.length != 8) {
                    GetXSnackBar(
                      title: "학번 오류",
                      content: "학번을 확인해주세요.",
                      type: GetXSnackBarType.customError,
                    ).show();
                    return;
                  }
                  await controller.studentAuthenticate(
                      controller.studentIdController.value.text,
                      controller.studentPasswordController.value.text);
                  if (controller.isStudentAuthenticated.value) {
                    FocusManager.instance.primaryFocus?.unfocus();
                    controller.currentStep.value = 2;
                  }
                },
                text: '인증하기',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
