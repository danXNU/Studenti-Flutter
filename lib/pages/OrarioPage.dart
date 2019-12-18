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
        imageProvider: NetworkImage("https://danitoxserver.ddns.net/Studenti-Server/orario/orario.jpg"),
      )
      
    );
  }
}