import 'package:family_notes/provider/user/notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../data/http/exception/exception.dart';
import '../../../data/repository/child.dart';
import '../../../provider/maintenance/notifier.dart';
import '../../component/validate_text_field/type.dart';
import '../../component/validate_text_field/validation.dart';

import '../child_book_select/notifier.dart';
import 'body_input/widget.dart';
import 'converter.dart';
import 'state.dart';
import 'type.dart';

/// 出生時情報の入力の状態を管理するプロバイダー
final babyBirthInputStateProvider = AutoDisposeStateNotifierProvider<
    BabyBirthInputNotifier, BabyBirthInputState>((ref) {
  final childRepository = ref.watch(childRepositoryProvider);
  final userState = ref.watch(userStateProvider);
  return BabyBirthInputNotifier(
    childRepository: childRepository,
    userState: userState,
    ref: ref,
  );
});

class BabyBirthInputNotifier extends StateNotifier<BabyBirthInputState> {
  BabyBirthInputNotifier({
    required this.childRepository,
    required this.userState,
    required this.ref,
  }) : super(const BabyBirthInputStateLoading());

  final ChildRepository childRepository;
  final UserState userState;
  final AutoDisposeStateNotifierProviderRef ref;

  void setup(int childNumber, BabyBirthInputData? initialInputData) {
    final inputData = initialInputData ??
        BabyBirthInputData(
          childList: List.generate(
            childNumber,
            (int i) {
              return BabyBirthDataByChild(
                index: i,
                birthday: DateTime.now(),
                birthdayTime: TimeOfDay.now(),
              );
            },
          ),
        );

    final formMap = <String, AbstractControl<dynamic>>{};

    for (var i = 0; i < childNumber; i++) {
      final childData = inputData.childList[i];
      final _heightController = getController(
        type: ValidateTextFieldType.double,
        isRequired: false,
        value: childData.height,
        validator: NumValidationType.height.numValid,
      );
      final _weightController = getController(
        type: ValidateTextFieldType.int,
        isRequired: false,
        value: childData.weight,
        validator: NumValidationType.gramWeight.numValid,
      );
      final _headController = getController(
        type: ValidateTextFieldType.double,
        isRequired: false,
        value: childData.head,
        validator: NumValidationType.head.numValid,
      );
      final _chestController = getController(
        type: ValidateTextFieldType.double,
        isRequired: false,
        value: childData.chest,
        validator: NumValidationType.chest.numValid,
      );
      formMap[i.toString()] = FormGroup({
        BabyBirthBodyInputType.height.name: _heightController,
        BabyBirthBodyInputType.weight.name: _weightController,
        BabyBirthBodyInputType.head.name: _headController,
        BabyBirthBodyInputType.chest.name: _chestController,
      });
    }

    final _weekController = getController(
      type: ValidateTextFieldType.int,
      isRequired: false,
      value: inputData.pregnancyWeeks,
      validator: NumValidationType.week.numValid,
    );

    state = BabyBirthInputStateLoaded(
      inputData: inputData,
      weekController: _weekController,
      parentFeelingController: TextEditingController(
        text: inputData.parentFeeling,
      ),
      messageController: TextEditingController(
        text: inputData.message,
      ),
      freeCommentController: TextEditingController(
        text: inputData.freeComment,
      ),
      form: FormGroup(formMap),
    );
  }

  // 子ども毎の出生情報の更新
  void onChangedBabyBirthDataByChild(int index, BabyBirthDataByChild data) {
    final _state = state as BabyBirthInputStateLoaded;
    final childList = [..._state.inputData!.childList];
    childList[index] = data;
    state = _state.copyWith(
      inputData: _state.inputData!.copyWith(
        childList: childList,
      ),
    );
  }

  // 妊娠期間の更新
  void onChangedPregnancyWeeks(String text) {
    final _state = state as BabyBirthInputStateLoaded;
    _state.weekController!.updateValue(text);
    state = _state.copyWith(
      inputData: _state.inputData!.copyWith(
        pregnancyWeeks: text,
      ),
    );
  }

  // 出産した場所の更新
  void onChangedAddress(String text) {
    final _state = state as BabyBirthInputStateLoaded;
    state = _state.copyWith(
      inputData: _state.inputData!.copyWith(
        address: text,
      ),
    );
  }

  // 医師又は助産師の更新
  void onChangedDoctor(String text) {
    final _state = state as BabyBirthInputStateLoaded;
    state = _state.copyWith(
      inputData: _state.inputData!.copyWith(
        doctor: text,
      ),
    );
  }

  // ママ、パパの気持ちの更新
  void onChangedParentFeeling(String text) {
    final _state = state as BabyBirthInputStateLoaded;
    state = _state.copyWith(
      inputData: _state.inputData!.copyWith(
        parentFeeling: text,
      ),
    );
  }

  // 赤ちゃんへのメッセージの更新
  void onChangedMessage(String text) {
    final _state = state as BabyBirthInputStateLoaded;
    state = _state.copyWith(
      inputData: _state.inputData!.copyWith(
        message: text,
      ),
    );
  }

  // 自由コメント欄の更新
  void onChangedFreeComment(String text) {
    final _state = state as BabyBirthInputStateLoaded;
    state = _state.copyWith(
      inputData: _state.inputData!.copyWith(
        freeComment: text,
      ),
    );
  }

  // 登録
  Future<void> onTapRegister({
    required VoidCallback onSuccess,
    required Function(String) onFailure,
  }) async {
    final _state = state as BabyBirthInputStateLoaded;
    final _inputData = _state.inputData!;

    final childBirthdayList =
        _inputData.childList.map((child) => child.birthday).toList();
    if (childBirthdayList.contains(null)) {
      onFailure('未入力の項目があります');
      return;
    }

    if (_state.saving) {
      return;
    }

    state = _state.copyWith(saving: true);

    final _selectedChildId =
        userState.mapOrNull(authenticated: (state) => state.selectedChildId)!;

    final request = ChildBirthRequestConverter.convertFrom(
      inputData: _inputData,
      selectedChildId: _selectedChildId,
    );

    final response =
        await childRepository.birthChild(request: request).catchError(
      (error, _) {
        if (error is MaintenanceModeHttpStatusException) {
          ref.read(maintenanceStateProvider.notifier).setMentenanceMode();
        }
        onFailure('予期せぬエラーが発生しました');
      },
    );

    final addedChildList = response.data?.list ?? [];
    final addedChildId = addedChildList.first.id;

    // 子ども一覧の更新を依頼
    await ref.read(childListStatusProvider.notifier).fetch();

    // 選択中の子供の更新
    await ref.read(userStateProvider.notifier).onSelectedBook(
          childId: addedChildId,
          childType: 'child',
          onFailure: (msg) => onFailure(msg),
        );

    onSuccess();
  }
}
