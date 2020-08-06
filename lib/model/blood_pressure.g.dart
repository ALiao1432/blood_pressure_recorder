// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blood_pressure.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BloodPressureAdapter extends TypeAdapter<BloodPressure> {
  @override
  final int typeId = 1;

  @override
  BloodPressure read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BloodPressure(
      recordDateTime: fields[0] as DateTime,
      lowPressure: fields[1] as int,
      heightPressure: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, BloodPressure obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.recordDateTime)
      ..writeByte(1)
      ..write(obj.lowPressure)
      ..writeByte(2)
      ..write(obj.heightPressure);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BloodPressureAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
