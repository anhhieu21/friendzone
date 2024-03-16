import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/src/presentation/state.dart';
import 'package:ionicons/ionicons.dart';
import 'package:flutter/material.dart';

enum SocialLoginMethod { google, facebook, apple }

const listIcon = [
  Icon(
    Ionicons.logo_google,
    size: 40,
  ),
  Icon(
    Ionicons.logo_facebook,
    color: Colors.blue,
    size: 40,
  ),
  Icon(
    Ionicons.logo_apple,
    size: 40,
  )
];

class SocialButtons extends StatelessWidget {
  const SocialButtons({super.key});

  _handleItem(SocialLoginMethod socialLoginMethod, BuildContext context) async {
    BlocProvider.of<AuthBloc>(context)
        .add(SignInEvent('', '', socialLoginMethod: socialLoginMethod));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(SocialLoginMethod.values.length, (index) {
        return SizedBox(
            child: IconButton(
          onPressed: () =>
              _handleItem(SocialLoginMethod.values[index], context),
          icon: listIcon[index],
        ));
      }),
    );
  }
}
