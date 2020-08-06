import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

typedef SortRule<E> = int Function(E o1, E o2);
typedef WhereRange<E> = bool Function(E o);

extension BoxExtension<BoxType> on Box<BoxType> {
  List<BoxType> orderBox({
    @required WhereRange<BoxType> whereRange,
    @required SortRule<BoxType> sortRule,
  }) {
    return values.where(whereRange).toList()..sort(sortRule);
  }
}
