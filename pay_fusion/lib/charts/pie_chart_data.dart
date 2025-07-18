import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

List<PieChartSectionData> getPieChartSections(int touchedIndex) {
  const data = [
    {'value': 35.0, 'color': AppColors.blue, 'label': 'Blue'},
    {'value': 25.0, 'color': AppColors.orange, 'label': 'Orange'},
    {'value': 20.0, 'color': AppColors.green, 'label': 'Green'},
    {'value': 20.0, 'color': AppColors.red, 'label': 'Red'},
  ];

  return List.generate(data.length, (i) {
    final isTouched = i == touchedIndex;
    final double radius = isTouched ? 60.0 : 50.0;
    final double fontSize = isTouched ? 18.0 : 14.0;

    return PieChartSectionData(
      color: data[i]['color'] as Color,
      value: data[i]['value'] as double,
      title: '${data[i]['value']}%',
      radius: radius,
      titleStyle: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: AppColors.white,
      ),
    );
  });
}
