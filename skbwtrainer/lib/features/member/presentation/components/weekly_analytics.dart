import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../../themes/app_font.dart';

class WeeklyAnalytics extends StatefulWidget {
  final List<int> weekAttendance;

  const WeeklyAnalytics({super.key, required this.weekAttendance});

  @override
  State<WeeklyAnalytics> createState() => _WeeklyAnalyticsState();
}

class _WeeklyAnalyticsState extends State<WeeklyAnalytics> {
  // get the maximum attendance in a day
  int get maxAttendance =>
      widget.weekAttendance.reduce((a, b) => a > b ? a : b);

  // a widget to display the weekly analytics in for of graph per day
  @override
  Widget build(BuildContext context)
  {
    return maxAttendance == 0
        ? Center(
            child: Text(
              'No attendance records yet.',
              style: TextStyle(
                fontFamily: AppFont.primaryFont,
              ),
            ),
          )
        : BarChart(
            BarChartData(
              barTouchData: barTouchData,
              titlesData: titlesData,
              borderData: borderData,
              barGroups: getBarGroups(),
              gridData: const FlGridData(show: false),
              alignment: BarChartAlignment.spaceAround,
              maxY: maxAttendance.toDouble(),
            ),
          );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (group) => Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              TextStyle(
                color: Theme.of(context).colorScheme.onSecondary,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  Widget getTitles(double value, TitleMeta meta) {
    final style = TextStyle(
      color: Theme.of(context).colorScheme.onSecondary,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Mn';
        break;
      case 1:
        text = 'Tu';
        break;
      case 2:
        text = 'Wd';
        break;
      case 3:
        text = 'Th';
        break;
      case 4:
        text = 'Fr';
        break;
      case 5:
        text = 'St';
        break;
      case 6:
        text = 'Sn';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  LinearGradient get _barsGradient => LinearGradient(
        colors: [
          Theme.of(context).colorScheme.primary.withAlpha(100),
          Theme.of(context).colorScheme.primary,
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );

  final double barWidth = 14;

  List<BarChartGroupData> getBarGroups() => [
        BarChartGroupData(
          x: 0,
          barRods: [
            BarChartRodData(
              width: barWidth,
              toY: widget.weekAttendance[0].toDouble(),
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(
              width: barWidth,
              toY: widget.weekAttendance[1].toDouble(),
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 2,
          barRods: [
            BarChartRodData(
              width: barWidth,
              toY: widget.weekAttendance[2].toDouble(),
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 3,
          barRods: [
            BarChartRodData(
              width: barWidth,
              toY: widget.weekAttendance[3].toDouble(),
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 4,
          barRods: [
            BarChartRodData(
              width: barWidth,
              toY: widget.weekAttendance[4].toDouble(),
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 5,
          barRods: [
            BarChartRodData(
              width: barWidth,
              toY: widget.weekAttendance[5].toDouble(),
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        // BarChartGroupData(
        //   x: 6,
        //   barRods: [
        //     BarChartRodData(
        //       width: barWidth,
        //       toY: widget.weekAttendance[6].toDouble(),
        //       gradient: _barsGradient,
        //     )
        //   ],
        //   showingTooltipIndicators: [0],
        // ),
      ];
}
