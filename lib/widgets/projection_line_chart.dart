import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:myapp/theme/colors.dart';

class ProjectionLineChart extends StatelessWidget {
  final double height;
  final bool showLegend;
  final bool showTitle;
  final bool showRankLabels;

  const ProjectionLineChart({
    super.key,
    required this.height,
    this.showLegend = false,
    this.showTitle = true,
    this.showRankLabels = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
            show: true,
            drawVerticalLine: true,
            verticalInterval: 1,
            drawHorizontalLine: false,
            getDrawingVerticalLine: (value) {
              if (value == 0) {
                return const FlLine(color: Colors.transparent);
              }
              return const FlLine(
                color: AppColors.mutedGreyLine,
                strokeWidth: 1,
                dashArray: [4, 4],
              );
            },
          ),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: showTitle,
                getTitlesWidget: (value, meta) {
                  const style = TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  );
                  String text;
                  switch (value.toInt()) {
                    case 0:
                      text = 'Start';
                      break;
                    case 1:
                      text = 'Month 1';
                      break;
                    case 2:
                      text = 'Month 2';
                      break;
                    case 3:
                      text = 'Month 3';
                      break;
                    default:
                      return const SizedBox.shrink();
                  }
                  return SideTitleWidget(
                    axisSide: meta.axisSide,
                    space: 10,
                    child: Text(text, style: style),
                  );
                },
                reservedSize: 30,
                interval: 1,
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: showRankLabels,
                getTitlesWidget: (value, meta) {
                  const style = TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  );
                  String text;
                  switch (value.toInt()) {
                    case 0:
                      text = 'E';
                      break;
                    case 1:
                      text = 'D';
                      break;
                    case 2:
                      text = 'C';
                      break;
                    case 3:
                      text = 'B';
                      break;
                    case 4:
                      text = 'A';
                      break;
                    case 5:
                      text = 'S';
                      break;
                    default:
                      return const SizedBox.shrink();
                  }
                  return Text(text, style: style, textAlign: TextAlign.center);
                },
                reservedSize: 40,
                interval: 1,
              ),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          borderData: FlBorderData(show: false),
          minX: 0,
          maxX: 3,
          minY: 0,
          maxY: 5.5,
          lineBarsData: [
            LineChartBarData(
              spots: const [
                FlSpot(0, 0.2), // Start at E
                FlSpot(1, 1.2), // Month 1 at D
                FlSpot(2, 2.8), // Month 2 at C+
                FlSpot(3, 4.2), // Month 3 at A
              ],
              isCurved: true,
              color: AppColors.success,
              barWidth: 4,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                color: AppColors.success.withAlpha(51),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
