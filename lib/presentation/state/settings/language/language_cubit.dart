import 'dart:ui';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';
import 'package:friendzone/common/constants/constants.dart';
import 'package:friendzone/presentation/utils/formatter.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'language_state.dart';

AppLocalizations text = AppLocalizationsEn();

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(LanguageInitial()) {
    _load();
  }
  Future<void> _load() async {
    final pref = await SharedPreferences.getInstance();
    String code = pref.getString(kLanguageCode) ?? 'en';
    final locale = Locale(code);
    _setLocalizations(locale);
    emit(ChangeLanguage(locale: locale));
  }

  changeLanguage(String code) async {
    final locale = Locale(code);
    final pref = await SharedPreferences.getInstance();
    pref.setString(kLanguageCode, code);
    _setLocalizations(locale);
    emit(ChangeLanguage(locale: locale));
  }

  Future<void> _setLocalizations(Locale locale) async {
    if (AppLocalizations.delegate.isSupported(locale)) {
      text = await AppLocalizations.delegate.load(locale);
    }
    Formatter.locale = locale.languageCode == 'vi' ? 'vi_VN' : 'en_US';
  }
}
