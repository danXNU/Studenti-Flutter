import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../objects.dart';
import '../views/task_cell.dart';
import '../pages/DetailPage.dart';

class VerifichePage extends StatefulWidget {
  final int taskType;

  VerifichePage(this.taskType);

  @override
  State<StatefulWidget> createState() {
    return new VerificheState();
  }
}

class VerificheState extends State<VerifichePage> with AutomaticKeepAliveClientMixin<VerifichePage> {
  var _isLoading = true;
  var _isError = false;
  List<TaskObject> tasks = List<TaskObject>();

  @override 
  bool get wantKeepAlive => true;

  _fetchData() async {

    final url = "http://64.52.84.80/Studenti-Server/get_tasks.php?task_type=1";

    try {
      final response = await http.get(url);

    print(url);

    if (response.statusCode == 200) {
      // print(response.body);

      final tasksJson = json.decode(response.body);

      var convertedTasks = new List<TaskObject>();
      tasksJson.forEach((taskDict) {
        final task = new TaskObject(taskDict["id"], taskDict["titolo"], taskDict["materia"], taskDict["argomento"], taskDict["date"]);
        convertedTasks.add(task);
      });

      if (mounted) {
        setState(() {
          _isLoading = false;
          this.tasks = convertedTasks;
          this._isError = false;
        });
      }
      
    }
    } catch (e) {
      print(e);
      this._isError = true;
    }
    
  }

@override
  void initState() {
    super.initState();
    _fetchData();
  }

bool showAllVerifiche = false;

List<TaskObject> newTasks(bool showAll) {
  final DateTime now = DateTime.now();
  final DateTime lastMidnight = DateTime(now.year, now.month, now.day);

  return showAll ? tasks : tasks.where((task) => task.date.isAfter(lastMidnight)).toList();
}

  @override
  Widget build(BuildContext context) {
    final  timedTasks = newTasks(showAllVerifiche);

    return new Scaffold(
      persistentFooterButtons: <Widget>[
        new Text(
          "Mostra anche le verifiche vecchie",
          textAlign: TextAlign.left,
        ),
        new Switch(
          value: showAllVerifiche,
          onChanged: (newValue) {
            setState(() {
              showAllVerifiche = newValue;
            });
          },
        )
          ],
      appBar: AppBar(
            title: Text("Verifiche"),
            actions: [
              new IconButton(
                icon: new Icon(Icons.refresh),
                onPressed: () {
                  _fetchData();
                },
              )
            ],
          ),
      body: new Center(
          child: _isLoading
              ? new CircularProgressIndicator()
              : new ListView.builder(
                  itemCount: timedTasks != null ? timedTasks.length : 0,
                  itemBuilder: (context, i) {
                    final task = timedTasks[i];
                    return new FlatButton(
                      padding: new EdgeInsets.all(0.0),
                      child: new TaskCell(task),
                      onPressed: () {
                        print("Task cell tapped: $i");
                        Navigator.push(context, 
                          new MaterialPageRoute(
                            builder: (context) => new DetailPage(task)
                          )
                        );
                      },
                    );
                  },
                  ),
        ),
    );
    
  
  }
}