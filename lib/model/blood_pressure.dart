import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:equatable/equatable.dart';

part 'blood_pressure.g.dart';

@HiveType(typeId: 1)
class BloodPressure extends Equatable {
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

  bool isSameMonthRecord(int month) => recordDateTime.month == month;

  @override
  List<Object> get props => [recordDateTime, lowPressure, heightPressure];
}

int orderByDateTimeDesc(BloodPressure b1, BloodPressure b2) =>
    b1.recordDateTime.millisecondsSinceEpoch -
    b2.recordDateTime.millisecondsSinceEpoch;
