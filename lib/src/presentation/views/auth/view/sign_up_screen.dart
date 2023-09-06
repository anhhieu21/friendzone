import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:friendzone/src/config.dart';
import 'package:friendzone/src/presentation/shared.dart';
import 'package:friendzone/src/presentation/state.dart';
import 'package:friendzone/src/presentation/views/auth/widgets/password_field.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';

import '../widgets/button_sigin.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController nameController =
      TextEditingController(text: 'xxxx@gmail.com');

  final TextEditingController passController = TextEditingController(text: 'x');

  final TextEditingController passConfirmController =
      TextEditingController(text: 'x');

  final _keyForm = GlobalKey<FormState>();

  _signUp() {
    if (_keyForm.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context)
          .add(SignUpReq(nameController.text, passController.text));
    }
  }

  dialogSuccess() {
    DialogCustom.instance.showLoading(context, false);
    DialogCustom.instance.showDialogCustom(
      context,
      'Đăng ký thành công',
      'Chúng tôi đã gửi một email xác minh tới cho bạn, vui lòng kiểm tra email !',
      'Đăng nhập',
      () {},
      () => context.go(RoutePath.signin),
    );
  }

  dialogFailed(BuildContext ctx) {
    DialogCustom.instance.showLoading(context, false);
    DialogCustom.instance.showDialogCustom(
      context,
      'Đăng ký không thành công',
      'Có thể email đã được sử dụng cho tài khoản khác, vui lòng thử lại!',
      'Thử lại',
      null,
      () => Navigator.pop(ctx),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
          child: BlocListener<AuthBloc, AuthState>(
              listener: (ctx, state) {
                if (state is Loading) {
                  DialogCustom.instance.showLoading(context, true);
                }
                if (state is SignUpSuccess) dialogSuccess();
                if (state is AuthError) dialogFailed(ctx);
              },
              child: Form(
                key: _keyForm,
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          onPressed: () => context.go(RoutePath.signin),
                          alignment: Alignment.center,
                          style:
                              IconButton.styleFrom(backgroundColor: colorGrey),
                          icon: const Icon(Ionicons.chevron_back),
                        ),
                      ),
                      CustomTextField(
                        controller: nameController,
                        label: text.email,
                        hint: text.email.toLowerCase(),
                        error: text.errorEmailField,
                      ),
                      PasswordField(
                          controller: passController,
                          label: text.password,
                          hint: text.hintPassword,
                          error: text.errorPassField),
                      PasswordField(
                          controller: passConfirmController,
                          label: text.confirmPass,
                          hint: text.hintPassword,
                          error: text.errorPassField),
                      const Spacer(),
                      Expanded(
                        child: SiginButton(
                          onPress: _signUp,
                          label: text.register,
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              )),
        ),
      )),
    );
  }
}
