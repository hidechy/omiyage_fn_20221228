import '/data/request/child_growth_record_save/request.dart';
import 'state.dart';

class ChildGrowthRecordSaveRequestConverter {
  ChildGrowthRecordSaveRequestConverter._();

  static ChildGrowthRecordSaveRequest convertFrom({
    required int? recordId,
    required int childId,
    required ChildGrowthInputData inputData,
  }) {
    return ChildGrowthRecordSaveRequest(
      recordId: recordId,
      childId: childId,
      date: inputData.date.toString(),
      height: double.parse(inputData.height!),
      weight: double.parse(inputData.grams!),
      head: double.parse(inputData.head!),
      chest: double.parse(inputData.chest!),
    );
  }
}
