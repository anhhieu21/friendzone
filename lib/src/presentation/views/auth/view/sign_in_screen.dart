import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/src/config.dart';
import 'package:friendzone/src/presentation/shared.dart';
import 'package:friendzone/src/presentation/state.dart';
import 'package:friendzone/src/presentation/view.dart';
import 'package:friendzone/src/presentation/views/auth/widgets/password_field.dart';
import 'package:friendzone/src/utils.dart';
import 'package:go_router/go_router.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final _keyForm = GlobalKey<FormState>();
  _signIn(BuildContext context) {
    if (!_keyForm.currentState!.validate()) {
      return;
    }
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final username = nameController.text.trim();
    final password = passController.text.trim();
    authBloc.add(SignInEvent(username, password));
  }

  _checkVerify(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user!.emailVerified) {
      BlocProvider.of<MyAccountCubit>(context).myAccountInfo(user.uid);
      GoRouter.of(context).go(RoutePath.main);
    } else {
      DialogCustom.instance.showLoading(context, false);
      DialogCustom.instance.showDialogCustom(context, 'Chưa xác thực email',
          'Vui lòng kiểm tra email và xác thực để tiếp tục !', '', null, null);
    }
  }

  _authErro(BuildContext context) {
    DialogCustom.instance.showLoading(context, false);
    DialogCustom.instance.showDialogCustom(
        context,
        loginFailMsg,
        'Vui lòng kiểm tra lại email và mật khẩu !',
        'Thử lại',
        null,
        () => Navigator.pop(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
          child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is Loading) {
                DialogCustom.instance.showLoading(context, true);
              }

              if (state is Authenticated) _checkVerify(context);
              if (state is AuthError) _authErro(context);
            },
            child: StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                final user = snapshot.hasData ? snapshot.data : null;
                nameController.text = user?.email ?? '';
                return Form(
                  key: _keyForm,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const TitleSignIn(),
                      CustomTextField(
                        keyboardType: TextInputType.emailAddress,
                        controller: nameController,
                        label: text.email,
                        hint: text.email.toLowerCase(),
                        error: text.errorEmailField,
                      ),
                      PasswordField(
                        controller: passController,
                        label: text.password,
                        hint: text.hintPassword,
                        error: text.errorPassField,
                      ),
                      Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: () {},
                              child: Text(text.forGetPassword))),
                      const SizedBox(height: 10),
                      SiginButton(
                        onPress: () => _signIn(context),
                        label: text.login,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40),
                        child: Text(text.loginWith),
                      ),
                      const SocialButtons(),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(text.haveNotAccount),
                          TextButton(
                              onPressed: () =>
                                  GoRouter.of(context).go(RoutePath.signup),
                              child: Text(text.register))
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      )),
    );
  }
}
