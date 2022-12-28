import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import './custom_tab_view/widget.dart';
import './inoculation_text/widget.dart';
import './vaccine_list_tile/widget.dart';
import '../../component/dot_line/dot_line.dart';
import '../../component/gradation_layout/widget.dart';
import '../../component/loading_indicator/widget.dart';
import '../../style/colors.dart';
import '../vaccine_done_input/widget.dart';
import '../vaccine_schedule_input/widget.dart';
import 'notifier.dart';
import 'type.dart';

class VaccineSchedulePage extends ConsumerWidget {
  const VaccineSchedulePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(vaccineDetailStatusProvider);
    final notifier = ref.watch(vaccineDetailStatusProvider.notifier);
    const widthMargin = 64; // SafeAreaでのleft, rightのマージンが入っている

    return GradationLayout(
      title: '予防接種',
      showDrawer: false,
      horizontalPadding: 0,
      body: Container(
        padding: const EdgeInsets.only(top: 24, bottom: 24),
        child: CustomTabView(
          initPosition: state.tabItemPosition,
          itemCount: tabItems.length,
          tabBuilder: (context, index) => Center(
              child: SizedBox(
                  width: (MediaQuery.of(context).size.width - widthMargin) /
                      tabItems.length,
                  child: Tab(
                      text: (index == 0)
                          ? TabType.doseScheduled.label
                          : TabType.doseDone.label))),
          pageBuilder: (context, index) => Scrollbar(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  if (index == 0 && state.vaccineListCount > 0)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: IHSColors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          itemCount: state.vaccineListCount,
                          itemBuilder: (context, index) => GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              debugPrint('schedule tap line[$index]');
                              Navigator.of(context).push(
                                MaterialPageRoute<void>(
                                  builder: (_) => VaccineScheduleInputPage(
                                    data: notifier.getValidityData(index),
                                    idx: index,
                                  ),
                                ),
                              );
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (index != 0)
                                  const DotLine(
                                    paddingLeft: 12,
                                    paddingRight: 12,
                                  ),
                                const SizedBox(height: 8),
                                VaccineListTile(
                                  name: notifier.getValidityDataName(index),
                                  vaccineScheduleType:
                                      notifier.getValidityDataType(index),
                                  dosingType:
                                      notifier.getValidityDataDosingType(index),
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.only(left: 16 + 14 + 40),
                                  alignment: Alignment.centerLeft,
                                  child: InoculationText(
                                    list: notifier.getValidityInoculationData(
                                        index, DataListType.schedule),
                                    dListType: DataListType.schedule,
                                  ),
                                ),
                                const SizedBox(height: 8),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  if (index == 1 && state.vaccineListCount > 0)
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: IHSColors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          itemCount: state.vaccineListCount,
                          itemBuilder: (context, index) => GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              debugPrint('history tap line[$index]');
                              Navigator.of(context).push(
                                MaterialPageRoute<void>(
                                  builder: (_) => VaccineDoneInputPage(
                                    data: notifier.getValidityData(index),
                                    dListType: DataListType.history,
                                    idx: index,
                                  ),
                                ),
                              );
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (index != 0)
                                  const DotLine(
                                    paddingLeft: 12,
                                    paddingRight: 12,
                                  ),
                                const SizedBox(height: 8),
                                VaccineListTile(
                                  name: notifier.getValidityDataName(index),
                                  vaccineScheduleType:
                                      notifier.getValidityDataType(index),
                                  dosingType:
                                      notifier.getValidityDataDosingType(index),
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.only(left: 16 + 14 + 40),
                                  alignment: Alignment.centerLeft,
                                  child: InoculationText(
                                    list: notifier.getValidityInoculationData(
                                        index, DataListType.history),
                                    dListType: DataListType.history,
                                  ),
                                ),
                                const SizedBox(height: 8),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(height: 16),
                  if (state.acquiring) const LoadingIndicator(),
                ],
              ),
            ),
          ),
          onPositionChange: notifier.setTabPosition,
          onScroll: (position) {
            //debugPrint('$position');
          },
        ),
      ),
    );
  }
}
