import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../data/model/notice_category/model.dart';
import '../../../style/colors.dart';
import '../../../style/text_style.dart';
import '../notifier.dart';

class SliderTags extends ConsumerWidget {
  const SliderTags({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(infomationSelectProvider
        .select((s) => s.mapOrNull(loaded: (s) => s.categories)))!;
    final selectedCategoryId = ref.watch(infomationSelectProvider
        .select((s) => s.mapOrNull(loaded: (s) => s.selectedCategoryId)));
    final notifier = ref.watch(infomationSelectProvider.notifier);

    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: categories
            .map(
              (CategoryItemModel category) => CategoryTag(
                title: category.name,
                onTap: () => notifier.selectCategory(category.categoryId),
                selected: category.categoryId == selectedCategoryId,
              ),
            )
            .toList(),
      ),
    );
  }
}

class CategoryTag extends StatelessWidget {
  const CategoryTag({
    super.key,
    required this.title,
    required this.selected,
    required this.onTap,
  });

  final String title;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: selected ? IHSColors.pink300 : IHSColors.black400,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          title,
          style: IHSTextStyle.small.copyWith(
            color: IHSColors.white,
            height: 1,
          ),
        ),
      ),
    );
  }
}
