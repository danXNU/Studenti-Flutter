import 'package:flutter/material.dart';

class TaskCell extends StatelessWidget {
  final task;

  TaskCell(this.task);

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new Container(
          padding: new EdgeInsets.all(16.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Container(
                height: 8.0,
              ),
              new Text(
                task["titolo"],
                style:
                    new TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        new Divider()
      ],
    );
  }
}
