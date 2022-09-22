import 'package:flutter/material.dart';
import 'package:friendzone/presentation/views/signin/view/widgets/button_sigin.dart';
import 'package:go_router/go_router.dart';
import 'package:friendzone/presentation/views/signin/view/widgets/social_button.dart';
import 'package:friendzone/presentation/views/signin/view/widgets/title_signin.dart';
import 'package:friendzone/presentation/views/widgets/custom_textfield.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const TitleSignIn(),
              CustomTextField(
                  controller: nameController,
                  label: 'Tên đăng nhập',
                  hint: 'tên hoặc số điện thoại'),
              CustomTextField(
                  controller: passController,
                  label: 'Mật khẩu',
                  hint: '6 kí tự trở lên'),
              Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () {}, child: const Text('Quên mật khẩu'))),
              const SizedBox(height: 10),
              const SiginButton(),
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
                      onPressed: () {}, child: const Text('Đăng ký ngay'))
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
