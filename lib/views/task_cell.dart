import 'package:flutter/material.dart';
import '../objects.dart';

class TaskCell extends StatelessWidget {
  final TaskObject task;

  TaskCell(this.task);

  Color getAppropriateBackroundColor() {
    if (task.isToday()) {
      return Colors.red;
    } else if (task.isTomorrow()) {
      return Colors.yellow;
    } else {
      return Colors.white10;
    }
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = getAppropriateBackroundColor();

    return new Container(
      color: backgroundColor,
      child: new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Row(
          children: <Widget>[
            new Text("${task.materiaString}"),
            new Spacer(),
            new Text("${task.dateStringValue}")
          ],
        ),
        new SizedBox(height: 15),
        new Row(
          children: <Widget>[
            new Text(
              "${task.titolo}",
              style: new TextStyle(color: Colors.grey),
              )
          ],
        ),
        new Divider()
      ],
    ),
    padding: new EdgeInsets.all(5),
    );
  }
}
