import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PingSpikesChart extends StatelessWidget {
  List<FlSpot> get actionSpots => [
        FlSpot(1440, 50), // 1 day ago
        FlSpot(480, 80), // 8 hours ago
        FlSpot(15, 120), // 15 minutes ago
      ];

  LineChartBarData get actionBarData => LineChartBarData(
        isCurved: false,
        color: Colors.blue,
        barWidth: 6,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: actionSpots,
      );

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        lineBarsData: [actionBarData],
        minY: 0,
        maxY: 150,
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                // Customize the titles based on x-axis values
                if (value == 1440) {
                  return Text('1 day ago', style: TextStyle(fontSize: 10));
                } else if (value == 480) {
                  return Text('8 hours ago', style: TextStyle(fontSize: 10));
                } else if (value == 15) {
                  return Text('15 min ago', style: TextStyle(fontSize: 10));
                }
                return Container(); // Return empty container if no title
              },
              reservedSize: 30,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false), // Hide y-axis titles
          ),
        ),
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: true),
        lineTouchData: LineTouchData(enabled: false),
      ),
    );
  }
}
