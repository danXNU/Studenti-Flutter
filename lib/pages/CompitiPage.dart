import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../views/task_cell.dart';
import '../pages/DetailPage.dart';
import '../objects.dart';

class CompitiPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new CompitiState();
  }
}

class CompitiState extends State<CompitiPage> with AutomaticKeepAliveClientMixin<CompitiPage> {
  var _isLoading = true;
  var errorReported = false;
  List<TaskObject> tasks = List<TaskObject>();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  bool showAllVerifiche = false;

  @override
  Widget build(BuildContext context) {
    final timedTasks = newTasks(showAllVerifiche);

    return new Scaffold(
      persistentFooterButtons: <Widget>[
        new Text(
          "Mostra anche i compiti vecchi",
          textAlign: TextAlign.left,
        ),
        new Switch(
          value: showAllVerifiche,
          onChanged: (newValue) {
            setState(() {
              showAllVerifiche = newValue;
            });
          },
        ),
      ],
      appBar: AppBar(
        title: Text("Compiti"),
        actions: [
          new IconButton(
            icon: new Icon(Icons.refresh),
            onPressed: () {
              _fetchData();
            },
          )
        ],
      ),
      body: new Center(child: getSituationalView(timedTasks)),
    );
  }

List<TaskObject> newTasks(bool showAll) {
    final DateTime now = DateTime.now();
    final DateTime lastMidnight = DateTime(now.year, now.month, now.day);

    final tasksToReturn = showAll
        ? tasks
        : tasks.where((task) => task.date.isAfter(lastMidnight)).toList();

      tasksToReturn.sort((a, b) { return a.date.compareTo(b.date); });
      return tasksToReturn;
  }

  Widget getSituationalView(List<TaskObject> tasks) {
    if (errorReported) {
      return new Center(
        child: new Text("C'è stato un errore. Riprova più tardi"),
      );
    } else if (_isLoading) {
      return new CircularProgressIndicator();
    } else if (tasks.isEmpty) {
      return Center(
        child: new Text("Non ci sono compiti in programma."),
      );
    } else {
      return new ListView.builder(
        itemCount: tasks != null ? tasks.length : 0,
        itemBuilder: (context, i) {
          final task = tasks[i];
          return new FlatButton(
            padding: new EdgeInsets.all(0.0),
            child: new TaskCell(task),
            onPressed: () {
              print("Task cell tapped: $i");
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new DetailPage(task)));
            },
          );
        },
      );
    }
  }

  _fetchData() async {
    setState(() {
      _isLoading = true;
    });
    final url = "http://64.52.84.80/Studenti-Server/get_tasks.php?task_type=2";

    try {
      final response = await http.get(url);

      print(url);

      if (response.statusCode == 200) {
        final tasksJson = json.decode(response.body);
        var convertedTasks = new List<TaskObject>();

        tasksJson.forEach((taskDict) {
          final task = new TaskObject(taskDict["id"], taskDict["titolo"],
              taskDict["materia"], taskDict["argomento"], taskDict["date"]);
          convertedTasks.add(task);
        });

        if (mounted) {
          setState(() {
            _isLoading = false;
            this.tasks = convertedTasks;
            this.errorReported = false;
          });
        }
      }
    } catch (e) {
      print(e);
      setState(() {
        this.errorReported = true;
      });
    }
  }
}