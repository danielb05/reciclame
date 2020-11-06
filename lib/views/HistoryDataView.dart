import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:reciclame/localization/language_constants.dart';


class HistoryDataView extends StatefulWidget {
  @override
  _HistoryDataViewState createState() => _HistoryDataViewState();
}

class _HistoryDataViewState extends State<HistoryDataView> {
  int touchedIndex;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          _getPieChart(),
            SizedBox(height: 10),
            _getLinealChart()
          ],
        ),
    );
  }

  AspectRatio _getPieChart() {

    String paper = getTranslated(context, 'paper');
    return AspectRatio(
        aspectRatio: 1.3,
        child: Card(
          color: Colors.white,
          child: Row(
            children: <Widget>[
              const SizedBox(
                height: 18,
              ),
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: PieChart(
                    PieChartData(
                        pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
                          setState(() {
                            if (pieTouchResponse.touchInput is FlLongPressEnd ||
                                pieTouchResponse.touchInput is FlPanEnd) {
                              touchedIndex = -1;
                            } else {
                              touchedIndex = pieTouchResponse.touchedSectionIndex;
                            }
                          });
                        }),
                        borderData: FlBorderData(
                          show: false,
                        ),
                        sectionsSpace: 0,
                        centerSpaceRadius: 40,
                        sections: showingSections(touchedIndex)),
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Indicator(
                    color: Color(0xff0293ee),
                    text: 'paper',
                    isSquare: true,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Indicator(
                    color: Colors.brown,
                    text: 'organic',
                    isSquare: true,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Indicator(
                    color: Color(0xFFFDD835),
                    text: 'plastic',
                    isSquare: true,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Indicator(
                    color: Color(0xff13d38e),
                    text: 'glass',
                    isSquare: true,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Indicator(
                    color: Colors.grey,
                    text: 'non-recyclable',
                    isSquare: true,
                  ),
                  SizedBox(
                    height: 18,
                  ),
                ],
              ),
              const SizedBox(
                width: 28,
              ),
            ],
          ),
        ),
      );
  }

  AspectRatio _getLinealChart() {
    return AspectRatio(
            aspectRatio: 1.23,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(18)),
                gradient: LinearGradient(
                  colors: [
                    Color(0xff2c274c),
                    Color(0xff46426c),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              child: Stack(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const SizedBox(
                        height: 15,
                      ),
                      Text(getTranslated(context, 'history'),
                        style: TextStyle(
                          color: Color(0xff827daa),
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        getTranslated(context, 'monthly_recycling'),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16.0, left: 6.0),
                          child: LineChart(
                            sampleData(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
  }
}

LineChartData sampleData() {
  return LineChartData(
    lineTouchData: LineTouchData(
      touchTooltipData: LineTouchTooltipData(
        tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
      ),
      touchCallback: (LineTouchResponse touchResponse) {},
      handleBuiltInTouches: true,
    ),
    gridData: FlGridData(
      show: false,
    ),
    titlesData: FlTitlesData(
      bottomTitles: SideTitles(
        showTitles: true,
        reservedSize: 22,
        getTextStyles: (value) => const TextStyle(
          color: Color(0xff72719b),
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        margin: 10,
        getTitles: (value) {
          switch (value.toInt()) {
            case 2:
              return 'SEPT';
            case 7:
              return 'OCT';
            case 12:
              return 'DEC';
          }
          return '';
        },
      ),
      leftTitles: SideTitles(
        showTitles: true,
        getTextStyles: (value) => const TextStyle(
          color: Color(0xff75729e),
          fontWeight: FontWeight.bold,
          fontSize: 10,
        ),
        getTitles: (value) {
          switch (value.toInt()) {
            case 1:
              return '2 Kg';
            case 2:
              return '5 Kg';
            case 3:
              return '8 Kg';
            case 4:
              return '10 Kg';
            case 5:
              return '15 Kg';
          }
          return '';
        },
        margin: 8,
        reservedSize: 30,
      ),
    ),
    borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(
            color: Color(0xff4e4965),
            width: 4,
          ),
          left: BorderSide(
            color: Colors.transparent,
          ),
          right: BorderSide(
            color: Colors.transparent,
          ),
          top: BorderSide(
            color: Colors.transparent,
          ),
        )),
    minX: 0,
    maxX: 14,
    maxY: 6,
    minY: 0,
    lineBarsData: linesBarData1(),
  );
}

List<LineChartBarData> linesBarData1() {
  final LineChartBarData green = LineChartBarData(
    spots: [
      FlSpot(1, 0.5),
      FlSpot(3, 1),
      FlSpot(5, 1.5),
      FlSpot(7, 1.9),
      FlSpot(10, 2.3),
      FlSpot(12, 2.5),
      FlSpot(13, 2.6),
    ],
    isCurved: true,
    colors: [
      const Color(0xff4af699),
    ],
    barWidth: 3,
    isStrokeCapRound: true,
    dotData: FlDotData(
      show: false,
    ),
    belowBarData: BarAreaData(
      show: false,
    ),
  );
  final LineChartBarData brown = LineChartBarData(
    spots: [
      FlSpot(1, 1),
      FlSpot(3, 1.2),
      FlSpot(5, 1.7),
      FlSpot(7, 1.9),
      FlSpot(10, 2.5),
      FlSpot(12, 3.6),
      FlSpot(13, 4),
    ],
    isCurved: true,
    colors: [Colors.brown],
    barWidth: 3,
    isStrokeCapRound: true,
    dotData: FlDotData(
      show: false,
    ),
    belowBarData: BarAreaData(show: false, colors: [
      const Color(0x00aa4cfc),
    ]),
  );
  final LineChartBarData blue = LineChartBarData(
    spots: [
      FlSpot(1, 0.1),
      FlSpot(3, 0.2),
      FlSpot(6, 0.3),
      FlSpot(10, 0.5),
      FlSpot(13, 0.8),
    ],
    isCurved: true,
    colors: const [
      Color(0xff27b6fc),
    ],
    barWidth: 3,
    isStrokeCapRound: true,
    dotData: FlDotData(
      show: false,
    ),
    belowBarData: BarAreaData(
      show: false,
    ),
  );
  final LineChartBarData yellow = LineChartBarData(
    spots: [
      FlSpot(1, 1),
      FlSpot(3, 1.6),
      FlSpot(6, 2.5),
      FlSpot(10, 3),
      FlSpot(13, 5),
    ],
    isCurved: true,
    colors: const [
      Color(0xFFFDD835)
    ],
    barWidth: 3,
    isStrokeCapRound: true,
    dotData: FlDotData(
      show: false,
    ),
    belowBarData: BarAreaData(
      show: false,
    ),
  );
  final LineChartBarData non_recyclable = LineChartBarData(
    spots: [
      FlSpot(1, 0.2),
      FlSpot(3, 0.5),
      FlSpot(6, 0.7),
      FlSpot(10, 0.8),
      FlSpot(13, 1),
    ],
    isCurved: true,
    colors: const [
      Colors.grey
    ],
    barWidth: 3,
    isStrokeCapRound: true,
    dotData: FlDotData(
      show: false,
    ),
    belowBarData: BarAreaData(
      show: false,
    ),
  );
  return [
    green,
    brown,
    blue,
    yellow,
    non_recyclable
  ];
}

List<PieChartSectionData> showingSections(int touchedIndex) {
  return List.generate(5, (i) {
    final isTouched = i == touchedIndex;
    final double fontSize = isTouched ? 25 : 16;
    final double radius = isTouched ? 60 : 50;
    switch (i) {
      case 0:
        return PieChartSectionData(
          color: const Color(0xff0293ee),
          value: 6,
          title: '6%',
          radius: radius,
          titleStyle: TextStyle(
              fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
        );
      case 1:
        return PieChartSectionData(
          color: Color(0xFFFDD835),
          value: 41,
          title: '41%',
          radius: radius,
          titleStyle: TextStyle(
              fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
        );
      case 2:
        return PieChartSectionData(
          color: Colors.brown,
          value: 25,
          title: '25%',
          radius: radius,
          titleStyle: TextStyle(
              fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
        );
      case 3:
        return PieChartSectionData(
          color: const Color(0xff13d38e),
          value: 12,
          title: '12%',
          radius: radius,
          titleStyle: TextStyle(
              fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
        );
      case 4:
        return PieChartSectionData(
          color: Colors.grey,
          value: 16,
          title: '16%',
          radius: radius,
          titleStyle: TextStyle(
              fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
        );
      default:
        return null;
    }
  });
}
class Indicator extends StatelessWidget {
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color textColor;

  const Indicator({
    Key key,
    this.color,
    this.text,
    this.isSquare,
    this.size = 16,
    this.textColor = const Color(0xff505050),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          getTranslated(context, text),
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: textColor),
        )
      ],
    );
  }
}