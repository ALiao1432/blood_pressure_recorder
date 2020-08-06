import 'package:blood_pressure_recorder/constant.dart';
import 'package:blood_pressure_recorder/model/blood_pressure.dart';
import 'package:blood_pressure_recorder/ui/widget/blood_pressure_adder.dart';
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
        valueListenable: Hive.box(bloodPressureBoxName).listenable(),
        builder: (context, Box box, child) {
          return Stack(
            children: [
              ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, id) {
                  final bloodPressure = box.getAt(id) as BloodPressure;
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
                      onPressed: () => box.deleteAt(id),
                    ),
                  );
                },
                itemCount: box.length,
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
              )
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
}
