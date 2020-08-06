import 'package:blood_pressure_recorder/model/blood_pressure.dart';
import 'package:dough/dough.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:intl/intl.dart';

typedef OnAddBloodPressurePress = void Function(BloodPressure bloodPressure);
typedef OnCancelPress = void Function();

class BloodPressureAdder extends StatefulWidget {
  final OnAddBloodPressurePress onAddBloodPressurePress;
  final OnCancelPress onCancelPress;

  const BloodPressureAdder({
    @required this.onAddBloodPressurePress,
    @required this.onCancelPress,
  });

  @override
  _BloodPressureAdderState createState() => _BloodPressureAdderState();
}

class _BloodPressureAdderState extends State<BloodPressureAdder> {
  final lowBloodPressureTextEditingController = TextEditingController();
  final heightBloodPressureTextEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  DateTime selectedDate;

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final _width = _size.width;

    return Container(
      width: _width * .8,
      decoration: const ShapeDecoration(
        shadows: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(8, 8),
            blurRadius: 3,
          ),
        ],
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextFormField(
                    controller: heightBloodPressureTextEditingController,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter.digitsOnly
                    ],
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: '高血壓',
                    ),
                    validator: _validText,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: lowBloodPressureTextEditingController,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter.digitsOnly
                    ],
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: '低血壓',
                    ),
                    validator: _validText,
                  ),
                  const SizedBox(height: 10),
                  FlatButton.icon(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    onPressed: () async {
                      final now = DateTime.now();
                      selectedDate = await showRoundedDatePicker(
                        context: context,
                        initialDate: now,
                        firstDate: DateTime(now.year - 3),
                        lastDate: now,
                      );
                      setState(() {});
                    },
                    label: const Text('修改'),
                    icon: Expanded(
                      child: Row(
                        children: [
                          const Icon(Icons.calendar_today),
                          const SizedBox(width: 10),
                          Text(
                            DateFormat('yyyy / MM / dd').format(selectedDate ?? DateTime.now()),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: RaisedButton(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      color: Colors.white,
                      onPressed: () => handleRecordButtonPress(),
                      child: const PressableDough(
                        child: Text('紀錄'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: FlatButton(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      onPressed: widget.onCancelPress,
                      child: const PressableDough(
                        child: Text('取消'),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _validText(String value) {
    if (value.isEmpty) {
      return '不能為空';
    }
    return null;
  }

  void handleRecordButtonPress() {
    if (!_formKey.currentState.validate()) {
      return;
    }

    final bloodPressure = BloodPressure(
      recordDateTime: selectedDate ?? DateTime.now(),
      lowPressure: int.parse(lowBloodPressureTextEditingController.text),
      heightPressure: int.parse(heightBloodPressureTextEditingController.text),
    );
    widget.onAddBloodPressurePress(bloodPressure);

    selectedDate = null;
    lowBloodPressureTextEditingController.clear();
    heightBloodPressureTextEditingController.clear();
  }
}
