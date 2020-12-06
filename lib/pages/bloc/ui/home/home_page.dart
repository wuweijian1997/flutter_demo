import 'package:demo/pages/bloc/ui/preference/preference_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => PreferencePage()),
                );
              }),
        ],
      ),
      body: Center(
        child: Text('Home', style: TextStyle(fontSize: 50),),
      ),
    );
  }
}
