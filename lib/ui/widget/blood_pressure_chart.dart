import 'package:blood_pressure_recorder/constant.dart';
import 'package:blood_pressure_recorder/model/blood_pressure.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../constant.dart';

class BloodPressureChart extends StatelessWidget {
  final List<BloodPressure> data;
  final DateTime chartDisplayTime;

  const BloodPressureChart({
    @required this.data,
    @required this.chartDisplayTime,
  });

  @override
  Widget build(BuildContext context) {
    return LineChart(
      monthlyData(
        context,
        data,
        chartDisplayTime,
      ),
    );
  }

  LineChartData monthlyData(
    BuildContext context,
    List<BloodPressure> data,
    DateTime displayDate,
  ) {
    final lastDayOfMonth =
        DateTime(displayDate.year, displayDate.month + 1, 0).day.toDouble();
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(.8),
        ),
      ),
      gridData: FlGridData(show: false),
      backgroundColor: const Color(0x10dddddd),
      titlesData: getTitlesData(context),
      minY: minBloodPressure,
      maxY: maxBloodPressure,
      minX: 1,
      maxX: lastDayOfMonth,
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(color: Colors.grey),
        ),
      ),
      lineBarsData: barData(data),
    );
  }

  FlTitlesData getTitlesData(BuildContext context) {
    return FlTitlesData(
        leftTitles: SideTitles(
          textStyle: Theme.of(context).textTheme.headline6,
          interval: 20,
          showTitles: true,
        ),
        bottomTitles: SideTitles(
          textStyle: Theme.of(context).textTheme.headline6,
          interval: 5,
          showTitles: true,
        ));
  }

  List<LineChartBarData> barData(List<BloodPressure> data) {
    final lowPressureSpot = data
        .map((b) => FlSpot(
              b.recordDateTime.day.toDouble(),
              b.lowPressure.toDouble(),
            ))
        .toList();
    final lowPressureBarData = LineChartBarData(
      spots: lowPressureSpot,
      isCurved: true,
      colors: [const Color(0xff5cac63)],
      barWidth: 4,
      isStrokeCapRound: true,
      belowBarData: BarAreaData(show: false),
    );

    final heightPressureSpot = data
        .map((b) => FlSpot(
              b.recordDateTime.day.toDouble(),
              b.heightPressure.toDouble(),
            ))
        .toList();
    final heightPressureBarData = LineChartBarData(
      spots: heightPressureSpot,
      isCurved: true,
      colors: [const Color(0xff4b9fd7)],
      barWidth: 4,
      isStrokeCapRound: true,
      belowBarData: BarAreaData(show: false),
    );

    return [
      lowPressureBarData,
      heightPressureBarData,
    ];
  }
}
