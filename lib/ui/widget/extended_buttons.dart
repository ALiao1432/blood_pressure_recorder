import 'package:dough/dough.dart';
import 'package:flutter/material.dart';

typedef OnAddPress = void Function();
typedef OnRightPress = void Function();

enum Mode {
  list,
  chart,
}

class ExtendedButtons extends StatelessWidget {
  final OnAddPress onAddPress;
  final OnRightPress onRightPress;
  final Mode mode;

  const ExtendedButtons({
    @required this.onAddPress,
    @required this.onRightPress,
    @required this.mode,
  });

  @override
  Widget build(BuildContext context) {
    const borderRadius = 16.0;
    final rightIcon = mode == Mode.list ? Icons.insert_chart : Icons.list;

    return FloatingActionButton.extended(
      backgroundColor: const Color(0xff3e4041),
      label: Row(
        children: [
          PressableDough(
            child: FlatButton(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(borderRadius),
                  bottomLeft: Radius.circular(borderRadius),
                ),
              ),
              onPressed: onAddPress,
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
          PressableDough(
            child: FlatButton(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(borderRadius),
                  bottomRight: Radius.circular(borderRadius),
                ),
              ),
              onPressed: onRightPress,
              child: Icon(
                rightIcon,
                color: Colors.white
              ),
            ),
          ),
        ],
      ),
      onPressed: () {},
    );
  }
}
