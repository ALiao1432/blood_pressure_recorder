import 'package:blood_pressure_recorder/constant.dart';
import 'package:blood_pressure_recorder/ui/widget/blood_pressure_adder.dart';
import 'package:blood_pressure_recorder/ui/widget/date_header.dart';
import 'package:blood_pressure_recorder/ui/widget/extended_buttons.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: Hive.box(bloodPressureBoxName).listenable(),
        builder: (context, Box box, child) {
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
                  ],
                ),
              ),
              AnimatedContainer(
                curve: Curves.fastLinearToSlowEaseIn,
                duration: const Duration(milliseconds: 1000),
                transform: Matrix4.translationValues(
                  0,
                  showAdderView ? 0 : 50,
                  0,
                ),
                child: Align(
                  alignment: FractionalOffset(
                    showAdderView ? .5 : .5,
                    showAdderView ? .5 : 2,
                  ),
                  child: BloodPressureAdder(
                    onAddBloodPressurePress: (bloodPressure) {
                      box.add(bloodPressure);
                      setState(() {
                        showAdderView = false;
                      });
                    },
                    onCancelPress: () {
                      setState(() {
                        showAdderView = false;
                      });
                    },
                  ),
                ),
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
}