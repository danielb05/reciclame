import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:reciclame/localization/language_constants.dart';
import 'package:reciclame/services/historyService.dart';
import 'dart:math';



String generateRandomHexColor() {
  Random random = new Random();
  int length = 6;
  String chars = '0123456789ABCDEF';
  String hex = '#';
  while (length-- > 0) hex += chars[(random.nextInt(16)) | 0];
  return hex;
}

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
    HistoryService.instance.getHistory().then((value){
      setState(() {
        history = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _getPieChart(history)
        ],
      ),
    );
  }

  AspectRatio _getPieChart(history) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Card(
        color: Colors.white,
        child:
        Row(
          children: <Widget>[
            const SizedBox(
              height: 18,
            ),
              Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child:
                history.length!=0?
                PieChart(
                  PieChartData(
                      pieTouchData:
                          PieTouchData(touchCallback: (pieTouchResponse) {
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
                      sections: showingSections(history,touchedIndex)),
                ):CircularProgressIndicator(),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Indicator(
                  color: Color(0xff0293ee),
                  text: 'paper',
                  isSquare: true,
                ),
                SizedBox(
                  height: 4,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

List<PieChartSectionData> showingSections(history,int touchedIndex) {


  List<PieChartSectionData> sections = new List<PieChartSectionData>();

  for(var value in history){
    final isTouched = history.indexOf(value) == touchedIndex;
    final double fontSize = isTouched ? 25 : 16;
    final double radius = isTouched ? 60 : 50;
      sections.add(
          PieChartSectionData(
            color: HexColor(generateRandomHexColor()),
            value: value["quantity"].toDouble(),
            title: (100*value["quantity"]/value["total"]).toString()+"%",
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          )
      );
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
          style: TextStyle(
              fontSize: 12, fontWeight: FontWeight.bold, color: textColor),
        )
      ],
    );
  }
}
