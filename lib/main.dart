import 'package:flutter/material.dart';
import 'pages/VerifichePage.dart';
import 'pages/CompitiPage.dart';
import 'pages/OrarioPage.dart';


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
    new OrarioPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(brightness: Brightness.light),
      darkTheme: ThemeData(brightness: Brightness.dark),
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
