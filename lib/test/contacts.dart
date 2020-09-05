import 'package:flutter/material.dart';

class Contacts extends StatelessWidget {
  final List<String> _names;

  Contacts(this._names);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListView(
          children: _names.map((e) {
            return ListTile(
              leading: Icon(Icons.person),
              title: Text(e),
            );
          }).toList(),
        ),
      ),
    );
  }
}
