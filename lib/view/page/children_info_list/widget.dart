import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../component/child_list_item/widget.dart';
import '../../component/ihs_button/type.dart';
import '../../component/ihs_button/widget.dart';
import '../../component/loading_indicator/widget.dart';
import '../../component/main_layout/widget.dart';
import '../baby_edit/widget.dart';
import '../child_book_select/notifier.dart';
import '../../component/child_list_item/state.dart';
import '../child_edit/widget.dart';

class ChildrenInfoListPage extends ConsumerWidget {
  const ChildrenInfoListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(childListStatusProvider);

    return MainLayout(
      title: 'お子さま情報',
      showDrawer: false,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Positioned.fill(
            child: state.map(init: (_) {
              return const LoadingIndicator();
            }, loaded: (state) {
              final itemList = state.itemList;
              return ListView.separated(
                padding: const EdgeInsets.only(top: 32, bottom: 200),
                shrinkWrap: true,
                itemCount: state.itemList.length,
                itemBuilder: (context, index) => ChildListItem(
                  itemList[index],
                  onTap: (itemData) {
                    itemData.map(baby: (item) {
                      _pushToBabyEdit(context, item);
                    }, child: (item) {
                      _pushToChildEdit(context, item);
                    });
                  },
                ),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 24),
              );
            }),
          ),
          Positioned(
            bottom: 40,
            child: Column(
              children: [
                IHSButton(
                  '胎児を新規登録',
                  type: IHSButtonType.primary,
                  onPressed: () {
                    _pushToBabyEdit(context, null);
                  },
                ),
                const SizedBox(height: 24),
                IHSButton(
                  'お子さまを新規登録',
                  type: IHSButtonType.primary,
                  onPressed: () {
                    _pushToChildEdit(context, null);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 胎児登録/編集画面へ
  void _pushToBabyEdit(BuildContext context, ChildListItemDataBaby? item) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => BabyEditPage(targetBabyItem: item),
      ),
    );
  }

  // お子さま登録/編集画面へ
  void _pushToChildEdit(BuildContext context, ChildListItemDataChild? item) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => ChildEditPage(targetChildItem: item),
      ),
    );
  }
}
