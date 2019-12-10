import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import './views/video_cell.dart';

void main() => runApp(new MainApp());

class MainApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MainAppState();
  }
}

class MainAppState extends State<MainApp> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    new VerifichePage(1),
    new CompitiPage(),
    new Text("Bsd"),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.assessment), title: new Text("Verifiche")),
                BottomNavigationBarItem(icon: Icon(Icons.book), title: new Text("Compiti")),
                BottomNavigationBarItem(icon: Icon(Icons.access_time), title: new Text("Orario")),
              ],
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          
          body: _children[_currentIndex]
          ),
        ),
      );
    
  }
}

class VerifichePage extends StatefulWidget {
  final int taskType;

  VerifichePage(this.taskType);

  @override
  State<StatefulWidget> createState() {
    return new VerificheState();
  }
}

class VerificheState extends State<VerifichePage> {
  var _isLoading = true;
  var tasks;

  _fetchData() async {
    print("Attempting to fetch data from network");

    final url = "http://64.52.84.80/Studenti-Server/get_tasks.php?task_type=1";
    final response = await http.get(url);

    print(url);

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
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
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


class CompitiPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new CompitiState();
  }
}

class CompitiState extends State<CompitiPage> {
  var _isLoading = true;

  var tasks;

  _fetchData() async {
    print("Attempting to fetch data from network");

    final url = "http://64.52.84.80/Studenti-Server/get_tasks.php?task_type=0";
    final response = await http.get(url);

    print(url);

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
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
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
    );
    
  
  }
}