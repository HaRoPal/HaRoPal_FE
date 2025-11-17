import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ExerciseGraph extends StatelessWidget {
  const ExerciseGraph({super.key});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: const FlGridData(show: false),
        titlesData: FlTitlesData(
          leftTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              getTitlesWidget: (value, meta) {
                switch (value.toInt()) {
                  case 1:
                    return const Text('Jan');
                  case 2:
                    return const Text('Feb');
                  case 3:
                    return const Text('Mar');
                  case 4:
                    return const Text('Apr');
                  case 5:
                    return const Text('May');
                  case 6:
                    return const Text('Jun');
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
        borderData: FlBorderData(show: true),
        lineBarsData: [
          LineChartBarData(
            spots: const [
              FlSpot(1, 70.0),
              FlSpot(2, 70.5),
              FlSpot(3, 69.8),
              FlSpot(4, 69.5),
              FlSpot(5, 68.9),
              FlSpot(6, 69.2),
            ],
            isCurved: true,
            color: Colors.blueAccent,
            barWidth: 3,
            dotData: const FlDotData(show: true),
            belowBarData: BarAreaData(
              show: true,
              color: Colors.blueAccent.withOpacity(0.2),
            ),
          ),
        ],
      ),
    );
  }
}