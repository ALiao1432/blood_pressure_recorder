import 'package:flutter/material.dart';

import 'blood_pressure_adder.dart';

class BloodPressureAdderForm extends StatefulWidget {
  final OnAddBloodPressurePress onAddBloodPressurePress;
  final OnCancelPress onCancelPress;
  final bool showAdderView;

  const BloodPressureAdderForm({
    @required this.onAddBloodPressurePress,
    @required this.onCancelPress,
    @required this.showAdderView,
  });

  @override
  _BloodPressureAdderFormState createState() => _BloodPressureAdderFormState();
}

class _BloodPressureAdderFormState extends State<BloodPressureAdderForm> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      curve: Curves.fastLinearToSlowEaseIn,
      duration: const Duration(milliseconds: 1000),
      transform: Matrix4.translationValues(
        0,
        widget.showAdderView ? 0 : 50,
        0,
      ),
      child: Align(
        alignment: FractionalOffset(
          widget.showAdderView ? .5 : .5,
          widget.showAdderView ? .5 : 2,
        ),
        child: BloodPressureAdder(
          onAddBloodPressurePress: widget.onAddBloodPressurePress,
          onCancelPress: widget.onCancelPress,
        ),
      ),
    );
  }
}
