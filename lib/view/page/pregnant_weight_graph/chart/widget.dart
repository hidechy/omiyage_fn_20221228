import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '/extension/date_time.dart';
import '/view/style/text_style.dart';
import '../../../../data/model/pregnant_weight_record_graph/model.dart';
import '../../child_growth_graph/graph/style.dart';
import 'arrow/widget.dart';

/// 体重グラフ
class WeightChart extends StatefulWidget {
  const WeightChart({
    super.key,
    required this.birthDay,
    required this.records,
  });

  /// 出産予定日（子ども選択中の場合は出産予定日）
  final DateTime birthDay;
  final List<WeightGraphData> records;

  @override
  State<WeightChart> createState() => _WeightChartState();
}

class _WeightChartState extends State<WeightChart> {
  List<WeightGraphData> get _records => widget.records;

  /// 現在のX軸の最小値
  int _currentBaseX = 0;

  /// X軸の最小値
  int get _minX => 0;

  /// X軸の最小値
  int get _maxX => 60;

  /// X軸の数
  int get _countX => 5;

  // Y軸の値の刻み
  int get yInterval => 5;

  /// Y軸の数
  int get _countY => ((_maxY - _minY) ~/ 5) + 1;

  // 記録日から妊娠週数を算出
  double _getWeekFromDate(DateTime date) {
    // 妊娠した日 (出産予定日-280)
    final startDate = widget.birthDay.add(const Duration(days: -280));
    // 妊娠した日とdateの日付の差
    final days = startDate.daysBetween(date);
    // 週数
    final week = days / 7;
    return week;
  }

  /// Y軸最小値（登録済みの最小の体重-5）
  int get _minY {
    final weightList = _records.map((e) => e.weight).toList();
    if (weightList.isEmpty) {
      return 50; // 何も登録がなければ50
    }
    // 登録済みの最小の体重-5
    return (weightList.reduce(min) ~/ 5) * 5 - 5;
  }

  /// Y軸最大値（登録済みの最大の体重+15）
  int get _maxY {
    final weightList = _records.map((e) => e.weight).toList();
    if (weightList.isEmpty) {
      return 60; // 何も登録がなければ60
    }
    // 登録済みの最大の体重+15
    return (weightList.reduce(max) ~/ 5) * 5 + 15;
  }

  @override
  Widget build(BuildContext context) {
    final activeBackBtn = _currentBaseX > _minX;
    final activeForwardBtn = _currentBaseX + _countX - 1 < _maxX;
    return Column(
      children: [
        Row(
          children: [
            const SizedBox(width: 8),
            Text(
              '体重(kg)',
              style:
                  IHSTextStyle.xSmall.copyWith(color: IHSGraphStyle.mainColor),
            ),
          ],
        ),
        const SizedBox(height: 12),
        AspectRatio(
          aspectRatio: 1,
          child: LineChart(
            _buildData(),
          ),
        ),
        Text(
          '妊娠期間(週目)',
          style: IHSTextStyle.xSmall,
          textAlign: TextAlign.center,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BackArrow(
              active: activeBackBtn,
              onPressed: () {
                setState(
                  () {
                    if (!activeBackBtn) {
                      return;
                    }
                    _currentBaseX -= 2;
                  },
                );
              },
            ),
            ForwardArrow(
              active: activeForwardBtn,
              onPressed: () {
                setState(
                  () {
                    if (!activeForwardBtn) {
                      return;
                    }
                    _currentBaseX += 2;
                  },
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  LineChartData _buildData() {
    return LineChartData(
      clipData: FlClipData.all(),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        // 横線レイアウト
        getDrawingHorizontalLine: (value) {
          return IHSGraphStyle.drawingLine;
        },
        // 縦線レイアウト
        getDrawingVerticalLine: (value) {
          return IHSGraphStyle.drawingLine;
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        // x軸のタイトル
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 32,
            interval: 1,
            getTitlesWidget: _bottomTitleWidgets,
          ),
        ),
        // y軸(左)のタイトル
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: _leftTitleWidgets,
            reservedSize: 32,
          ),
        ),
        // y軸(右)のタイトル
        rightTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 8,
            getTitlesWidget: (double value, TitleMeta meta) {
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
      // ボーターレイアウト
      borderData: IHSGraphStyle.borderLayout,
      // タップ中のレイアウト
      lineTouchData: IHSGraphStyle.touchData,
      minX: _currentBaseX.toDouble(),
      maxX: _currentBaseX + _countX - 1,
      minY: 0,
      maxY: _countY.toDouble(),
      lineBarsData: widget.records.isNotEmpty
          ? [
              // 記録
              LineChartBarData(
                spots: _buildSpotList(),
                isCurved: false,
                barWidth: 1,
                color: IHSGraphStyle.mainColor,
                isStrokeCapRound: true,
                dotData: IHSGraphStyle.mainDotLayout,
                belowBarData: BarAreaData(
                  show: false,
                ),
              ),
            ]
          : null,
    );
  }

  /// 縦軸(左)のタイトル
  Widget _leftTitleWidgets(double value, TitleMeta meta) {
    final index = value.toInt();
    final titleInt = index * 5 + _minY;
    return Text(
      titleInt.toString(),
      style: IHSTextStyle.xSmall.copyWith(
        color: IHSGraphStyle.mainColor,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _bottomTitleWidgets(
    double value,
    TitleMeta meta,
  ) {
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Text(
          value.toInt().toString(),
          style: IHSTextStyle.xSmall.copyWith(height: 1),
        ),
      ),
    );
  }

  // プロット
  List<FlSpot> _buildSpotList() {
    final list = <FlSpot>[];
    _records.forEach(
      (record) {
        final x = _getWeekFromDate(record.measurementDate);
        final y = (record.weight - _minY) / yInterval;
        final spot = FlSpot(x, y);
        list.add(spot);
      },
    );
    return list;
  }
}
