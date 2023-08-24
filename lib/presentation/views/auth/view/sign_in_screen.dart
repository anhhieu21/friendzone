import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/common/constants/constants.dart';
import 'package:friendzone/presentation/shared.dart';
import 'package:friendzone/presentation/routes/path.dart';
import 'package:friendzone/presentation/state.dart';
import 'package:friendzone/presentation/view.dart';
import 'package:go_router/go_router.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final _keyForm = GlobalKey<FormState>();
  _signIn(BuildContext context) {
    if (_keyForm.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(
          SignInEvent(nameController.text.trim(), passController.text.trim()));
    }
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
                        controller: nameController,
                        label: 'Tên đăng nhập',
                        hint: 'email',
                        error: 'Vui lòng nhập email',
                      ),
                      CustomTextField(
                        controller: passController,
                        label: 'Mật khẩu',
                        hint: '6 kí tự trở lên',
                        error: 'Vui lòng nhập mật khẩu',
                      ),
                      Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: () {},
                              child: const Text('Quên mật khẩu'))),
                      const SizedBox(height: 10),
                      SiginButton(
                        onPress: () => _signIn(context),
                        label: 'Đăng nhập',
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 40),
                        child: Text('Hoặc đăng nhập với'),
                      ),
                      const SocialButtons(),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Bạn chưa có tài khoản?'),
                          TextButton(
                              onPressed: () =>
                                  GoRouter.of(context).go(RoutePath.signup),
                              child: const Text('Đăng ký ngay'))
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
