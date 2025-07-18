import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../theme/app_colors.dart';
import '../widgets/indicator.dart';
import 'pie_chart_data.dart';

class SimplePieChart extends StatefulWidget {
  const SimplePieChart({super.key});

  @override
  State<SimplePieChart> createState() => _SimplePieChartState();
}

class _SimplePieChartState extends State<SimplePieChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1.3,
          child: PieChart(
            PieChartData(
              pieTouchData: PieTouchData(
                touchCallback: (event, response) {
                  setState(() {
                    if (!event.isInterestedForInteractions ||
                        response?.touchedSection == null) {
                      touchedIndex = -1;
                    } else {
                      touchedIndex =
                          response!.touchedSection!.touchedSectionIndex;
                    }
                  });
                },
              ),
              borderData: FlBorderData(show: false),
              sectionsSpace: 0,
              centerSpaceRadius: 40,
              sections: getPieChartSections(touchedIndex),
            ),
          ),
        ),
        // Wrap(
        //   spacing: 16,
        //   runSpacing: 8,
        //   children: const [
        //     Indicator(color: AppColors.blue, text: 'Blue'),
        //     Indicator(color: AppColors.orange, text: 'Orange'),
        //     Indicator(color: AppColors.green, text: 'Green'),
        //     Indicator(color: AppColors.red, text: 'Red'),
        //   ],
        // ),
      ],
    );
  }
}
