part of 'language_cubit.dart';

class LanguageState extends Equatable {
  const LanguageState();

  @override
  List<Object> get props => [];
}

class LanguageInitial extends LanguageState {}

class ChangeLanguage extends LanguageState {
  final Locale locale;

  const ChangeLanguage({required this.locale});
  @override
  List<Object> get props => [locale];
}
