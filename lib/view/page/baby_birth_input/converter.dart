import '../../../data/request/child_birth/request.dart';
import 'type.dart';

class ChildBirthRequestConverter {
  ChildBirthRequestConverter._();

  static ChildBirthRequest convertFrom({
    required BabyBirthInputData inputData,
    required int selectedChildId,
  }) {
    final _childBirthDataList = inputData.childList.map((data) {
      final _birthDay = DateTime(
        data.birthday!.year,
        data.birthday!.month,
        data.birthday!.day,
        data.birthdayTime!.hour,
        data.birthdayTime!.minute,
      ).toString();
      return ChildBirthDataItem(
        birthday: _birthDay,
        nickname: data.name,
        gender: data.gender?.index,
        height: double.tryParse(data.height),
        weight: int.tryParse(data.weight),
        head: double.tryParse(data.head),
        chest: double.tryParse(data.chest),
      );
    }).toList();

    return ChildBirthRequest(
      childId: selectedChildId,
      childBirthData: _childBirthDataList,
      gestationPeriod: inputData.pregnancyWeeks,
      birthPlace: inputData.address,
      birthDoctor: inputData.doctor,
      motherFatherFeeling: inputData.parentFeeling,
      message: inputData.message,
      comment: inputData.freeComment,
    );
  }
}
