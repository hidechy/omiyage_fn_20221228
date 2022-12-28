import 'package:family_notes/view/page/vaccine_schedule/type.dart';
import 'package:family_notes/view/style/text_style.dart';
import 'package:flutter/material.dart';

import '../../../style/colors.dart';

/// vaccine_listのtileコンポーネント
class VaccineListTile extends StatelessWidget {
  const VaccineListTile({
    super.key,
    required this.name,
    required this.vaccineScheduleType,
    required this.dosingType,
    this.trailFlag = true,
  });

  final String name;
  final VaccineScheduleType vaccineScheduleType;
  final String dosingType;
  final bool trailFlag;

  String get typeName {
    var typeStr = '定期';
    if (vaccineScheduleType == VaccineScheduleType.optional) {
      typeStr = '任意';
    }
    return typeStr;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: IHSColors.pink100, // スクロールしたときにappBarとtabBarの隙間に背景色が出てしまう
      leading: CircleAvatar(
        radius: 20,
        backgroundColor: IHSColors.yellow200,
        child: Text(
          typeName,
          style: IHSTextStyle.small,
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            width: 32,
            height: 20,
            decoration: BoxDecoration(
              border: Border.all(color: IHSColors.pink500),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              dosingType,
              style: IHSTextStyle.xSmall
                  .copyWith(color: IHSColors.pink500, height: 1),
              textAlign: TextAlign.center,
              textHeightBehavior: const TextHeightBehavior(
                applyHeightToFirstAscent: false,
                applyHeightToLastDescent: false,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            name,
            style: IHSTextStyle.small,
          ),
        ],
      ),
      trailing: trailFlag == true
          ? const Padding(
              padding: EdgeInsets.only(top: 40),
              child: Icon(Icons.keyboard_arrow_right),
            )
          : Text(
              '', // Container()では落ちてしまうためにダミーで空白文字
              style: IHSTextStyle.xSmall.copyWith(color: IHSColors.white),
            ),
      // ListViewのitem行全体でイベントをとるようにしたいので、ListTileではonTap()で拾わない
    );
  }
}
