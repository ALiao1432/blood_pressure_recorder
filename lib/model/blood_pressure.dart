import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

part 'blood_pressure.g.dart';

@HiveType(typeId: 1)
class BloodPressure {
  @HiveField(0)
  DateTime recordDateTime;
  @HiveField(1)
  int lowPressure;
  @HiveField(2)
  int heightPressure;

  BloodPressure({
    @required this.recordDateTime,
    @required this.lowPressure,
    @required this.heightPressure,
  });
}
