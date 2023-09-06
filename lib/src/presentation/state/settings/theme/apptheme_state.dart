// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'apptheme_cubit.dart';

class AppThemeState extends Equatable {
  const AppThemeState();

  @override
  List<Object> get props => [];
}

class AppThemeInitial extends AppThemeState {}

class LoadingTheme extends AppThemeState {}

class ChangedTheme extends AppThemeState {
  final ThemeData themeData;
  final Themes theme;

  const ChangedTheme({
    required this.themeData,
    required this.theme,
  });
  @override
  List<Object> get props => [themeData, theme];
}
