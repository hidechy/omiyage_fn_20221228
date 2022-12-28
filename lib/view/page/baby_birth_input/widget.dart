import 'package:family_notes/util/util.dart';
import 'package:family_notes/view/component/plain_text_field/widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '/view/component/gradation_layout/widget.dart';
import '/view/component/ihs_button/type.dart';
import '/view/component/ihs_button/widget.dart';
import '/view/page/baby_birth_input/type.dart';
import '/view/style/text_style.dart';
import '../../component/loading_indicator/widget.dart';
import '../../component/multiline_text_field/widget.dart';
import '../../component/validate_text_field/type.dart';
import '../../component/validate_text_field/widget.dart';
import '../baby_birth_complete/widget.dart';
import 'birth_tile/widget.dart';
import 'notifier.dart';
import 'state.dart';

/// 出産情報入力画面
/// - 双子以上の場合はその分の子ども情報を入力します
class BabyBirthInputPage extends ConsumerStatefulWidget {
  const BabyBirthInputPage({
    super.key,
    this.childNumber = 1,
    // 初期の入力データ(新規登録ならnull)
    this.initialInputData,
  });

  final int childNumber;
  final BabyBirthInputData? initialInputData;

  @override
  BabyBirthInputState createState() => BabyBirthInputState();
}

class BabyBirthInputState extends ConsumerState<BabyBirthInputPage> {
  late TextEditingController addressController;
  late TextEditingController doctorController;

  @override
  void initState() {
    final initialData = widget.initialInputData;
    final isNullInitialData = initialData == null;
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        ref
            .read(babyBirthInputStateProvider.notifier)
            .setup(widget.childNumber, initialData);
      },
    );

    addressController = TextEditingController(
      text: isNullInitialData ? '' : initialData.address,
    );
    doctorController = TextEditingController(
      text: isNullInitialData ? '' : initialData.doctor,
    );
    super.initState();
  }

  @override
  void dispose() {
    addressController.dispose();
    doctorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(babyBirthInputStateProvider);

    return GradationLayout(
      title: widget.initialInputData == null ? '出産情報登録' : '出産情報編集',
      showDrawer: false,
      body: state.map(
        loading: (_) => const LoadingIndicator(),
        loaded: (BabyBirthInputStateLoaded state) {
          final notifier = ref.read(babyBirthInputStateProvider.notifier);
          final _inputData = state.inputData;
          final _form = state.form!;
          final parentFeelingController = state.parentFeelingController;
          final messageController = state.messageController;
          final freeCommentController = state.freeCommentController;

          return Stack(
            children: [
              ReactiveForm(
                formGroup: _form,
                child: SingleChildScrollView(
                  child: AbsorbPointer(
                    absorbing: state.saving,
                    child: Column(
                      children: [
                        const SizedBox(height: 32),
                        if (_inputData != null)
                          ..._inputData.childList.map(
                            (data) {
                              return Column(
                                children: [
                                  BabyBirthTile(
                                    // 複数人の時のみタイトルを表示
                                    showTitle: _inputData.childList.length > 1,
                                    key: Key('BabyBirthTile_${data.index}'),
                                    data: data,
                                    onChanged: (data) {
                                      notifier.onChangedBabyBirthDataByChild(
                                        data.index,
                                        data,
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 32),
                                ],
                              );
                            },
                          ),
                        Row(
                          children: [
                            Text(
                              '妊娠週数',
                              style: IHSTextStyle.small,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(width: 16),
                                ValidateTextField(
                                  width: 72,
                                  type: ValidateTextFieldType.int,
                                  controller: state.weekController!,
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  onChanged: notifier.onChangedPregnancyWeeks,
                                ),
                                const SizedBox(width: 8),
                                Padding(
                                  padding: const EdgeInsets.only(top: 24),
                                  child: Text('週', style: IHSTextStyle.small),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),
                        PlainTextField(
                          controller: addressController,
                          title: '出産した場所',
                          onChanged: notifier.onChangedAddress,
                        ),
                        const SizedBox(height: 24),
                        PlainTextField(
                          controller: doctorController,
                          title: '医師または助産師',
                          onChanged: notifier.onChangedDoctor,
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            Text(
                              'ママ、パパの気持ち',
                              style: IHSTextStyle.small,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        MultilineTextField(
                          controller: parentFeelingController!,
                          maxLines: 3,
                          hintText: '自由に記入してください',
                          onChanged: notifier.onChangedParentFeeling,
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            Text(
                              '赤ちゃんへのメッセージ',
                              style: IHSTextStyle.small,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        MultilineTextField(
                          controller: messageController!,
                          maxLines: 3,
                          hintText: '自由に記入してください',
                          onChanged: notifier.onChangedMessage,
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            Text(
                              '自由にコメントを記載してください',
                              style: IHSTextStyle.small,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        MultilineTextField(
                          controller: freeCommentController!,
                          maxLines: 3,
                          hintText: '自由に記入してください',
                          onChanged: notifier.onChangedFreeComment,
                        ),
                        const SizedBox(height: 32),
                        IHSButton(
                          '登録',
                          type: IHSButtonType.primary,
                          onPressed: () {
                            _form.markAllAsTouched();
                            if (!_form.valid) {
                              return;
                            }
                            notifier.onTapRegister(
                              onSuccess: () {
                                _popOrPushToComplete(context);
                              },
                              onFailure: (msg) {
                                IHSUtil.showSnackBar(msg: msg);
                              },
                            );
                          },
                        ),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
              ),
              if (state.saving) const LoadingIndicator(),
            ],
          );
        },
      ),
    );
  }

  void _popOrPushToComplete(BuildContext context) {
    // 新規登録なら完了画面へ
    if (widget.initialInputData == null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(
          builder: (_) => const BabybirthCompletePage(),
        ),
      );
      return;
    }
    Navigator.of(context).pop();
    IHSUtil.showSnackBar(msg: 'お子さま情報を更新しました');
  }
}
