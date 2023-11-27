import 'package:flutter/material.dart';

extension NumExt on num {
  Widget get horizontalSpace => SizedBox(width: toDouble());
  Widget get verticalSpace => SizedBox(height: toDouble());
}


extension WidgetExt on Widget {
  Widget get toSliverBox => SliverToBoxAdapter(child: this);
  Widget withPaddingAll({required double value}) {
    return Padding(
      padding: EdgeInsets.all(value),
      child: this,
    );
  }

  Widget withPaddingSymmetric({
    double horizontal = 0,
    double vertical = 0,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontal,
        vertical: vertical,
      ),
      child: this,
    );
  }

  Widget withPaddingLeftTopRightBottom({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        left: left,
        top: top,
        right: right,
        bottom: bottom,
      ),
      child: this,
    );
  }
}
