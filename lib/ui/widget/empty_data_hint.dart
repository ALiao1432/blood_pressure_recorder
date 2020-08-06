import 'package:flutter/material.dart';

class EmptyDataHint extends StatelessWidget {
  final DateTime time;

  const EmptyDataHint({@required this.time});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('No Data for ${time.year} / ${time.month}'),
    );
  }
}
