import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import './views/video_cell.dart';

void main() => runApp(new RealWorldApp());

class RealWorldApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new RealWorldState();
  }
}

class RealWorldState extends State<RealWorldApp> {
  var _isLoading = true;

  var tasks;

  _fetchData() async {
    print("Attempting to fetch data from network");

    final url = "http://64.52.84.80/Studenti-Server/get_tasks.php?task_type=1";
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // print(response.body);

      final tasksJson = json.decode(response.body);

      setState(() {
        _isLoading = false;
        this.tasks = tasksJson;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("Studenti"),
          actions: <Widget>[
            new IconButton(
              icon: new Icon(Icons.refresh),
              onPressed: () {
                print("Reloading...");
                setState(() {
                  _isLoading = true;
                });
                _fetchData();
              },
            )
          ],
        ),
        body: new Center(
          child: _isLoading
              ? new CircularProgressIndicator()
              : new ListView.builder(
                  itemCount: this.tasks != null ? this.tasks.length : 0,
                  itemBuilder: (context, i) {
                    final task = this.tasks[i];
                    return new FlatButton(
                      padding: new EdgeInsets.all(0.0),
                      child: new TaskCell(task),
                      onPressed: () {
                        print("Task cell tapped: $i");
                        Navigator.push(context, 
                          new MaterialPageRoute(
                            builder: (context) => new DetailPage()
                          )
                        );
                      },
                    );
                  },
                ),
        ),
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
      return new Scaffold(
        appBar: new AppBar(
          title: new Text("Detail page"),
        ),
        body: new Center(
          child: new Text("Detail detail detail"),
        ),
      );
    }
}