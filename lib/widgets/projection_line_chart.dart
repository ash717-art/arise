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
    this.height = 220,
    this.showLegend = true,
    this.showTitle = true,
    this.showRankLabels = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: LineChart(
        LineChartData(
          minX: 0,
          maxX: 3,
          minY: 0,
          maxY: 6,
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                getTitlesWidget: (value, meta) {
                  final style = TextStyle(
                    color: Colors.white.withOpacity(0.55),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  );
                  switch (value.toInt()) {
                    case 1:
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text('month 1', style: style),
                      );
                    case 2:
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text('month 3', style: style.copyWith(color: AppColors.primary)),
                      );
                    case 3:
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text('month 4', style: style),
                      );
                    default:
                      return const SizedBox.shrink();
                  }
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: showRankLabels,
                reservedSize: 30,
                getTitlesWidget: (value, meta) {
                  final style = TextStyle(
                    color: Colors.white.withOpacity(0.65),
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  );
                  switch (value.toInt()) {
                    case 0:
                      return Text('A', style: style);
                    case 1:
                      return Text('B', style: style);
                    case 2:
                      return Text('C', style: style);
                    case 3:
                      return Text('D', style: style);
                    case 4:
                      return Text('E', style: style);
                    case 5:
                      return Text('S', style: style);
                    default:
                      return const SizedBox.shrink();
                  }
                },
              ),
            ),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: 1,
            getDrawingHorizontalLine: (value) => FlLine(
              color: Colors.white.withOpacity(0.06),
              strokeWidth: 1,
            ),
          ),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            // with Arise
            LineChartBarData(
              spots: const [
                FlSpot(0, 0.3),
                FlSpot(1, 2.1),
                FlSpot(2, 3.4),
                FlSpot(2.2, 4.0),
                FlSpot(3, 5.0),
              ],
              isCurved: true,
              curveSmoothness: 0.22,
              color: AppColors.primary,
              barWidth: 3.5,
              isStrokeCapRound: true,
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) {
                  final isFocus = (spot.x - 2).abs() < 0.05;
                  return FlDotCirclePainter(
                    radius: isFocus ? 8 : 4,
                    color: isFocus ? AppColors.primary.withOpacity(0.25) : AppColors.primary,
                    strokeWidth: isFocus ? 2 : 0,
                    strokeColor: isFocus ? AppColors.primary : Colors.transparent,
                  );
                },
              ),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.primary.withOpacity(0.35),
                    AppColors.primary.withOpacity(0.0),
                  ],
                ),
              ),
            ),
            // without Arise (flat gray)
            LineChartBarData(
              spots: const [
                FlSpot(0, 0.3),
                FlSpot(1, 0.8),
                FlSpot(2, 0.8),
                FlSpot(3, 1.0),
              ],
              isCurved: true,
              curveSmoothness: 0.25,
              color: Colors.white.withOpacity(0.35),
              barWidth: 2.5,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(show: false),
            ),
          ],
          extraLinesData: ExtraLinesData(verticalLines: [
            VerticalLine(
              x: 2,
              color: AppColors.primary.withOpacity(0.7),
              strokeWidth: 2,
              dashArray: [6, 6],
              label: VerticalLineLabel(
                show: false,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
