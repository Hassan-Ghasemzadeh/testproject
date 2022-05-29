import 'package:flutter/cupertino.dart';

extension WidgetPadding on Widget {
  //padding all
  Widget paddingAll(double padding) => Padding(
        padding: EdgeInsets.all(padding),
        child: this,
      );

  //padding cross
  Widget paddingCross(double top, double bottom, double left, double right) =>
      Padding(
        padding:
            EdgeInsets.only(top: top, bottom: bottom, left: left, right: right),
        child: this,
      );
}
