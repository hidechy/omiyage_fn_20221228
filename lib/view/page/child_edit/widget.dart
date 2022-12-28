import 'package:family_notes/type/gender.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../extension/date_time.dart';
import '../../../provider/child/notifier.dart';
import '../../../provider/child/state.dart';
import '../../../util/util.dart';
import '../../component/child_list_item/state.dart';
import '../../component/ihs_button/type.dart';
import '../../component/ihs_button/widget.dart';
import '../../component/ihs_dialog/widget.dart';
import '../../component/loading_indicator/widget.dart';
import '../../component/main_layout/widget.dart';
import '../../component/plain_text_field/widget.dart';
import '../../component/validate_date_pick_text_field/widget.dart';
import '../../component/validate_text_field/type.dart';
import '../../style/constants.dart';
import '../../style/text_style.dart';
import 'notifier.dart';
import 'segment_view/widget.dart';
import 'state.dart';

final birthdayControllerProvider =
    AutoDisposeProvider<FormControl<String>>((ref) {
  final _birthday = ref.watch(
      childInputStateProvider.select((value) => value.inputData.birthday));
  return getController(
    type: ValidateTextFieldType.date,
    value: _birthday != null ? _birthday.yyyymmdd : '',
  );
});

/// お子さま情報編集画面
class ChildEditPage extends ConsumerStatefulWidget {
  const ChildEditPage({
    super.key,
    // 入力データ(新規登録ならnull)
    this.targetChildItem,
  });

  final ChildListItemDataChild? targetChildItem;

  @override
  ChildEditPageState createState() => ChildEditPageState();
}

class ChildEditPageState extends ConsumerState<ChildEditPage> {
  late TextEditingController nameController;

  @override
  void initState() {
    final item = widget.targetChildItem;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (item != null) {
        ref
            .read(childInputStateProvider.notifier)
            .setup(widget.targetChildItem!);
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
    final state = ref.watch(childInputStateProvider);
    final notifier = ref.watch(childInputStateProvider.notifier);

    final form = FormGroup({
      ValidateTextFieldType.date.name: ref.watch(birthdayControllerProvider),
    });

    return MainLayout(
      title: 'お子さま情報',
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
                    const SizedBox(height: 16),
                    // 性別
                    _buildGenderField(context, state, notifier),
                    const SizedBox(height: 16),
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
          if (state.saving)
            const Positioned(
              child: LoadingIndicator(),
            ),
        ],
      ),
    );
  }

  /// 名前の入力フィールド
  Widget _buildNameField(ChildEditNotifier notifier) {
    return PlainTextField(
      controller: nameController,
      title: '名前（ニックネーム）',
      onChanged: (value) {
        notifier.onChangedNameField(value);
      },
    );
  }

  /// 性別の選択フィールド
  Widget _buildGenderField(
    BuildContext context,
    ChildEditState state,
    ChildEditNotifier notifier,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '性別',
          style: IHSTextStyle.small,
        ),
        const SizedBox(height: 8),
        GenderSegmentView(
          selectedType: state.inputData.gender,
          onTap: (gender) {
            notifier.onChangedGender(gender);
          },
        ),
      ],
    );
  }

  /// 出産予定日の入力フィールド
  Widget _buildScheduledDateField(
    BuildContext context,
    ChildEditState state,
    ChildEditNotifier notifier,
    FormControl<String> controller,
  ) {
    return ValidateDatePickTextField(
      state.inputData.birthday,
      title: '生年月日',
      isRequired: true,
      controller: controller,
      firstDate: IHSConstants.datePickerFirstDateYearNum,
      lastDate: IHSConstants.datePickerLastDateYearNum,
      onChanged: notifier.onChangedDateField,
    );
  }

  Widget _buildRegisterArea(
    ChildEditState state,
    ChildEditNotifier notifier,
    FormGroup form,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 143,
          child: IHSButton(
            widget.targetChildItem == null ? '登録' : '修正',
            type: IHSButtonType.primary,
            onPressed: () {
              form.markAllAsTouched();
              if (!form.valid) {
                return;
              }
              notifier.onTapRegister(
                childId: widget.targetChildItem?.childId,
                onSuccess: () {
                  IHSUtil.showSnackBar(
                    msg: widget.targetChildItem == null
                        ? 'お子さまを追加しました'
                        : 'お子さま情報を更新しました',
                  );
                  Navigator.of(context).pop();
                },
                onFailure: (msg) {
                  IHSUtil.showSnackBar(msg: msg);
                },
              );
            },
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: 143,
          child: IHSButton(
            widget.targetChildItem == null ? 'キャンセル' : '削除',
            type: IHSButtonType.gray,
            onPressed: () {
              if (widget.targetChildItem == null) {
                Navigator.of(context).pop();
                return;
              }

              //選択中の子供を削除させない
              final selectedChildId = (ref.read(selectedChildStateProvider)
                      as SelectedChildStateLoaded)
                  .childId;

              if (selectedChildId == widget.targetChildItem?.childId) {
                IHSUtil.showSnackBar(msg: '選択中のお子さまは削除できません。');
                return;
              }

              final name = state.inputData.name;

              final suffix = state.inputData.gender!.childCall;

              IHSDialog(
                context: context,
                title: '$name$suffixのデータを削除します。よろしいですか？',
                okStr: '削除する',
                cancelStr: 'キャンセル',
                okButtonType: IHSButtonType.gray,
                cancelButtonType: IHSButtonType.primary,
                onTap: (_) {
                  notifier.onTapDelete(
                    childId: widget.targetChildItem?.childId,
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
