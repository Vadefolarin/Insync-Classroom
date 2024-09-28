// File: lib/widgets/average_score_chart.dart

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class AverageScoreChart extends StatelessWidget {
  final Map<String, double> dataMap;

  const AverageScoreChart({super.key, required this.dataMap});

  @override
  Widget build(BuildContext context) {
    if (dataMap.isEmpty) {
      return const Center(child: Text('No data available.'));
    }

    List<BarChartGroupData> barGroups = [];
    int index = 0;
    dataMap.forEach((quiz, score) {
      barGroups.add(
        BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(
              toY: score,
              color: Colors.blue,
              width: 22,
              borderRadius: BorderRadius.circular(4),
            ),
          ],
        ),
      );
      index++;
    });

    return Container(
      height: 300,
      padding: const EdgeInsets.all(8.0),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: 100,
          barTouchData: BarTouchData(enabled: true),
          titlesData: FlTitlesData(
            show: true,
            leftTitles: 
            const AxisTitles(
              sideTitles:    SideTitles(
              showTitles: true,
              interval: 20,
              // getTextStyles: (context, value) => TextStyle(
              //   color: Colors.black54,
              //   fontSize: 12,
              // ),
            ),

            ),
         
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                  int idx = value.toInt();
                if (idx >= 0 && idx < dataMap.keys.length) {
                  return Text(dataMap.keys.elementAt(idx).length > 10
                      ? '${dataMap.keys.elementAt(idx).substring(0, 10)}...'
                      : dataMap.keys.elementAt(idx));
                }
                return const Text('Nothing');
              },
              
              // getTitles: (double value) {
              //   int idx = value.toInt();
              //   if (idx >= 0 && idx < dataMap.keys.length) {
              //     return dataMap.keys.elementAt(idx).length > 10
              //         ? '${dataMap.keys.elementAt(idx).substring(0, 10)}...'
              //         : dataMap.keys.elementAt(idx);
              //   }
              //   return '';
              // },
              // rotateAngle: 45,
              // margin: 16,
              // getTextStyles: (context, value) => TextStyle(
              //   color: Colors.black87,
              //   fontSize: 10,
              // ),
            ),
            )
          ),
          borderData: FlBorderData(
            show: false,
          ),
          barGroups: barGroups,
          gridData: const FlGridData(show: true),
        ),
      ),
    );
  }
}