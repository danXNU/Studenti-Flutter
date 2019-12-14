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
        body: new Container(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(
                "${task.titolo}",
                style: new TextStyle(color: Colors.red, fontSize: 24),
              ),
              new Padding(
                padding: EdgeInsets.only(top: 10),
                child: new Row(
                  children: <Widget>[
                    new Text(
                      "Data: ${task.dateStringValue}",
                      style: new TextStyle(fontSize: 20),
                    ),
                    new Spacer(),
                    new Text(
                      "${task.materiaString}",
                      style: new TextStyle(fontSize: 20, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              new Divider(),
              new Padding(
                padding: EdgeInsets.only(top: 10),
                child: new Text(
                  "Argomenti: ${task.argomento}",
                  style: new TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
          padding: EdgeInsets.all(10),
        ));
  }
}
