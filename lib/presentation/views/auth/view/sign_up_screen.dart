import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/presentation/routes/path.dart';
import 'package:friendzone/presentation/shared.dart';
import 'package:friendzone/presentation/themes/color.dart';
import 'package:friendzone/state/auth/auth_bloc.dart';
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
      TextEditingController(text: 'nhuanhhieu21@gmail.com');

  final TextEditingController passController =
      TextEditingController(text: '1908Hieu');

  final TextEditingController passConfirmController =
      TextEditingController(text: '1908Hieu');

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
                        label: 'Email',
                        hint: 'email',
                        error: 'Vui lòng nhập email',
                      ),
                      CustomTextField(
                          controller: passController,
                          label: 'Mật khẩu',
                          hint: '6 kí tự trở lên',
                          error: 'Vui lòng nhập mật khẩu'),
                      CustomTextField(
                          controller: passConfirmController,
                          label: 'Xác nhận mật khẩu',
                          hint: '6 kí tự trở lên',
                          error: 'Vui lòng nhập mật khẩu'),
                      const Spacer(),
                      Expanded(
                        child: SiginButton(
                          onPress: _signUp,
                          label: 'Đăng ký',
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
