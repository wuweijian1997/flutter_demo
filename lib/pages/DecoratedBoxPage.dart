import 'package:flutter/material.dart';

class DecoratedBoxPage extends StatelessWidget {
  static const rName = 'DecoratedBoxPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DecoratedBoxPage'),
      ),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Center(
          child: Container(
            width: 100,
            height: 50,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.red[900], Colors.orange[700]],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(3.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54,
                    offset: Offset(3.0, 3.0),
                    blurRadius: 4.0,
                  )
                ],
              ),
              child: Center(
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
