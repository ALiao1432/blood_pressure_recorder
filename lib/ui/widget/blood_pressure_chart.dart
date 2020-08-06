import 'package:blood_pressure_recorder/model/blood_pressure.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BloodPressureChart extends StatelessWidget {
  final List<BloodPressure> data;
  final DateTime chartDisplayTime;

  const BloodPressureChart({
    @required this.data,
    @required this.chartDisplayTime,
  });

  @override
  Widget build(BuildContext context) {
    return LineChart(monthlyData(data, chartDisplayTime));
  }
}

LineChartData monthlyData(List<BloodPressure> data, DateTime displayDate) {
  final lastDayOfMonth =
      DateTime(displayDate.year, displayDate.month + 1, 0).day.toDouble();
  return LineChartData(
    minY: 0,
    maxY: 250,
    minX: 1,
    maxX: lastDayOfMonth,
    lineBarsData: barData(data),
  );
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
    colors: [Colors.red],
    barWidth: 8,
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
    colors: [Colors.blue],
    barWidth: 8,
    isStrokeCapRound: true,
    belowBarData: BarAreaData(show: false),
  );

  return [
    lowPressureBarData,
    heightPressureBarData,
  ];
}
