import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../gen/assets.gen.dart';
import '../../../util/launch.dart';
import '../../page/agreement_content/type.dart';
import '../../page/agreement_content/widget.dart';
import '../../page/contact/widget.dart';
import '../../page/setting/widget.dart';
import '../../style/colors.dart';
import '../../style/text_style.dart';
import 'menu_item/widget.dart';

class DrawerMenu extends ConsumerWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          SizedBox(
            height: 40,
            child: DrawerHeader(
              child: Container(),
              decoration: const BoxDecoration(
                color: IHSColors.yellow50,
              ),
            ),
          ),
          DrawerMenuItem(
            buttonText: 'ホーム',
            onTap: () => _popToRoot(context),
            endItem: true,
          ),
          const SizedBox(height: 24),
          DrawerMenuItem(
            buttonText: '設定',
            onTap: () => _popToSelect(context),
            endItem: false,
          ),
          DrawerMenuItem(
            buttonText: '個人情報保護方針',
            onTap: () {
              _pushToAgreementContent(context, AgreementContentType.individual);
            },
            endItem: false,
          ),
          DrawerMenuItem(
            buttonText: 'プライバシーポリシー',
            onTap: () {
              _pushToAgreementContent(
                  context, AgreementContentType.privacyPolicy);
            },
            endItem: false,
          ),
          DrawerMenuItem(
            buttonText: '利用規約',
            onTap: () {
              _pushToAgreementContent(context, AgreementContentType.terms);
            },
            endItem: false,
          ),
          DrawerMenuItem(
            buttonText: 'お問い合わせ',
            onTap: () {
              _pushToContact(context);
            },
            endItem: true,
          ),
          const SizedBox(height: 24),
          sukusukuLinkButton(context: context),
        ],
      ),
    );
  }

  void _pushToContact(BuildContext context) {
    Navigator.pop(context); // hide drawer
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => const ContactPage(),
      ),
    );
  }

  Future<void> _popToRoot(BuildContext context) async {
    Navigator.pop(context); // hide drawer
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  Future<void> _popToSelect(BuildContext context) async {
    Navigator.pop(context); // hide drawer
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => const SettingPage(),
      ),
    );
  }

  // 個人情報保護方針・プライバシーポリシー・利用規約
  Future<void> _pushToAgreementContent(
    BuildContext context,
    AgreementContentType type,
  ) async {
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => AgreementContentPage(
          showConsentButton: false,
          type: type,
        ),
      ),
    );
  }

  Widget sukusukuLinkButton({required BuildContext context}) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: IHSColors.black200),
          bottom: BorderSide(color: IHSColors.black200),
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 24),
        title: Transform.translate(
          offset: const Offset(-16, 0),
          child: Row(
            children: [
              Flexible(
                child: Text(
                  '子育て応援サイト「すくすく」',
                  style: IHSTextStyle.small,
                ),
              ),
              const SizedBox(width: 5),
              SvgPicture.asset(Assets.images.siteLink),
            ],
          ),
        ),
        onTap: () => UrlLaunch.launchInBrowser(
          context,
          'https://sunited.co.jp/',
        ),
      ),
    );
  }
}
