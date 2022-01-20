import 'package:demo/pages/bloc/ui/global/theme/app_themes.dart';
import 'package:demo/pages/bloc/ui/global/theme/bloc/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PreferencePage extends StatelessWidget {
  const PreferencePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preferences'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: AppTheme.values.length,
        itemBuilder: (context, index) {
          final itemAppTheme = AppTheme.values[index];
          return Card(
            color: appThemeData[itemAppTheme]?.primaryColor,
            child: ListTile(
              title: Text(
                itemAppTheme.toString(),
                style: appThemeData[itemAppTheme]?.textTheme.bodyText2,
              ),
              onTap: () {
                context.read<ThemeBloc>().add(
                      ThemeChanged(theme: itemAppTheme),
                    );
              },
            ),
          );
        },
      ),
    );
  }
}
