// File: lib/widgets/participation_rate_chart.dart

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ParticipationRateChart extends StatelessWidget {
  final Map<String, double> dataMap;

  ParticipationRateChart({required this.dataMap});

  @override
  Widget build(BuildContext context) {
    if (dataMap.isEmpty) {
      return Center(child: Text('No data available.'));
    }

    List<BarChartGroupData> barGroups = [];
    int index = 0;
    dataMap.forEach((quiz, rate) {
      barGroups.add(
        BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(
              toY: rate,
              color: Colors.green,
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
      padding: EdgeInsets.all(8.0),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: 100,
          barTouchData: BarTouchData(enabled: true),
          titlesData: FlTitlesData(
            show: true,
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
              showTitles: true,
              interval: 20,
              // getTextStyles: (context, value) => TextStyle(
              //   color: Colors.black54,
              //   fontSize: 12,
              // ),
            ),
            ),
            bottomTitles: AxisTitles(sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                int idx = value.toInt();
                if (idx >= 0 && idx < dataMap.keys.length) {
                  return Text('${dataMap.keys.elementAt(idx).length > 10
                      ? '${dataMap.keys.elementAt(idx).substring(0, 10)}...'
                      : dataMap.keys.elementAt(idx)}');
                }
                return Text('');
              },
              // getTitles: (double value) {
              //   int idx = value.toInt();
              //   if (idx >= 0 && idx < dataMap.keys.length) {
              //     return dataMap.keys.elementAt(idx).length > 10
              //         ? '${dataMap.keys.elementAt(idx).substring(0, 10)}...'
              //         : dataMap.keys.elementAt(idx);
              //   }
                // return '';
              
              // rotateAngle: 45,
              // margin: 16,
              // getTextStyles: (context, value) => TextStyle(
              //   color: Colors.black87,
              //   fontSize: 10,
              // ),
            ),)
          ),
          borderData: FlBorderData(
            show: false,
          ),
          barGroups: barGroups,
          gridData: FlGridData(show: true),
        ),
      ),
    );
  }
}
