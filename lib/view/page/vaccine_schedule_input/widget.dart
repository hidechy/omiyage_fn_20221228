import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../extension/date_time.dart';
import '../../../extension/string.dart';
import '../../../util/util.dart';
import '../../component/date_pick_text_field/widget.dart';
import '../../component/gradation_layout/widget.dart';
import '../../component/ihs_button/type.dart';
import '../../component/ihs_button/widget.dart';
import '../../component/ihs_dialog/widget.dart';
import '../../style/colors.dart';
import '../../style/constants.dart';
import '../../style/text_style.dart';
import '../../style/texts.dart';
import '../vaccine_schedule/notifier.dart';
import '../vaccine_schedule/state.dart';
import '../vaccine_schedule/type.dart';
import 'notifier.dart';
import 'state.dart';

// 予定入力
class VaccineScheduleInputPage extends ConsumerStatefulWidget {
  const VaccineScheduleInputPage({
    super.key,
    required this.data,
    required this.idx,
  });

  final VaccineDetailData data;
  final int idx;

  @override
  _VaccineScheduleInputPage createState() => _VaccineScheduleInputPage();
}

class _VaccineScheduleInputPage
    extends ConsumerState<VaccineScheduleInputPage> {
  final validityStrList = <String>[];
  final numberNameList = <String>[];

  String get vName => widget.data.vaccineName;
  int get vaccineId => widget.data.vaccineTypeId;
  int get count => widget.data.neededTimes; // 最低１回はあるはず

  @override
  void initState() {
    final tgList = ref
        .read(vaccineDetailStatusProvider.notifier)
        .getValidityInoculationData(widget.idx, DataListType.schedule);
    final len = tgList.length;
    for (var i = 0; i < count; ++i) {
      if (i < len) {
        if (tgList[i].settingDate == null) {
          validityStrList.add('');
        } else if (tgList[i].settingDate!.isEmpty) {
          validityStrList.add('');
        } else {
          validityStrList.add(tgList[i].settingDate!);
        }
      } else {
        validityStrList.add('');
      }
      if (tgList[i].numberName == null) {
        numberNameList.add('${(i + 1).toString()}回目');
      } else {
        numberNameList.add(tgList[i].numberName.toString());
      }
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(vaccineScheduleInputProvider.notifier)
          .setup(VaccineScheduleInputDate(dateList: validityStrList));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(vaccineScheduleInputProvider);
    final notifier = ref.watch(vaccineScheduleInputProvider.notifier);
    final detailNotifier = ref.read(vaccineDetailStatusProvider.notifier);

    return GradationLayout(
      title: '予定',
      showDrawer: false,
      horizontalPadding: 0,
      body: SingleChildScrollView(
        child: AbsorbPointer(
          absorbing: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 24),
              Text(
                vName,
                style: IHSTextStyle.medium.copyWith(color: IHSColors.pink500),
              ),
              const SizedBox(height: 24),
              Text(
                '接種の予定を決めましょう。 \nいつでも変更できます。',
                style: IHSTextStyle.small,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              for (int i = 0; i < count; ++i) ...{
                Padding(
                  padding:
                      const EdgeInsets.only(left: 24, right: 23, bottom: 16),
                  child: DatePickTextField(
                    changeStrDate(state.inputDate?.dateList[i]),
                    title: numberNameList[i],
                    onChanged: (DateTime? dateTime) {
                      debugPrint('onChange');
                      if (dateTime == null) {
                        validityStrList[i] = '';
                      } else {
                        validityStrList[i] = dateTime.yyyymmdd;
                      }
                      notifier.onChangedDateList(validityStrList);
                    },
                    firstDate: IHSConstants.datePickerFirstDateYearNum,
                    lastDate: IHSConstants.datePickerLastDateYearNum,
                  ),
                )
              },
              const SizedBox(height: 40 - 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 143,
                    child: IHSButton(
                      '削除',
                      type: IHSButtonType.gray,
                      onPressed: () {
                        IHSDialog(
                            context: context,
                            title: '接種予定を削除します。\nよろしいですか？',
                            okStr: '削除する',
                            cancelStr: 'キャンセル',
                            onTap: (_) async {
                              IHSUtil.showLoadingDialog(context);
                              await notifier.onTapDelete(
                                vaccineTypeId: vaccineId,
                                onSuccess: () {
                                  detailNotifier.onClearSettingDate(
                                      DataListType.schedule, widget.idx);
                                  validityStrList.forEach((element) {
                                    element = '';
                                  });
                                  notifier.setup(VaccineScheduleInputDate(
                                      dateList: validityStrList));
                                },
                                onFailure: (msg) {
                                  IHSUtil.showSnackBar(msg: msg);
                                },
                              );
                              Navigator.pop(context);
                            }).showAlert();
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  SizedBox(
                    width: 143,
                    child: IHSButton(
                      '登録',
                      type: IHSButtonType.primary,
                      onPressed: () async {
                        IHSUtil.showLoadingDialog(context);
                        await notifier.onTapRegister(
                          vaccineTypeId: vaccineId,
                          onSuccess: () {
                            detailNotifier.onSetSettingDate(
                              validityStrList: validityStrList,
                              dListType: DataListType.schedule,
                              idx: widget.idx,
                              itemList: null,
                            );
                            IHSUtil.showSnackBar(msg: IHSTexts.createSuccess);
                          },
                          onFailure: (msg) {
                            IHSUtil.showSnackBar(msg: msg);
                          },
                        );
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  DateTime? changeStrDate(String? str) {
    if (str == null || str.isEmpty) {
      return null;
    }
    return str.toDateTime(DateFormatType.yyyymmdd);
  }
}
