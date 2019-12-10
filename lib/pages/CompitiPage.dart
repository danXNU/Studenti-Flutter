import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../views/video_cell.dart';
import '../pages/DetailPage.dart';

class CompitiPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new CompitiState();
  }
}

class CompitiState extends State<CompitiPage> with AutomaticKeepAliveClientMixin<CompitiPage> {
  var _isLoading = true;
  var tasks;

  @override
  bool get wantKeepAlive => true;

  _fetchData() async {
    print("Attempting to fetch data from network");

    final url = "http://64.52.84.80/Studenti-Server/get_tasks.php?task_type=2";
    final response = await http.get(url);

    print(url);

    if (response.statusCode == 200) {
      // print(response.body);
      print(json.decode(response.body));
      final tasksJson = json.decode(response.body);

      if (mounted) {
        setState(() {
          _isLoading = false;
          this.tasks = tasksJson;
        });
      }
      
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