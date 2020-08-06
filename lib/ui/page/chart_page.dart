import 'package:blood_pressure_recorder/constant.dart';
import 'package:blood_pressure_recorder/extension/extension.dart';
import 'package:blood_pressure_recorder/model/blood_pressure.dart';
import 'package:blood_pressure_recorder/ui/widget/blood_pressure_adder_form.dart';
import 'package:blood_pressure_recorder/ui/widget/blood_pressure_chart.dart';
import 'package:blood_pressure_recorder/ui/widget/date_header.dart';
import 'package:blood_pressure_recorder/ui/widget/empty_data_hint.dart';
import 'package:blood_pressure_recorder/ui/widget/extended_buttons.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jiffy/jiffy.dart';

class ChartPage extends StatefulWidget {
  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  bool showAdderView = false;
  DateTime chartDisplayTime = DateTime.now();
  Widget animatedWidget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable:
            Hive.box<BloodPressure>(bloodPressureBoxName).listenable(),
        builder: (context, Box<BloodPressure> box, child) {
          final data = getMonthlyData(box, chartDisplayTime);

          return Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DateHeader(
                      displayTime: chartDisplayTime,
                      onDecreaseMonthPress: _onDecreaseMonthPress,
                      onIncreaseMonthPress: _onIncreaseMonthPress,
                    ),
                    AnimatedSwitcher(
                      transitionBuilder: (child, animation) => ScaleTransition(
                        scale: animation,
                        child: child,
                      ),
                      duration: const Duration(milliseconds: 5000),
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: data.isEmpty
                              ? EmptyDataHint()
                              : BloodPressureChart(
                                  data: data,
                                  chartDisplayTime: chartDisplayTime,
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              BloodPressureAdderForm(
                onAddBloodPressurePress: _onAddBloodPressurePress,
                onCancelPress: () {
                  setState(() {
                    showAdderView = false;
                  });
                },
                showAdderView: showAdderView,
              ),
            ],
          );
        },
      ),
      floatingActionButton: ExtendedButtons(
        onAddPress: () {
          setState(() {
            showAdderView = true;
          });
        },
        onRightPress: () {
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/list', (route) => false);
        },
        mode: Mode.chart,
      ),
    );
  }

  void _onAddBloodPressurePress(BloodPressure bloodPressure) {
    Hive.box<BloodPressure>(bloodPressureBoxName)
        .put(bloodPressure.hashCode, bloodPressure);
    setState(() {
      showAdderView = false;
    });
  }

  void _onDecreaseMonthPress() {
    final result = Jiffy(chartDisplayTime).subtract(months: 1);
    setState(() {
      chartDisplayTime = result;
    });
  }

  void _onIncreaseMonthPress() {
    final result = Jiffy(chartDisplayTime).add(months: 1);
    setState(() {
      chartDisplayTime = result;
    });
  }

  List<BloodPressure> getMonthlyData(
    Box<BloodPressure> box,
    DateTime displayDate,
  ) =>
      box.orderBox(
        whereRange: (b) => b.isSameMonthRecord(displayDate.month),
        sortRule: orderByDateTimeDesc,
      );
}
