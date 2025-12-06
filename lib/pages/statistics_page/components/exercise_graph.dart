import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';

import '../../../controllers/statistics_page_controller.dart';

class ExerciseGraph extends StatefulWidget {
  const ExerciseGraph({super.key});

  @override
  State<ExerciseGraph> createState() => _ExerciseGraphState();
}

class _ExerciseGraphState extends State<ExerciseGraph> {
  final List<String> categories = ["bmi", "bmr", "weight", "exercise_time"];

  final Map<String, String> categoryLabels = {
    "bmi": "BMI",
    "bmr": "기초대사량",
    "weight": "체중",
    "exercise_time": "평균 운동 시간",
  };

  String selectedCategory = "bmi";

  final controller = Get.find<StatisticsPageController>();

  @override
  Widget build(BuildContext context) {
    final values = controller.statsList.map((e) => e[selectedCategory] as double).toList();
    final dates = controller.statsList.map((e) => e["date"].substring(5)).toList();

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '나의 변화 보기',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey[400]!),
                  ),
                  child: DropdownButton<String>(
                    value: selectedCategory,
                    dropdownColor: Colors.white,
                    underline: SizedBox.shrink(),
                    items: categories
                        .map((c) => DropdownMenuItem(
                              value: c,
                              child: Text(categoryLabels[c]!),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedCategory = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // 🔹 그래프
          Expanded(
            child: LineChart(
              LineChartData(
                minX: 0,
                maxX: values.length - 1,
                minY: (values.reduce((a, b) => a < b ? a : b)) - 5,
                maxY: (values.reduce((a, b) => a > b ? a : b)) + 5,

                gridData: FlGridData(show: true),

                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),

                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        // Hide the very first (minY) and the very last (maxY) labels
                        if (value == meta.min || value == meta.max) {
                          return SizedBox.shrink();
                        }
                        String formatted = value >= 1000
                            ? "${(value / 1000).toStringAsFixed(1)}K"
                            : value.toInt().toString();
                        return Text(
                          formatted,
                          style: TextStyle(fontSize: 10),
                        );
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        int index = value.toInt();
                        if (index >= 0 && index < dates.length && value == index.toDouble()) {
                          return Text(
                            dates[index],
                            style: const TextStyle(fontSize: 10),
                          );
                        }

                        return const SizedBox.shrink();
                      },
                      interval: 1,
                    ),
                  ),
                ),

                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      for (int i = 0; i < values.length; i++)
                        FlSpot(i.toDouble(), values[i]),
                    ],
                    isCurved: false,
                    color: Colors.blue,
                    dotData: FlDotData(show: true),
                    barWidth: 3,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}