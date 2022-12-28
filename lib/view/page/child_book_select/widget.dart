import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../provider/user/notifier.dart';
import '../../../util/util.dart';
import '../../component/child_list_item/widget.dart';
import '../../component/gradation_layout/widget.dart';
import '../../component/loading_indicator/widget.dart';
import 'notifier.dart';

/// 手帳選択画面
class ChildBookSelectPage extends ConsumerWidget {
  const ChildBookSelectPage({
    super.key,
    required this.showDrawer,
  });

  final bool showDrawer;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(childListStatusProvider);
    return GradationLayout(
      title: '手帳選択',
      automaticallyImplyLeading: false,
      showDrawer: showDrawer,
      body: state.map(
        init: (_) {
          return const LoadingIndicator();
        },
        loaded: (state) {
          final itemList = state.itemList;
          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 24),
            shrinkWrap: true,
            itemCount: itemList.length,
            itemBuilder: (context, index) => ChildListItem(
              itemList[index],
              onTap: (itemData) {
                ref.read(userStateProvider.notifier).onSelectedBook(
                      childId: itemData.childId,
                      childType: itemData.type,
                      onFailure: (msg) {
                        IHSUtil.showSnackBar(msg: msg);
                      },
                    );

                IHSUtil.showSnackBar(msg: '${itemData.name}を選択しました');
              },
            ),
            separatorBuilder: (context, index) => const SizedBox(height: 24),
          );
        },
      ),
    );
  }
}
