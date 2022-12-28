import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../extension/date_time.dart';
import '../../../../extension/int.dart';
import '../../../../gen/assets.gen.dart';
import '../../style/colors.dart';
import '../../style/text_style.dart';
import 'state.dart';

class ChildListItem extends StatelessWidget {
  const ChildListItem(
    this.itemData, {
    required this.onTap,
    super.key,
  });

  final ChildListItemData itemData;
  final Function(ChildListItemData) onTap;

  String get title {
    return itemData.map(
      baby: (data) {
        return data.name;
      },
      child: (data) {
        return data.name;
      },
    );
  }

  Widget? get subtTitle {
    return itemData.map(
      baby: (data) {
        final number = data.scheduledBirthday?.toPregnantMonthsNumber;

        return number == null
            ? null
            : Text(
                '妊娠$numberか月',
                overflow: TextOverflow.ellipsis,
                style: IHSTextStyle.small,
              );
      },
      child: (data) {
        final ageFromMonths = data.monthFromBirth?.toAgeFromMonths;
        return ageFromMonths == null
            ? null
            : Wrap(
                children: [
                  Text(
                    ageFromMonths,
                    style: IHSTextStyle.small,
                  ),
                  Text(
                    '（${data.birthday?.yyyymmdd ?? ''} 生まれ）',
                    style: IHSTextStyle.xSmall,
                  ),
                ],
              );
      },
    );
  }

  Widget get faceIcon {
    return itemData.map(
      baby: (data) {
        return SvgPicture.asset(
          Assets.images.iconBaby,
          width: 40,
          height: 40,
        );
      },
      child: (data) {
        return SvgPicture.asset(
          Assets.images.iconChild,
          width: 40,
          height: 40,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(itemData);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: IHSColors.white,
          border: Border.all(
            color: IHSColors.black300,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            faceIcon,
            const SizedBox(width: 16),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (title != '')
                    Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      style: IHSTextStyle.medium,
                    ),
                  if (subtTitle != null) ...[
                    const SizedBox(height: 8),
                    subtTitle!,
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
