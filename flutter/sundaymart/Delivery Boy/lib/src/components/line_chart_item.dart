import 'package:flutter/material.dart';

class LineChartItem extends StatelessWidget {
  final Color? backgroundColor;

  const LineChartItem({Key? key, this.backgroundColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 16,
      width: 25,
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: backgroundColor),
    );
  }
}
