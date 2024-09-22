// File: lib/screens/widgets/performance_metrics_chart.dart

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PerformanceMetricsChart extends StatelessWidget {
  final List<BarChartGroupData> data;

  const PerformanceMetricsChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: 100,
          barTouchData: BarTouchData(enabled: true),
          titlesData: FlTitlesData(
            show: true,
            rightTitles:   const AxisTitles(
// Suggested code may be subject to a license. Learn more: ~LicenseLog:2033011585.
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
// Suggested code may be subject to a license. Learn more: ~LicenseLog:2033011585.
              sideTitles: SideTitles(showTitles: false),
            ),
            leftTitles:  const AxisTitles(
              sideTitles:     SideTitles(
              showTitles: true,
              interval: 20,
              
              // getTextStyles: (context, value) => const TextStyle(
              //   color: Colors.black54,
              //   fontSize: 12,
              // ),
            ),
            ),
            
        
            bottomTitles: 
            
            AxisTitles(
              sideTitles:     SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                   switch (value.toInt()) {
                  case 1:
                    return const Text('Quiz 1', style: TextStyle(fontSize: 12, color: Colors.black54),);
                  case 2:
                    return const Text('Quiz 2', style: TextStyle(fontSize: 12, color: Colors.black54),);
                  case 3:
                    return const Text('Quiz 3', style: TextStyle(fontSize: 12, color: Colors.black54),);
                  case 4:
                    return const Text('Quiz 4', style: TextStyle(fontSize: 12, color: Colors.black54),);
                  case 5:
                    return const Text('Quiz 5', style: TextStyle(fontSize: 12, color: Colors.black54),);
                  default:
                    return const Text('');
                }
              },
              //getTitles: (double value) {
              //   switch (value.toInt()) {
              //     case 1:
              //       return 'Quiz 1';
              //     case 2:
              //       return 'Quiz 2';
              //     case 3:
              //       return 'Quiz 3';
              //     case 4:
              //       return 'Quiz 4';
              //     case 5:
              //       return 'Quiz 5';
              //     default:
              //       return '';
              //   }
              // },
              // getTextStyles: (context, value) => const TextStyle(
              //   color: Colors.black54,
              //   fontSize: 12,
              // ),
            ),

            )
        
         
         
          ),
          borderData: FlBorderData(
            show: false,
          ),
          barGroups: data,
          gridData: const FlGridData(show: false),
        ),
      ),
    );
  }
}
