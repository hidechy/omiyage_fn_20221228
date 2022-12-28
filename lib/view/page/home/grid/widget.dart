import 'package:flutter/material.dart';

import '/view/page/home/body/state.dart';
import '../tile/type.dart';
import '../tile/widget.dart';

class HomeGrid extends StatelessWidget {
  const HomeGrid({
    super.key,
    required this.homeLayout,
    required this.onTap,
  });

  final HomeLayout homeLayout;
  final Function(HomeTileType) onTap;

  // 妊婦向けで表示するHomeTileTypeのリスト
  List<HomeTileType> get listForParent => [
        HomeTileType.prenatalCare,
        HomeTileType.prenatalCareDental,
        HomeTileType.weightGraph,
      ];

  // 子供向けで表示するHomeTileTypeのリスト
  List<HomeTileType> get listForChild => [
        HomeTileType.healthCheckup,
        HomeTileType.vaccination,
        HomeTileType.physicalGrowthCurve,
        HomeTileType.prevention,
        HomeTileType.checkSheet,
      ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const tileHeight = 102;
    final tileWidth = size.width / 2 - 36;

    return GridView.extent(
      maxCrossAxisExtent: 200,
      childAspectRatio: tileWidth / tileHeight,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 24,
      crossAxisSpacing: 24,
      children: (homeLayout == HomeLayout.baby ? listForParent : listForChild)
          .map(
            (type) => HomeTile(type: type, onTap: onTap),
          )
          .toList(),
    );
  }
}
