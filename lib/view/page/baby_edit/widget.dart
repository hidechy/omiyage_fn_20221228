import 'package:family_notes/provider/child/state.dart';
import 'package:family_notes/view/style/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '/extension/date_time.dart';
import '/view/component/ihs_dialog/widget.dart';
import '/view/component/main_layout/widget.dart';
import '../../../provider/child/notifier.dart';
import '../../../util/util.dart';
import '../../component/ihs_button/type.dart';
import '../../component/ihs_button/widget.dart';
import '../../component/loading_indicator/widget.dart';
import '../../component/plain_text_field/widget.dart';
import '../../component/validate_date_pick_text_field/widget.dart';
import '../../component/validate_text_field/type.dart';
import '../../component/child_list_item/state.dart';
import 'notifier.dart';
import 'state.dart';

/// 胎児情報編集画面
class BabyEditPage extends ConsumerStatefulWidget {
  const BabyEditPage({
    super.key,
    // 入力データ(新規登録ならnull)
    this.targetBabyItem,
  });

  final ChildListItemDataBaby? targetBabyItem;

  @override
  BabyEditPageState createState() => BabyEditPageState();
}

final birthdayControllerProvider =
    AutoDisposeProvider<FormControl<String>>((ref) {
  final _birthday = ref.watch(babyInputStateProvider
      .select((value) => value.inputData.scheduledBirthday));
  return getController(
    type: ValidateTextFieldType.date,
    value: _birthday != null ? _birthday.yyyymmdd : '',
  );
});

class BabyEditPageState extends ConsumerState<BabyEditPage> {
  late TextEditingController nameController;

  @override
  void initState() {
    final item = widget.targetBabyItem;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (item != null) {
        ref.read(babyInputStateProvider.notifier).setup(item);
      }
    });

    nameController = TextEditingController(text: item == null ? '' : item.name);
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(babyInputStateProvider);
    final notifier = ref.watch(babyInputStateProvider.notifier);

    final form = FormGroup({
      ValidateTextFieldType.date.name: ref.watch(birthdayControllerProvider),
    });

    return MainLayout(
      title: '胎児情報',
      showDrawer: false,
      body: Stack(
        children: [
          ReactiveForm(
            formGroup: form,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: AbsorbPointer(
                absorbing: state.saving,
                child: Column(
                  children: [
                    // 名前
                    _buildNameField(notifier),
                    const SizedBox(height: 24),
                    // 出産予定日
                    _buildScheduledDateField(
                      context,
                      state,
                      notifier,
                      ref.watch(birthdayControllerProvider),
                    ),
                    const SizedBox(height: 32),
                    _buildRegisterArea(state, notifier, form),
                  ],
                ),
              ),
            ),
          ),
          if (state.saving) const LoadingIndicator(),
        ],
      ),
    );
  }

  /// 名前の入力フィールド
  Widget _buildNameField(BabyEditNotifier notifier) {
    return PlainTextField(
      controller: nameController,
      title: '名前（ニックネーム、変更できます）',
      onChanged: (value) {
        notifier.onChangedNameField(value);
      },
    );
  }

  /// 出産予定日の入力フィールド
  Widget _buildScheduledDateField(
    BuildContext context,
    BabyEditState state,
    BabyEditNotifier notifier,
    FormControl<String> controller,
  ) {
    return ValidateDatePickTextField(
      state.inputData.scheduledBirthday,
      title: '出産予定日',
      controller: controller,
      isRequired: true,
      firstDate: IHSConstants.datePickerFirstDateYearNum,
      lastDate: IHSConstants.datePickerLastDateYearNum,
      onChanged: notifier.onChangedDateField,
    );
  }

  Widget _buildRegisterArea(
    BabyEditState state,
    BabyEditNotifier notifier,
    FormGroup form,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 143,
          child: IHSButton(
            widget.targetBabyItem == null ? '登録' : '修正',
            type: IHSButtonType.primary,
            onPressed: () {
              form.markAllAsTouched();
              if (form.valid) {
                notifier.onTapRegister(
                  childId: widget.targetBabyItem?.childId,
                  onSuccess: () {
                    IHSUtil.showSnackBar(
                      msg: widget.targetBabyItem == null
                          ? '胎児を追加しました'
                          : '胎児情報を更新しました',
                    );
                    Navigator.of(context).pop();
                  },
                  onFailure: (msg) {
                    IHSUtil.showSnackBar(msg: msg);
                  },
                );
              }
            },
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: 143,
          child: IHSButton(
            widget.targetBabyItem == null ? 'キャンセル' : '削除',
            type: IHSButtonType.gray,
            onPressed: () {
              if (widget.targetBabyItem == null) {
                Navigator.of(context).pop();
                return;
              }

              //選択中の子供を削除させない
              final selectedChildId = (ref.read(selectedChildStateProvider)
                      as SelectedChildStateLoaded)
                  .childId;

              if (selectedChildId == widget.targetBabyItem?.childId) {
                IHSUtil.showSnackBar(msg: '選択中のお子さまは削除できません。');
                return;
              }

              final name = state.inputData.name;
              IHSDialog(
                context: context,
                title: '$nameちゃんのデータを削除します。よろしいですか？',
                okStr: '削除する',
                cancelStr: 'キャンセル',
                okButtonType: IHSButtonType.gray,
                cancelButtonType: IHSButtonType.primary,
                onTap: (_) {
                  notifier.onTapDelete(
                    childId: widget.targetBabyItem?.childId,
                    onSuccess: () {
                      IHSUtil.showSnackBar(msg: 'お子さまを削除しました');
                      Navigator.of(context).pop();
                    },
                    onFailure: (msg) {
                      IHSUtil.showSnackBar(msg: msg);
                    },
                  );
                },
              ).showAlert();
            },
          ),
        ),
      ],
    );
  }
}
