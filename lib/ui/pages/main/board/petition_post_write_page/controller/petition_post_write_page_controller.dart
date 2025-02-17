import 'package:danvery/core/dto/api_response_dto.dart';
import 'package:danvery/domain/board/post/petition_post/model/petition_post_write_model.dart';
import 'package:danvery/domain/board/post/petition_post/repository/petition_post_repository.dart';
import 'package:danvery/service/login/login_service.dart';
import 'package:danvery/service/permission/permission_service.dart';
import 'package:danvery/ui/pages/main/board/board_page/controller/board_page_controller.dart';
import 'package:danvery/ui/widgets/getx_snackbar/getx_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PetitionPostWritePageController extends GetxController {
  final PermissionService permissionService = Get.find<PermissionService>();

  final PetitionPostRepository _petitionPostRepository =
      PetitionPostRepository();

  final LoginService loginService = Get.find<LoginService>();

  final BoardPageController boardPageController =
      Get.find<BoardPageController>();

  final Rx<TextEditingController> titleController = TextEditingController().obs;

  final Rx<TextEditingController> contentController =
      TextEditingController().obs;

  final RxInt selectedTag = 0.obs;

  final RxList<XFile> imageList = <XFile>[].obs;

  final RxBool isPosting = false.obs;

  @override
  void onInit() {
    titleController.value.addListener(() {
      titleController.refresh();
    });
    contentController.value.addListener(() {
      contentController.refresh();
    });
    super.onInit();
  }

  Future<void> writePetitionPost(
      PetitionPostWriteModel petitionPostWriteModel) async {
    isPosting.value = true;

    final ApiResponseDTO apiResponseDTO =
        await _petitionPostRepository.writePetitionPost(
            token: loginService.token.value.accessToken,
            petitionPostWriteModel: petitionPostWriteModel);
    if (apiResponseDTO.success) {
      boardPageController.selectedCategory = 0;
      await boardPageController.getPetitionPostBoardWithRefresh(true);
      isPosting.value = false;
      Get.back();
    } else {
      GetXSnackBar(
        type: GetXSnackBarType.customError,
        title: "게시글 작성 실패",
        content: apiResponseDTO.message,
      ).show();
    }
    isPosting.value = false;
  }
}
