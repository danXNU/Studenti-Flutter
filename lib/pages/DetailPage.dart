import 'package:flutter/material.dart';
import '../objects.dart';

class DetailPage extends StatelessWidget {
  TaskObject task;

  DetailPage(this.task);

  @override
    Widget build(BuildContext context) {
      return new Scaffold(
        appBar: new AppBar(
          title: new Text("${task.materiaString}"),
        ),
        body: new Column(
          children: <Widget>[
            new Text("${task.titolo}"),
          ],
        )
      );
    }
}