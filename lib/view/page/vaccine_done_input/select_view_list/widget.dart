import 'package:family_notes/view/page/vaccine_done_input/notifier.dart';
import 'package:flutter/material.dart';

import '../../../style/colors.dart';
import '../../../style/text_style.dart';

class SelectViewList extends StatelessWidget {
  const SelectViewList({
    super.key,
    required this.idx,
    required this.dataList,
    required this.dataCtl,
  });
  final int idx;
  final List<String> dataList;
  final VaccineDoneInputNotifier dataCtl;

  @override
  Widget build(BuildContext context) {
    final dataCount = dataList.length;
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: dataCount,
      itemBuilder: (context, index) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          debugPrint('countNo=[$idx] / itemNo=[$index]');
          dataCtl
            ..onChangedItem(idx, index)
            ..changeExpanded(-1);
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(
                height: 1,
                color: IHSColors.black800,
              ), //区切り線
              const SizedBox(height: 16),
              Text(
                dataList[index],
                style: IHSTextStyle.small,
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
