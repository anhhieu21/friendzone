import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:friendzone/common/constants/constants.dart';
import 'package:friendzone/data/models/setting.dart';
import 'package:friendzone/presentation/themes/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'apptheme_state.dart';

class AppThemeCubit extends Cubit<AppThemeState> {
  AppThemeCubit() : super(AppThemeInitial()) {
    _init();
  }

  _init() async {
    ThemeData? themeData;
    Themes? themes;
    var brightness =
        SchedulerBinding.instance.platformDispatcher.platformBrightness;
    final prefs = await SharedPreferences.getInstance();
    final themeFromLocal = prefs.getString(kTheme);
    if (themeFromLocal == null) {
      themeData = _setTheme(brightness.index);
      themes = Themes.system;
    } else {
      if (themeFromLocal == Themes.dark.name) {
        themeData = AppTheme.darkTheme;
        themes = Themes.dark;
      } else if (themeFromLocal == Themes.light.name) {
        themeData = AppTheme.lightTheme;
        themes = Themes.light;
      } else {
        themeData = _setTheme(brightness.index);
        themes = Themes.system;
      }
    }
    emit(ChangedTheme(themeData: themeData, theme: themes));
  }

  changeTheme(Themes theme) async {
    ThemeData? value;
    emit(LoadingTheme());
    await Future.delayed(const Duration(seconds: 1));
    final prefs = await SharedPreferences.getInstance();
    if (theme == Themes.dark) {
      value = AppTheme.darkTheme;
    } else if (theme == Themes.light) {
      value = AppTheme.lightTheme;
    } else {
      var brightness =
          SchedulerBinding.instance.platformDispatcher.platformBrightness;
      value = _setTheme(brightness.index);
    }
    await prefs.setString(kTheme, theme.name);
    emit(ChangedTheme(themeData: value, theme: theme));
  }

  ThemeData _setTheme(int index) {
    return index == AppTheme.lightTheme.brightness.index
        ? AppTheme.lightTheme
        : AppTheme.darkTheme;
  }
}
