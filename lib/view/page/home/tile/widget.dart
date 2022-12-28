import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../gen/assets.gen.dart';
import '../../../style/colors.dart';
import '../../../style/text_style.dart';
import 'type.dart';

// ホーム画面に表示するタイル
class HomeTile extends StatelessWidget {
  const HomeTile({
    super.key,
    required this.type,
    required this.onTap,
  });

  final HomeTileType type;
  final Function(HomeTileType) onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(type);
      },
      child: Container(
        height: 104,
        decoration: BoxDecoration(
          color: IHSColors.white,
          border: Border.all(
            color: IHSColors.black200,
            width: 1.5,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            homeMenuIcon(type: type),
            const SizedBox(height: 8),
            Text(
              type.label,
              style: IHSTextStyle.small.copyWith(
                color: IHSColors.pink500,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget homeMenuIcon({required HomeTileType type}) {
    switch (type) {
      case HomeTileType.healthCheckup:
        return SvgPicture.asset(
          Assets.images.homeHealthCheckup,
          width: 64,
          height: 32,
        );

      case HomeTileType.vaccination:
        return SvgPicture.asset(
          Assets.images.homeVaccination,
          width: 40,
          height: 32,
        );

      case HomeTileType.physicalGrowthCurve:
        return SvgPicture.asset(
          Assets.images.homePhysicalGrowthCurve,
          width: 40,
          height: 32,
        );

      case HomeTileType.prevention:
        return SvgPicture.asset(
          Assets.images.homePrevention,
          width: 24,
          height: 32,
        );

      case HomeTileType.checkSheet:
        return SvgPicture.asset(
          Assets.images.homeCheckSheet,
          width: 32,
          height: 40,
        );

      case HomeTileType.prenatalCare:
        return SvgPicture.asset(
          Assets.images.homePrenatalCare,
          width: 48,
          height: 32,
        );

      case HomeTileType.prenatalCareDental:
        return SvgPicture.asset(
          Assets.images.homePrenatalCareDental,
          width: 32,
          height: 32,
        );

      case HomeTileType.weightGraph:
        return SvgPicture.asset(
          Assets.images.homeWeightGraph,
          width: 32,
          height: 32,
        );
    }
  }
}
