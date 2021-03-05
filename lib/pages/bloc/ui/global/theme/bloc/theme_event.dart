part of 'theme_bloc.dart';

@immutable
abstract class ThemeEvent {
  final AppTheme theme;

  ThemeEvent({required this.theme});
}

class ThemeChanged extends ThemeEvent {
  ThemeChanged({required AppTheme theme}) : super(theme: theme);
}
