import 'package:demo/pages/bloc/ui/preference/preference_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const PreferencePage()),
                );
              }),
        ],
      ),
      body: const Center(
        child: Text('Home', style: TextStyle(fontSize: 50),),
      ),
    );
  }
}
