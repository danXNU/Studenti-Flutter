import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class OrarioPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Orario"),
      ),
      body: new PhotoView(
        imageProvider: NetworkImage("http://64.52.84.80/Studenti-Server/orario/orario.jpg"),
      )
      
    );
  }
}