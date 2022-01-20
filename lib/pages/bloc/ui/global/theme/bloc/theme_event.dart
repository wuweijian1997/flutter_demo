part of 'theme_bloc.dart';

@immutable
abstract class ThemeEvent {
  final AppTheme theme;

  const ThemeEvent({required this.theme});
}

class ThemeChanged extends ThemeEvent {
  const ThemeChanged({required AppTheme theme}) : super(theme: theme);
}
