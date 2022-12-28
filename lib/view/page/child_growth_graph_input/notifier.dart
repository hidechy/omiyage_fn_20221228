import 'package:family_notes/view/page/child_growth_record_select/notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/data/repository/child_growth_record.dart';
import '../../../data/http/exception/exception.dart';
import '../../../data/model/child_growth_record_list/model.dart';
import '../../../data/model/response/model.dart';
import '../../../extension/string.dart';
import '../../../provider/child/notifier.dart';
import '../../../provider/maintenance/notifier.dart';
import '../../../util/util.dart';
import 'converter.dart';
import 'state.dart';

/// 身体発育曲線の入力の状態を管理するプロバイダー
final childWeightGraphInputStateProvider =
    AutoDisposeStateNotifierProvider.family<ChildGrowthGraphInputNotifier,
        ChildGrowthGraphInputState, ChildGrowthRecord?>((ref, record) {
  return ChildGrowthGraphInputNotifier(
    record: record,
    ref: ref,
    repository: ref.watch(childGrowthRecordRepositoryProvider),
  );
});

class ChildGrowthGraphInputNotifier
    extends StateNotifier<ChildGrowthGraphInputState> {
  ChildGrowthGraphInputNotifier({
    required ChildGrowthRecord? record,
    required this.ref,
    required this.repository,
  }) : super(const ChildGrowthGraphInputState()) {
    _setup(record);
  }

  final AutoDisposeStateNotifierProviderRef ref;
  final ChildGrowthRecordRepository repository;
  final _oneYearOld = 1;

  void _setup(ChildGrowthRecord? record) {
    final childState = ref.read(selectedChildStateProvider);
    final childAge = childState.mapOrNull(
          loaded: (state) => state.child.mapOrNull(
            child: (value) => value.data.monthFromBirth,
          ),
        ) ??
        0 ~/ 12;
    final inputData = record != null
        ? ChildGrowthInputData(
            date: record.date,
            height: record.height.toString(),
            grams: record.weight.toString(),
            kilograms: record.weight.toString().toKiloGram(),
            head: record.head.toString(),
            chest: record.chest.toString(),
          )
        : const ChildGrowthInputData();
    final initialWeightType =
        _oneYearOld > childAge ? WeightType.g : WeightType.kg;
    state = state.copyWith(
      inputData: inputData.copyWith(
        weightType: initialWeightType,
      ),
    );
  }

  // 測定日
  void onChangedDateField(DateTime? date) {
    state = state.copyWith(
      inputData: state.inputData.copyWith(
        date: date,
      ),
    );
  }

  // 身長
  void onChangedHeightField(String height) {
    state = state.copyWith(
      inputData: state.inputData.copyWith(
        height: height,
      ),
    );
  }

  // 体重(g)
  void onChangedGramsField(String weight) {
    state = state.copyWith(
      inputData: state.inputData.copyWith(
        grams: weight,
      ),
    );
  }

  // 体重(kg)
  void onChangedKilogramsField(String weight) {
    state = state.copyWith(
      inputData: state.inputData.copyWith(
        kilograms: weight,
      ),
    );
  }

  // kg/g
  void onChangedWeightType(WeightType weightType) {
    state = state.copyWith(
      inputData: state.inputData.copyWith(
        weightType: weightType,
      ),
    );
  }

  // 体重(g)->体重(kg)への体重値変換
  void weightConvertFromGramsToKilograms() {
    final grams = state.inputData.grams;
    if (grams == null || grams.isEmpty || double.tryParse(grams) == null) {
      return;
    }

    final gramsDouble = double.parse(grams);
    // 体重(kg)に変換
    final weight = gramsDouble / 1000;
    final weightStr = weight.toString();
    state = state.copyWith(
      inputData: state.inputData.copyWith(
        kilograms: weightStr,
      ),
    );
  }

  // 体重(kg)->体重(g)への体重値変換
  void weightConvertFromKilogramsToGrams() {
    // 体重(g)に変換後の「.0」削除後保持用
    var substringWeightStr = '';
    final kilograms = state.inputData.kilograms;
    if (kilograms == null ||
        kilograms.isEmpty ||
        double.tryParse(kilograms) == null) {
      return;
    }

    final kilogramsDouble = double.parse(kilograms);
    // 体重(g)に変換
    final weight = kilogramsDouble * 1000;
    final weightStr = weight.toString();
    final startIndex = weightStr.length - 2;
    // 小数点以下の「.0」を表示させないように削除
    if (weightStr.contains('.0', startIndex)) {
      substringWeightStr = weightStr.substring(0, startIndex);
    }

    state = state.copyWith(
      inputData: state.inputData.copyWith(
        grams: substringWeightStr.isEmpty ? weightStr : substringWeightStr,
      ),
    );
  }

  // 頭囲
  void onChangedHeadField(String head) {
    state = state.copyWith(
      inputData: state.inputData.copyWith(
        head: head,
      ),
    );
  }

  // 胸囲
  void onChangedChestField(String chest) {
    state = state.copyWith(
      inputData: state.inputData.copyWith(
        chest: chest,
      ),
    );
  }

  // 削除
  void onTapDelete({
    required int recordId,
    required VoidCallback onSuccess,
    required Function(String) onFailure,
  }) {
    final childState = ref.read(selectedChildStateProvider);
    final childId = childState.mapOrNull(loaded: (state) => state.childId);

    if (childId == null) {
      _showError('予期せぬエラーが発生しました');
      return;
    }
    if (state.saving) {
      return;
    }
    state = state.copyWith(saving: true);

    repository
        .delete(
      childId: childId,
      recordId: recordId,
    )
        .then(
      (response) {
        state = state.copyWith(saving: false);

        if (response.status == ResponseStatus.failure) {
          onFailure(response.msg ?? '予期せぬエラーが発生しました');
          return;
        }

        // 一覧の更新を依頼
        ref.read(childGrowthRecordSelectProvider.notifier).fetch();
        onSuccess();
      },
    ).catchError(
      (error, _) {
        state = state.copyWith(saving: false);
        if (error is MaintenanceModeHttpStatusException) {
          ref.read(maintenanceStateProvider.notifier).setMentenanceMode();
          return;
        }
        onFailure('予期せぬエラーが発生しました');
      },
    );
  }

  // 登録
  void onTapRegister({
    required int? recordId,
    required VoidCallback onSuccess,
    required Function(String) onFailure,
  }) {
    final childState = ref.read(selectedChildStateProvider);
    final childId = childState.mapOrNull(loaded: (state) => state.childId);

    if (childId == null) {
      _showError('予期せぬエラーが発生しました');
      return;
    }

    // if (state.inputData.height == null ||
    //     state.inputData.grams == null ||
    //     state.inputData.head == null ||
    //     state.inputData.chest == null) {
    //   _showError('未入力の項目があります');
    //   return;
    // }

    if (state.saving) {
      return;
    }
    state = state.copyWith(saving: true);

    final request = ChildGrowthRecordSaveRequestConverter.convertFrom(
      recordId: recordId,
      childId: childId,
      inputData: state.inputData,
    );

    repository.save(request: request).then(
      (response) {
        state = state.copyWith(saving: false);

        if (response.status == ResponseStatus.failure) {
          onFailure(response.msg ?? '予期せぬエラーが発生しました');
          return;
        }

        // 一覧の更新を依頼
        ref.read(childGrowthRecordSelectProvider.notifier).fetch();
        onSuccess();
      },
    ).catchError(
      (error, _) {
        state = state.copyWith(saving: false);
        if (error is MaintenanceModeHttpStatusException) {
          ref.read(maintenanceStateProvider.notifier).setMentenanceMode();
          return;
        }
        onFailure('予期せぬエラーが発生しました');
      },
    );
  }

  void _showError(String msg) {
    IHSUtil.showSnackBar(msg: msg);
  }
}
