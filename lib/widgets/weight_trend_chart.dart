import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:myapp/theme/colors.dart';
import 'package:myapp/theme/theme.dart';

class WeightTrendChart extends StatelessWidget {
  final List<double> points; // y-values
  final String startLabel;
  final String endLabel;

  const WeightTrendChart({
    super.key,
    required this.points,
    required this.startLabel,
    required this.endLabel,
  });

  @override
  Widget build(BuildContext context) {
    if (points.length < 2) {
      return const SizedBox(height: 120);
    }

    final minY = points.reduce((a, b) => a < b ? a : b);
    final maxY = points.reduce((a, b) => a > b ? a : b);
    final padding = (maxY - minY).abs() * 0.15 + 0.5;

    final spots = <FlSpot>[];
    for (int i = 0; i < points.length; i++) {
      spots.add(FlSpot(i.toDouble(), points[i]));
    }

    return SizedBox(
      height: 150,
      child: Stack(
        children: [
          LineChart(
            LineChartData(
              minX: 0,
              maxX: (points.length - 1).toDouble(),
              minY: minY - padding,
              maxY: maxY + padding,
              gridData: const FlGridData(show: false),
              borderData: FlBorderData(show: false),
              titlesData: const FlTitlesData(
                leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              lineTouchData: const LineTouchData(enabled: false),
              lineBarsData: [
                LineChartBarData(
                  spots: spots,
                  isCurved: true,
                  barWidth: 4,
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      AppColors.warningOrange,
                      AppColors.successGreen,
                    ],
                  ),
                  dotData: FlDotData(
                    show: true,
                    checkToShowDot: (spot, _) => spot.x == 0 || spot.x == points.length - 1,
                    getDotPainter: (spot, percent, bar, index) {
                      final isEnd = spot.x == points.length - 1;
                      return FlDotCirclePainter(
                        radius: 5,
                        color: isEnd ? AppColors.successGreen : AppColors.warningOrange,
                        strokeWidth: 2,
                        strokeColor: Colors.black.withOpacity(0.2),
                      );
                    },
                  ),
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppTheme.primaryAccent.withOpacity(0.12),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            top: 8,
            child: Text(
              startLabel,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppTheme.textSecondary),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Text(
              endLabel,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppTheme.successGreen),
            ),
          ),
        ],
      ),
    );
  }
}
