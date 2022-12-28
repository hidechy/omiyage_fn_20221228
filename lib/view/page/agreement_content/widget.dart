// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/data/model/consent/model.dart';
import '../../component/base_app_bar/widget.dart';
import '../../component/ihs_button/type.dart';
import '../../component/ihs_button/widget.dart';
import '../../style/colors.dart';
import '../../style/text_style.dart';
import 'notifier.dart';
import 'type.dart';

/// 同意内容を確認する画面（個人情報・プライバシーポリシー・利用規約）
class AgreementContentPage extends ConsumerWidget {
  AgreementContentPage({
    super.key,
    required this.showConsentButton,
    this.onTapedAgree,
    required this.type,
    this.showLeading = true,
  });

  final bool showConsentButton;
  final bool showLeading;
  final Function(ConsentModel)? onTapedAgree;
  final AgreementContentType type;

  late ConsentModel? consentModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(agreementContentStateProvider);

    switch (type) {
      case AgreementContentType.individual:
        consentModel = state.individualConsent;
        break;
      case AgreementContentType.privacyPolicy:
        consentModel = state.poricyConsent;
        break;
      case AgreementContentType.terms:
        consentModel = state.termsConsent;
        break;
    }

    return Scaffold(
      backgroundColor: IHSColors.pink100,
      appBar: AppBar(
        backgroundColor: IHSColors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: IHSColors.pink500),
        title: Text(
          (consentModel == null) ? '' : consentModel!.label,
          style: IHSTextStyle.medium.copyWith(
            color: IHSColors.pink500,
          ),
        ),
        leading: showLeading ? const AppBarLeadingIconButton() : null,
        automaticallyImplyLeading: showLeading,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                height: double.infinity,
                margin:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                alignment: Alignment.topLeft,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 24, horizontal: 16),
                    child: Column(
                      children: [
                        if (consentModel != null)
                          Text(
                            '''
${consentModel!.title}

${consentModel!.content}''',
                            style: IHSTextStyle.small,
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (showConsentButton) ...[
              const SizedBox(height: 16),
              SizedBox(
                width: 128,
                child: IHSButton(
                  '同意する',
                  type: IHSButtonType.primary,
                  onPressed: () {
                    onTapedAgree?.call(consentModel!);

                    Navigator.of(context).pop();
                  },
                ),
              ),
              const SizedBox(height: 32),
            ]
          ],
        ),
      ),
    );
  }
}
