import 'package:demo/model/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';

class CanvasDemoPage extends StatefulWidget {
  static const rName = "demo_page";

  CanvasDemoPage();

  @override
  _CanvasDemoPageState createState() => _CanvasDemoPageState();
}

class _CanvasDemoPageState extends State<CanvasDemoPage> {
  bool _isShowCode = false;

  @override
  Widget build(BuildContext context) {
    PageModel pageModel = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: pageModel.title != "Basic" ? AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.code),
            onPressed: () {
              setState(() {
                _isShowCode = !_isShowCode;
              });
            },
          )
        ],
      ) : null,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (_, constraints) {
            return ListView(
              shrinkWrap: false,
              children: [
                if (_isShowCode)
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: constraints.maxHeight,
                    ),
                    child: SyntaxView(
                      code: pageModel.code,
                      syntax: Syntax.DART,
                      syntaxTheme: SyntaxTheme.dracula(),
                      withZoom: false,
                      withLinesCount: true,
                    ),
                  ),
                ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                      maxHeight: constraints.maxHeight,
                    ),
                    child: pageModel.page),
              ],
            );
          },
        ),
      ),
    );
  }
}
