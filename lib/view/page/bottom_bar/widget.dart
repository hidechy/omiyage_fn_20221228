import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../gen/assets.gen.dart';
import '../../style/colors.dart';
import '../../style/text_style.dart';
import '../child_book_select/widget.dart';
import '../home/widget.dart';
import '../information_select/widget.dart';
import 'notifier.dart';
import 'state.dart';
import 'type.dart';

class BottomBarPage extends ConsumerStatefulWidget {
  const BottomBarPage({
    super.key,
  });

  @override
  BottomBarPageState createState() => BottomBarPageState();
}

class BottomBarPageState extends ConsumerState<BottomBarPage> {
  @override
  Widget build(BuildContext context) {
    return _buildBottomNavigationBar(context, ref);
  }

  List<Widget> get pages => [
        const HomePage(),
        const ChildBookSelectPage(showDrawer: true),
        const InformationSelectPage(),
      ];

  List<BottomNavigationBarItem> get items => [
        bottomNavIconHome(),
        bottomNavIconBook(),
        bottomNavIconNotice(),
      ];

  TextStyle get textStyle => IHSTextStyle.small;

  Widget _buildBottomNavigationBar(BuildContext context, WidgetRef ref) {
    final tabIndex = ref.watch(bottomBarStateProvider).tabIndex;
    final notifier = ref.watch(bottomBarStateProvider.notifier);

    const tabBarHeight = 72.0;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: IndexedStack(
        index: tabIndex,
        children: pages,
      ),
      bottomNavigationBar: ColoredBox(
        color: IHSColors.pink50,
        child: SafeArea(
          child: SizedBox(
            height: tabBarHeight,
            child: BottomNavigationBar(
              elevation: 0,
              items: items,
              currentIndex: tabIndex,
              backgroundColor: IHSColors.pink50,
              fixedColor: IHSColors.pink400,
              onTap: notifier.setTabIndex,
              type: BottomNavigationBarType.fixed,
              selectedFontSize: 10,
              unselectedFontSize: 10,
              selectedLabelStyle: textStyle,
              unselectedLabelStyle: textStyle,
            ),
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem bottomNavIconHome() => BottomNavigationBarItem(
        icon: SvgPicture.asset(Assets.images.bottombarHome),
        label: 'ホーム',
        activeIcon: SvgPicture.asset(Assets.images.bottombarHomeActive),
      );

  BottomNavigationBarItem bottomNavIconBook() => BottomNavigationBarItem(
        icon: SvgPicture.asset(Assets.images.bottombarBooks),
        label: '手帳選択',
        activeIcon: SvgPicture.asset(Assets.images.bottombarBooksActive),
      );

  BottomNavigationBarItem bottomNavIconNotice() {
    final state = ref.watch(readConfirmationStateProvider);

    return BottomNavigationBarItem(
      label: 'お知らせ',
      icon: _BadgeIcon(
        assetName: Assets.images.bottombarNews,
        state: state,
      ),
      activeIcon: _BadgeIcon(
        assetName: Assets.images.bottombarNewsActive,
        state: state,
      ),
    );
  }
}

class _BadgeIcon extends StatelessWidget {
  const _BadgeIcon({
    required this.assetName,
    required this.state,
  });

  final String assetName;
  final NoticeReadConfirmationState state;

  @override
  Widget build(BuildContext context) {
    return Badge(
      badgeColor: IHSColors.pink500,
      badgeContent: const Text(''),
      child: SvgPicture.asset(assetName),
      showBadge: state.isArrival == ReadConfirmation.unread.num,
      position: BadgePosition.topEnd(end: -15),
    );
  }
}
