import 'package:flutter/material.dart';
import '../objects.dart';

class TaskCell extends StatelessWidget {
  final TaskObject task;

  TaskCell(this.task);

  @override
  Widget build(BuildContext context) {
    return new Container(
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
