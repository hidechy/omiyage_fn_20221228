import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../data/model/child_checkup_types/model.dart';
import '../../../style/colors.dart';
import '../../../style/text_style.dart';
import '../notifier.dart';

class HealthCheckSelectListTile extends ConsumerWidget {
  const HealthCheckSelectListTile({
    super.key,
    required this.type,
  });

  final ChildCheckupType type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(childHealthCheckSelectProvider.notifier);

    return Material(
      child: GestureDetector(
        onTap: () {
          notifier
            ..selectHealthCheck(type)
            ..toggleShowHealthCheckList();
        },
        child: Container(
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            color: IHSColors.white,
            border: Border.all(color: IHSColors.black400),
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                type.checkUpName ?? '',
                style: IHSTextStyle.small,
              ),
              SizedBox(
                width: 24,
                height: 24,
                child: Radio(
                  value: type,
                  groupValue: type.checkUpName,
                  activeColor: IHSColors.black800,
                  onChanged: (_) {},
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
