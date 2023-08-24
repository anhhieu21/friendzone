import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/data/models/setting.dart';
import 'package:friendzone/presentation/shared.dart';
import 'package:friendzone/state/settings/theme/apptheme_cubit.dart';

class ChangeThemeScreen extends StatelessWidget {
  const ChangeThemeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme'),
      ),
      body: BlocConsumer<AppThemeCubit, AppThemeState>(
        listenWhen: (previous, current) {
          if (current is LoadingTheme) {
            return true;
          }
          return true;
        },
        listener: (_, state) {
          if (state is LoadingTheme) {
            DialogCustom.instance.showLoading(context, true);
          }
          if (state is ChangedTheme) {
            DialogCustom.instance.showLoading(context, false);
          }
        },
        builder: (context, state) {
          return Column(children: [
            ...Themes.values.map(
              (e) => RadioListTile<Themes>(
                title: Text(e.name.toUpperCase()),
                value: e,
                groupValue: state is ChangedTheme ? state.theme : Themes.light,
                onChanged: (value) {
                  context.read<AppThemeCubit>().changeTheme(e);
                },
              ),
            ),
          ]);
        },
      ),
    );
  }
}
