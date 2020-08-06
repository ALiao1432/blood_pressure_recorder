import 'package:flutter/material.dart';

typedef OnDecreaseMonthPress = void Function();
typedef OnIncreaseMonthPress = void Function();

class DateHeader extends StatelessWidget {
  final DateTime displayTime;
  final OnDecreaseMonthPress onDecreaseMonthPress;
  final OnIncreaseMonthPress onIncreaseMonthPress;
  final now = DateTime.now();

  DateHeader({
    @required this.displayTime,
    @required this.onDecreaseMonthPress,
    @required this.onIncreaseMonthPress,
  });

  @override
  Widget build(BuildContext context) {
    final isEnableIncreaseButton =
        !(displayTime.year == now.year && displayTime.month == now.month);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: onDecreaseMonthPress,
        ),
        Text(
          '${displayTime.year} / ${displayTime.month}',
          style: const TextStyle(fontSize: 20),
        ),
        IconButton(
          icon: const Icon(Icons.arrow_forward_ios),
          onPressed: isEnableIncreaseButton ? onIncreaseMonthPress : null,
        ),
      ],
    );
  }
}
