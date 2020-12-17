import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:reciclame/services/historyService.dart';

class HistoryDataView extends StatefulWidget {
  @override
  _HistoryDataViewState createState() => _HistoryDataViewState();
}

class _HistoryDataViewState extends State<HistoryDataView> {
  int touchedIndex;
  List history = new List();

  @override
  void initState() {
    super.initState();
    HistoryService.instance.getHistory().then((value) {
      setState(() {
        history = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: FirebaseAuth.instance.currentUser!=null?Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _getPieChart(history),
          (history.length != 0)
              ? Expanded(
                  child: ListView.separated(
                  itemCount: history.length,
                  itemBuilder: (BuildContext context, int index) {
                    print(history[index]);
                    return Indicator(
                      color: HexColor(history[index]["color"]),
                      text: history[index]["name"] +
                          " - " +
                          history[index]["quantity"].toString() +
                          " item/s",
                      isSquare: true,
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(height: 10),
                ))
              : CircularProgressIndicator()
        ],
      ):Text("Log in required to recovery statistics."),
    );
  }

  AspectRatio _getPieChart(history) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Card(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            const SizedBox(
              height: 40,
            ),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: history.length != 0
                    ? PieChart(
                        PieChartData(
                            pieTouchData:
                                PieTouchData(touchCallback: (pieTouchResponse) {
                              setState(() {
                                if (pieTouchResponse.touchInput
                                        is FlLongPressEnd ||
                                    pieTouchResponse.touchInput is FlPanEnd) {
                                  touchedIndex = -1;
                                } else {
                                  touchedIndex =
                                      pieTouchResponse.touchedSectionIndex;
                                }
                              });
                            }),
                            borderData: FlBorderData(
                              show: false,
                            ),
                            sectionsSpace: 0,
                            centerSpaceRadius: 40,
                            sections: showingSections(history, touchedIndex)),
                      )
                    : CircularProgressIndicator(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<PieChartSectionData> showingSections(history, int touchedIndex) {
  List<PieChartSectionData> sections = new List<PieChartSectionData>();

  for (var value in history) {
    final isTouched = history.indexOf(value) == touchedIndex;
    final double fontSize = isTouched ? 25 : 16;
    final double radius = isTouched ? 60 : 50;
    sections.add(PieChartSectionData(
      color: HexColor(value["color"]),
      value: value["quantity"].toDouble(),
      title: (100 * value["quantity"] / value["total"]).toString() + "%",
      radius: radius,
      titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: const Color(0xffffffff)),
    ));
  }

  return sections;
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
    this.size = 32,
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
          width: 10,
        ),
        Text(
          text,
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: textColor),
        )
      ],
    );
  }
}
