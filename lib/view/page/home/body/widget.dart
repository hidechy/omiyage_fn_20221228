import 'package:family_notes/util/util.dart';
import 'package:family_notes/view/page/agreement_content/type.dart';
import 'package:family_notes/view/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../data/model/consent/model.dart';
import '../../../../provider/child/state.dart';
import '../../../component/loading_indicator/widget.dart';
import '../../baby_birth_count/widget.dart';
import '../../baby_info/widget.dart';
import '../../check_sheet/widget.dart';
import '../../child_growth_graph/widget.dart';
import '../../child_health_check_select/widget.dart';
import '../../child_info/widget.dart';
import '../../life_habit_check_select/widget.dart';
import '../../pregnant_dental_check_select/widget.dart';
import '../../pregnant_health_check_select/widget.dart';
import '../../pregnant_weight_graph/widget.dart';
import '../../vaccine_schedule/widget.dart';
import '../ad/widget.dart';
import '../grid/widget.dart';
import '../header/widget.dart';
import '../layout_switch_button/widget.dart';
import '../remind_item/widget.dart';
import '../tile/type.dart';
import 'agreement_dialog/widget.dart';
import 'notifier.dart';
import 'state.dart';

/// ホーム画面のBody
class HomeBodyPage extends ConsumerStatefulWidget {
  const HomeBodyPage({
    super.key,
    required this.initialLayout,
    required this.child,
    this.showRemind = true,
  });

  final HomeLayout initialLayout;
  final IHSChild child;
  final bool showRemind;

  @override
  HomeBodyPageState createState() => HomeBodyPageState();
}

class HomeBodyPageState extends ConsumerState<HomeBodyPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        ref.read(homeBodyPageStateProvider.notifier).setup(
              initialLayout: widget.initialLayout,
              onSuccess: (consentList) async {
                for (final e in consentList) {
                  final type = AgreementContentType.values.firstWhere(
                    (element) => element.value == e.type,
                  );

                  await showDialog(
                    barrierDismissible: false,
                    barrierColor: IHSColors.black800.withOpacity(0.3),
                    context: context,
                    builder: (context) {
                      return AgreementDialog(
                        label: e.label,
                        type: type,
                        onTap: (consentModel) async {
                          IHSUtil.showLoadingDialog(context);
                          await ref
                              .watch(homeBodyPageStateProvider.notifier)
                              .updateConsent(
                                type: consentModel.type,
                                consentId: consentModel.id,
                              );
                          Navigator.popUntil(
                            context,
                            (route) => route.isFirst,
                          );
                        },
                      );
                    },
                  );
                }
              },
            );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeBodyPageStateProvider);
    final controller = ScrollController();

    return state.map(
      init: (_) {
        return const LoadingIndicator();
      },
      loaded: (loadedState) {
        return Column(
          children: [
            const SizedBox(height: 24),
            if (loadedState.currentLayout == HomeLayout.baby &&
                widget.child.isNearBirth)
              RemindItem(
                onTap: () {
                  _pushToBabyBirthCount(context);
                },
              ),
            HomeHeader(
              homeLayout: loadedState.currentLayout,
              child: widget.child,
              onTap: () {
                widget.child.map(
                  baby: (_) {
                    _pushToBabyInfo(context);
                  },
                  child: (_) {
                    _pushToChildInfo(context);
                  },
                );
              },
            ),
            Expanded(
              child: SingleChildScrollView(
                controller: controller,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: HomeGrid(
                        homeLayout: loadedState.currentLayout,
                        onTap: (tileType) {
                          _pushToDetail(tileType);
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                    // 妊婦/子ども切り替えボタン（子ども選択中のみ表示）
                    if (widget.child is ChildIHSChild) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: HomeLayoutSwitchButton(
                          homeLayout: loadedState.currentLayout,
                          onTap: () {
                            // 最上部へスクロール
                            controller.animateTo(
                              0,
                              duration: const Duration(microseconds: 1),
                              curve: Curves.linear,
                            );
                            ref
                                .read(homeBodyPageStateProvider.notifier)
                                .onTap();
                          },
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                    // 広告領域
                    const HomeAdBanner(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  /// 各種詳細画面へ
  void _pushToDetail(HomeTileType tileType) {
    Widget? page;

    switch (tileType) {
      // 妊婦健診
      case HomeTileType.prenatalCare:
        page = const PregnantHealthCheckSelectPage();
        break;
      // 妊婦歯科健診
      case HomeTileType.prenatalCareDental:
        page = const PregnantDentalCheckSelectPage();
        break;
      // 体重グラフ
      case HomeTileType.weightGraph:
        page = const PregnantWeightGraphPage();
        break;
      // 乳幼児検診
      case HomeTileType.healthCheckup:
        page = const ChildHealthCheckSelectPage();
        break;
      // 予防接種
      case HomeTileType.vaccination:
        page = const VaccineSchedulePage();
        break;
      //身体発育曲線
      case HomeTileType.physicalGrowthCurve:
        page = ChildGrowthGraphPage();
        break;
      // 生活習慣予防
      case HomeTileType.prevention:
        page = const LifeHabitCheckSelectPage();
        break;
      // チェックシート
      case HomeTileType.checkSheet:
        page = const CheckSheetSelectPage();
        break;
    }

    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => page!,
      ),
    );
  }

  /// 胎児情報画面へ
  void _pushToBabyInfo(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => const BabyInfoPage(),
      ),
    );
  }

  /// お子さま情報画面へ
  void _pushToChildInfo(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => const ChildInfoPage(),
      ),
    );
  }

  /// 出産人数選択画面へ
  void _pushToBabyBirthCount(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => const BabyBirthCountPage(),
      ),
    );
  }
}
