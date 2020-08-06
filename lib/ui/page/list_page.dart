import 'package:blood_pressure_recorder/constant.dart';
import 'package:blood_pressure_recorder/extension/extension.dart';
import 'package:blood_pressure_recorder/model/blood_pressure.dart';
import 'package:blood_pressure_recorder/ui/widget/blood_pressure_adder_form.dart';
import 'package:blood_pressure_recorder/ui/widget/extended_buttons.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  bool showAdderView = false;
  final dateFormatter = DateFormat('yyyy / MM / dd HH:mm');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable:
            Hive.box<BloodPressure>(bloodPressureBoxName).listenable(),
        builder: (context, Box<BloodPressure> box, child) {
          final orderData = box.orderBox(
            whereRange: (b) => true,
            sortRule: orderByDateTimeDesc,
          );
          return Stack(
            children: [
              ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, id) {
                  final bloodPressure = orderData[id];
                  final dateTimeResult =
                      dateFormatter.format(bloodPressure.recordDateTime);
                  return ListTile(
                    contentPadding: const EdgeInsets.all(20),
                    title: Text(
                      '高血壓: ${bloodPressure.heightPressure}\n低血壓: ${bloodPressure.lowPressure}',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      dateTimeResult,
                      style: const TextStyle(fontSize: 20),
                    ),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete_forever,
                        color: Colors.black,
                        size: 40,
                      ),
                      onPressed: () => box.delete(bloodPressure.hashCode),
                    ),
                  );
                },
                itemCount: orderData.length,
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
              .pushNamedAndRemoveUntil('/chart', (route) => false);
        },
        mode: Mode.list,
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
}
