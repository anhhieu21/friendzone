import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:friendzone/presentation/routes/path.dart';
import 'package:friendzone/presentation/themes/color.dart';
import 'package:friendzone/presentation/views/widgets/custom_textfield.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';

import 'view/widgets/button_sigin.dart';

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
      _signUpWithFireBase()?.then((value) {
        if (value?.email != null) {
          context.goNamed(RoutePath.signin);
        }
      });
    }
  }

  Future<User?>? _signUpWithFireBase() async {
    try {
      final res = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: nameController.text, password: passController.text);
      return res.user;
    } on Exception catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
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
                      style: IconButton.styleFrom(backgroundColor: colorGrey),
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
          ),
        ),
      )),
    );
  }
}
