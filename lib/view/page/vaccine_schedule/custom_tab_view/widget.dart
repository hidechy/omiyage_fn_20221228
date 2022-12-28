import 'package:flutter/material.dart';

import '../../../style/colors.dart';

class CustomTabView extends StatefulWidget {
  const CustomTabView({
    super.key,
    this.initPosition,
    this.itemCount,
    this.onPositionChange,
    this.onScroll,
    this.pageBuilder,
    this.tabBuilder,
  });

  final int? initPosition;
  final int? itemCount;
  final ValueChanged<int>? onPositionChange;
  final ValueChanged<double>? onScroll;
  final IndexedWidgetBuilder? pageBuilder;
  final IndexedWidgetBuilder? tabBuilder;

  @override
  _CustomTabsState createState() => _CustomTabsState();
}

class _CustomTabsState extends State<CustomTabView>
    with TickerProviderStateMixin {
  late TabController controller;
  late int _currentCount;
  late int _currentPosition;

  @override
  void initState() {
    //debugPrint('_CustomTabsState initState in.');
    _currentPosition = widget.initPosition!;
    controller = TabController(
      length: widget.itemCount!,
      vsync: this,
      initialIndex: _currentPosition,
    );
    controller.addListener(onPositionChange);
    controller.animation!.addListener(onScroll);
    _currentCount = widget.itemCount!;
    super.initState();
  }

  @override
  void didUpdateWidget(CustomTabView oldWidget) {
    //debugPrint('_CustomTabsState didUpdateWidget in.');
    if (_currentCount != widget.itemCount) {
      controller.animation!.removeListener(onScroll);
      controller
        ..removeListener(onPositionChange)
        ..dispose();

      if (widget.initPosition != null) {
        _currentPosition = widget.initPosition!;
      }

      if (_currentPosition > widget.itemCount! - 1) {
        _currentPosition = widget.itemCount! - 1;
        _currentPosition = _currentPosition < 0 ? 0 : _currentPosition;
        if (widget.onPositionChange is ValueChanged<int>) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              widget.onPositionChange!(_currentPosition);
            }
          });
        }
      }

      _currentCount = widget.itemCount!;
      setState(() {
        controller = TabController(
          length: widget.itemCount!,
          vsync: this,
          initialIndex: _currentPosition,
        );
        controller.addListener(onPositionChange);
        controller.animation!.addListener(onScroll);
      });
    } else if (widget.initPosition != null) {
      controller.animateTo(widget.initPosition!);
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    //debugPrint('_CustomTabsState dispose in.');
    controller.animation!.removeListener(onScroll);
    controller
      ..removeListener(onPositionChange)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //debugPrint('_CustomTabsState build in.');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          child: ColoredBox(
            color: IHSColors.white,
            child: TabBar(
              isScrollable: true,
              controller: controller,
              labelColor: IHSColors.black800,
              unselectedLabelColor: IHSColors.black800,
              indicator: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: IHSColors.black500,
                    width: 2,
                  ),
                ),
              ),
              tabs: List.generate(
                widget.itemCount!,
                (index) => widget.tabBuilder!(context, index),
              ),
            ),
          ),
        ),
        Expanded(
          child: ColoredBox(
            color: IHSColors.pink50,
            child: TabBarView(
              controller: controller,
              children: List.generate(
                widget.itemCount!,
                (index) => widget.pageBuilder!(context, index),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void onPositionChange() {
    //debugPrint('_CustomTabsState onPositionChange in.');
    if (!controller.indexIsChanging) {
      _currentPosition = controller.index;
      if (widget.onPositionChange is ValueChanged<int>) {
        widget.onPositionChange!(_currentPosition);
      }
    }
  }

  void onScroll() {
    //debugPrint('_CustomTabsState onScroll in.');
    if (widget.onScroll is ValueChanged<double>) {
      widget.onScroll!(controller.animation!.value);
    }
  }
}
