import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:myapp/theme/theme.dart';

class SimpleLineChart extends StatelessWidget {
  final List<FlSpot> dataPoints;
  final double minY, maxY;
  final String startLabel, endLabel;

  const SimpleLineChart({
    super.key,
    required this.dataPoints,
    required this.minY,
    required this.maxY,
    required this.startLabel,
    required this.endLabel,
  });

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        minY: minY,
        maxY: maxY,
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              getTitlesWidget: (value, meta) {
                Widget text;
                if (value.toInt() == 0) {
                  text = Text(
                    startLabel,
                    style: Theme.of(context).textTheme.bodySmall,
                  );
                } else if (value.toInt() == dataPoints.length - 1) {
                  text = Text(
                    endLabel,
                    style: Theme.of(context).textTheme.bodySmall,
                  );
                } else {
                  text = const Text('');
                }
                return SideTitleWidget(axisSide: meta.axisSide, child: text);
              },
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: dataPoints,
            isCurved: true,
            color: AppTheme.primaryAccent,
            barWidth: 4,
            isStrokeCapRound: true,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: [
                  AppTheme.primaryAccent.withAlpha(77),
                  AppTheme.primaryAccent.withAlpha(0),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
