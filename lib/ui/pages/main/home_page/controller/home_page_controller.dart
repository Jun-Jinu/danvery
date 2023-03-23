import 'package:danvery/domain/auth/login/service/login_service.dart';
import 'package:danvery/domain/board/post/general_post/controller/general_post_controller.dart';
import 'package:danvery/domain/board/post/general_post/model/general_post_model.dart';
import 'package:danvery/domain/board/post/petition_post/controller/petition_post_controller.dart';
import 'package:danvery/domain/board/post/petition_post/model/petition_post_model.dart';
import 'package:danvery/domain/bus/controller/bus_controller.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController {

  final GeneralPostController generalPostController =
      Get.find<GeneralPostController>();
  final PetitionController petitionPostController =
      Get.find<PetitionController>();
  final LoginService loginService = Get.find<LoginService>();
  final BusController busController = Get.find<BusController>();

  final RxList<GeneralPostModel> _generalPostListHome =
      <GeneralPostModel>[].obs;
  final RxBool _isLoadGeneralPostListHome = false.obs;

  List<GeneralPostModel> get generalPostListHome => _generalPostListHome;

  bool get isLoadGeneralPostListHome => _isLoadGeneralPostListHome.value;

  final RxList<PetitionPostModel> _petitionListHome = <PetitionPostModel>[].obs;

  List<PetitionPostModel> get petitionListHome => _petitionListHome;

  final RxBool _isLoadPetitionListHome = false.obs;

  bool get isLoadPetitionListHome => _isLoadPetitionListHome.value;

  @override
  void onInit() {
    generalPostController.getGeneralPostListHome(0, 5).then((value) {
      if (value != null) {
        _generalPostListHome.value = value;
        _isLoadGeneralPostListHome.value = true;
      }
    });
    petitionPostController
        .getPetitionListHome(0, 5, "ACTIVE")
        .then((value) {
      if (value != null) {
        _petitionListHome.value = value;
        _isLoadPetitionListHome.value = true;
      }
    });
    super.onInit();
  }
}
