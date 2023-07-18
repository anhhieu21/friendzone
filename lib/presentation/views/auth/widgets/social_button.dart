import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/common/extentions/size_extention.dart';
import 'package:friendzone/presentation/themes/color.dart';
import 'package:friendzone/state.dart';
import 'package:ionicons/ionicons.dart';
import 'package:flutter/material.dart';

enum SocialLoginMethod { google, facebook, apple }

const listIcon = [
  Icon(
    Ionicons.logo_google,
    color: colorPinkButton,
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
    final size = SizeEx(context).screenSize;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(SocialLoginMethod.values.length, (index) {
        return SizedBox(
            width: size.width / 4,
            height: size.width / 5,
            child: IconButton(
              onPressed: () =>
                  _handleItem(SocialLoginMethod.values[index], context),
              icon: listIcon[index],
              style: IconButton.styleFrom(
                  shape: RoundedRectangleBorder(
                side: const BorderSide(color: colorWhite, width: 4),
                borderRadius: BorderRadius.circular(12),
              )),
            ));
      }),
    );
  }
}
