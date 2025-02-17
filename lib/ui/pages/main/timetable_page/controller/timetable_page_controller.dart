import 'dart:math';

import 'package:danvery/core/dto/api_response_dto.dart';
import 'package:danvery/core/theme/palette.dart';
import 'package:danvery/domain/timetable/model/lecture/schedule_model.dart';
import 'package:danvery/domain/timetable/model/lecture/lecture_search_list_model.dart';
import 'package:danvery/domain/timetable/model/lecture/lecture_search_model.dart';
import 'package:danvery/domain/timetable/model/lecture/schedule_time.dart';
import 'package:danvery/domain/timetable/model/timetable/timetable_list_model.dart';
import 'package:danvery/domain/timetable/model/timetable/timetable_model.dart';
import 'package:danvery/domain/timetable/repository/timetable_repository.dart';
import 'package:danvery/service/login/login_service.dart';
import 'package:danvery/ui/widgets/getx_snackbar/getx_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class TimetablePageController extends GetxController {
  final TimetableRepository _timetableRepository = TimetableRepository();
  final LoginService _loginService = LoginService();

  final RxList<Rx<TimetableModel>> timetables = <Rx<TimetableModel>>[].obs;

  final int today = DateTime.now().weekday - 1;

  final RxBool isLoadTimetable = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initTimetable();
  }

  Future<void> updateSchedule(
      ScheduleModel model, ScheduleModel newModel) async {
    newModel.id = model.id; //new 겹치는 시간 체크시 본래 모델과의 비교는 제외
    if (isOverlappedScheduleTime(newModel)) {
      GetXSnackBar(
              type: GetXSnackBarType.customError,
              title: "일정 생성 오류",
              content: "시간이 겹치는 일정이 존재합니다.")
          .show();
      return;
    }
    if (!isSatisfyMinimumTime(newModel)) {
      GetXSnackBar(
              type: GetXSnackBarType.customError,
              title: "일정 생성 오류",
              content: "최소 30분 이상의 일정만 추가할 수 있습니다.")
          .show();
      return;
    }

    final List<ScheduleModel> temp = List.empty(growable: true);
    for (ScheduleModel i in timetables.first.value.schedules) {
      temp.add(i);
    }

    timetables.first.update((val) {
      if (val != null) {
        val.schedules[val.schedules.indexOf(model)].name = newModel.name;
        val.schedules[val.schedules.indexOf(model)].color = newModel.color;
        val.schedules[val.schedules.indexOf(model)].times = newModel.times;
        val.schedules[val.schedules.indexOf(model)].memo = newModel.memo;
      }
    });
    if (!await editTimetable()) {
      timetables.first.update((val) {
        if (val != null) {
          val.schedules = temp;
        }
      });
    } else {
      Get.back();
    }
  }

  Future<void> addSchedule(ScheduleModel model) async {
    if (isOverlappedScheduleTime(model)) {
      GetXSnackBar(
              type: GetXSnackBarType.customError,
              title: "일정 생성 오류",
              content: "시간이 겹치는 일정이 존재합니다.")
          .show();
      return;
    }
    if (!isSatisfyMinimumTime(model)) {
      GetXSnackBar(
              type: GetXSnackBarType.customError,
              title: "일정 생성 오류",
              content: "최소 30분 이상의 일정만 추가할 수 있습니다.")
          .show();
      return;
    }

    final List<ScheduleModel> temp = List.empty(growable: true);
    for (ScheduleModel i in timetables.first.value.schedules) {
      temp.add(i);
    }

    timetables.first.update((val) {
      if (val != null) {
        val.schedules.add(model);
      }
    });
    if (!await editTimetable()) {
      timetables.first.update((val) {
        if (val != null) {
          val.schedules = temp;
        }
      });
    } else {
      Get.back();
    }
  }

  Future<void> deleteSchedule(ScheduleModel model) async {
    final List<ScheduleModel> temp = List.empty(growable: true);
    for (ScheduleModel i in timetables.first.value.schedules) {
      temp.add(i);
    }

    timetables.first.update((val) {
      if (val != null) {
        val.schedules.remove(model);
      }
    });
    if (!await editTimetable()) {
      timetables.first.update((val) {
        if (val != null) {
          val.schedules = temp;
        }
      });
    } else {
      Get.back();
    }
  }

  bool isOverlappedScheduleTime(ScheduleModel model) {
    for (int i = 0; i < timetables.first.value.schedules.length; i++) {
      for (ScheduleTime subjectTime
          in timetables.first.value.schedules[i].times) {
        DateTime lectureStartTime =
            DateTime.parse("2022-01-01 ${subjectTime.start}");
        DateTime lectureEndTime =
            DateTime.parse("2022-01-01 ${subjectTime.end}");
        for (ScheduleTime modelTime in model.times) {
          DateTime modelStartTime =
              DateTime.parse("2022-01-01 ${modelTime.start}");
          DateTime modelEndTime = DateTime.parse("2022-01-01 ${modelTime.end}");
          //현재 존재하는 스케줄의 시간들과 비교하여 겹치는 것이 있는지 확인
          if (modelTime.week == subjectTime.week) {
            //본인 시간들이 겹치는지는 비교할 필요 없음
            if (timetables.first.value.schedules[i].id != model.id) {
              if (lectureStartTime.isBefore(modelEndTime) &&
                  lectureEndTime.isAfter(modelStartTime)) {
                // 시간이 겹친다면 true 반환
                return true;
              }
            }
          }
          // 현재 추가하려는 일정의 시간들이 겹치는지 비교하여 확인
          for (ScheduleTime k in model.times) {
            if (k == modelTime) continue;
            if (modelTime.week == k.week) {
              DateTime compareStartTime =
                  DateTime.parse("2022-01-01 ${k.start}");
              DateTime compareEndTime = DateTime.parse("2022-01-01 ${k.end}");
              if (compareStartTime.isBefore(modelEndTime) &&
                  compareEndTime.isAfter(modelStartTime)) {
                // 시간이 겹친다면 true 반환
                return true;
              }
            }
          }
        }
      }
    }
    return false;
  }

  bool isSatisfyMinimumTime(ScheduleModel model) {
    for (ScheduleTime time in model.times) {
      DateTime startTime = DateTime.parse("2022-01-01 ${time.start}");
      DateTime endTime = DateTime.parse("2022-01-01 ${time.end}");
      Duration duration = endTime.difference(startTime);
      if (duration.inMinutes < 30) {
        return false;
      }
    }
    return true;
  }

  Future<void> initTimetable() async{
    final ApiResponseDTO response = await _timetableRepository
        .getTimetableList(_loginService.token.value.accessToken);
    if (response.success) {
      final TimetableListModel timetableList =
          response.data as TimetableListModel;
      if (timetableList.timetables.isEmpty) {
        if (await addTimetable()) await initTimetable();
      } else {
        await getTimetable(timetableList.timetables.first.id);
      }
    } else {
      Future.delayed(const Duration(seconds: 10),() async{
        await initTimetable();
      });
    }
  }

  Future<void> getTimetable(int timetableId) async {
    final ApiResponseDTO response = await _timetableRepository.getTimetable(
        _loginService.token.value.accessToken, timetableId);
    if (response.success) {
      final TimetableModel timetable = response.data as TimetableModel;
      if (timetables.isEmpty) {
        timetables.add(timetable.obs);
      } else {
        timetables.first.value = timetable;
      }
      isLoadTimetable.value = true;
    } else {
      Future.delayed(const Duration(seconds: 10),() async{
        await getTimetable(timetableId);
      });
    }
  }

  Future<bool> addTimetable() async {
    final ApiResponseDTO response = await _timetableRepository.addTimetable(
        _loginService.token.value.accessToken,
        TimetableModel(id: 0, name: "default", schedules: []));
    if (response.success) {
      return true;
    } else {
      GetXSnackBar(
              type: GetXSnackBarType.customError,
              title: "시간표 오류",
              content: "시간표 생성에 실패하였습니다.")
          .show();
      return false;
    }
  }

  Future<bool> editTimetable() async {

    FocusManager.instance.primaryFocus?.unfocus();

    showCupertinoModalPopup(
      context: Get.context!,
      builder: (context) => const Center(
        child: CupertinoActivityIndicator(),
      ),
      barrierDismissible: false,
    );
    final ApiResponseDTO response = await _timetableRepository.editTimetable(
        _loginService.token.value.accessToken, timetables.first.value);
    if (response.success) {
      Get.back();
      return true;
    } else {
      Get.back();
      GetXSnackBar(
              type: GetXSnackBarType.customError,
              title: "시간표 오류",
              content: response.message)
          .show();
      return false;
    }
  }
}

class TimetableBottomSheetController extends GetxController {
  final TimetableRepository _timetableRepository = TimetableRepository();
  final LoginService _loginService = Get.find<LoginService>();

  final RxBool isLectureAdd = true.obs;
  final RxBool isSearch = false.obs;
  final RxBool isSearchLoaded = false.obs;

  Color selectedColor = Palette.subjectColors[Random().nextInt(10)];

  RxList<Rx<ScheduleTime>> times = <Rx<ScheduleTime>>[
    ScheduleTime(start: "09:00", end: "10:00", week: WeekOfDay.monday)
        .obs,
  ].obs;

  final List<String> daysText = [
    WeekOfDay.monday.nameKR,
    WeekOfDay.tuesday.nameKR,
    WeekOfDay.wednesday.nameKR,
    WeekOfDay.thursday.nameKR,
    WeekOfDay.friday.nameKR,
  ];

  late LectureSearchListModel lectureSearchList;

  final RxList<LectureSearchModel> lectures = <LectureSearchModel>[].obs;

  final TextEditingController titleController = TextEditingController();

  final TextEditingController contentController = TextEditingController();

  final TextEditingController memoController = TextEditingController();

  void initBottomSheet(ScheduleModel model) {
    isLectureAdd.value = model.type == ScheduleType.lecture;
    titleController.text = model.name;
    times.value = model.times.map((e) => e.obs).toList();
    contentController.text =
        model.times.map((e) => e.place ?? "").toSet().join(", ");
    memoController.text = model.memo ?? "";
    selectedColor = Color(model.color.value);

    times.sort((a, b) {
      if (a.value.week == b.value.week) {
        return a.value.start.compareTo(b.value.start);
      } else {
        return a.value.week.index.compareTo(b.value.week.index);
      }
    });
  }

  ScheduleModel? makeNewLectureModel() {
    if (titleController.text.isEmpty) {
      GetXSnackBar(
              type: GetXSnackBarType.customError,
              title: "일정 생성 오류",
              content: "일정 제목을 입력해주세요")
          .show();
      return null;
    }
    if (times.isEmpty) {
      GetXSnackBar(
              type: GetXSnackBarType.customError,
              title: "일정 생성 오류",
              content: "일정 시간을 확인해주세요")
          .show();
      return null;
    }

    times
        .map((element) => element.value.place =
            contentController.text.isEmpty ? null : contentController.text)
        .toList();

    return ScheduleModel(
      name: titleController.text,
      color: Color(selectedColor.value),
      times: times.map((e) => e.value).toList(),
      memo: memoController.text,
      type: isLectureAdd.value ? ScheduleType.lecture : ScheduleType.schedule,
    );
  }

  Future<void> searchLecture() async {
    isSearchLoaded.value = false;
    final ApiResponseDTO response = await _timetableRepository.searchLecture(
        _loginService.token.value.accessToken, titleController.text);
    if (response.success) {
      lectureSearchList = response.data as LectureSearchListModel;
      lectures.value = lectureSearchList.content;
    }
    isSearchLoaded.value = true;
  }
}
