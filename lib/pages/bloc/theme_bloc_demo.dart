import 'package:demo/pages/bloc/ui/global/theme/bloc/theme_bloc.dart';
import 'package:demo/pages/bloc/ui/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeBlocDemo extends StatefulWidget {
  const ThemeBlocDemo({Key? key}) : super(key: key);

  @override
  _ThemeBlocDemoState createState() => _ThemeBlocDemoState();
}

class _ThemeBlocDemoState extends State<ThemeBlocDemo> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeBloc>(
      create: (_) => ThemeBloc(),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return _buildWithTheme(context, state);
        },
      ),
    );
  }

  Widget _buildWithTheme(BuildContext context, ThemeState state) {
    return MaterialApp(
      theme: state.themeData,
      home: const HomePage(),
    );
  }
}
