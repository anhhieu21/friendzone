import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/common/extentions/size_extention.dart';
import 'package:friendzone/presentation/themes/color.dart';
import 'package:friendzone/presentation/views/profile/cubit/update/update_profile_cubit.dart';
import 'package:friendzone/presentation/views/widgets/custom_textfield.dart';
import 'package:ionicons/ionicons.dart';

import 'widgets/header_profile.dart';

class UpdateProfileScreen extends StatelessWidget {
  final User userDetail;
  UpdateProfileScreen({super.key, required this.userDetail});
  final TextEditingController controllerName = TextEditingController();
  final TextEditingController controllerPhone = TextEditingController();
  final stream = FirebaseAuth.instance.authStateChanges();
  _updatedUser(BuildContext context) async {
    BlocProvider.of<UpdateProfileCubit>(context).updateProfile(
        displayName: controllerName.text, phone: controllerPhone.text);
  }

  _choseImage(BuildContext context) {
    BlocProvider.of<UpdateProfileCubit>(context).choseImage();
  }

  @override
  Widget build(BuildContext context) {
    final size = SizeEx(context).screenSize;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông tin người dùng'),
        actions: [
          TextButton(
              onPressed: () => _updatedUser(context),
              child: const Text('Cập nhật'))
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Stack(
                children: [
                  BlocBuilder<UpdateProfileCubit, UpdateProfileState>(
                      builder: (_, state) {
                    if (state is UpdateProfileChoseImage) {
                      return CircleAvatar(
                          radius: size.width / 8,
                          backgroundImage: FileImage(state.file));
                    } else {
                      return CircleAvatar(
                        radius: size.width / 8,
                        backgroundImage:
                            NetworkImage(userDetail.photoURL ?? urlAvatar),
                      );
                    }
                  }),
                  Positioned(
                    bottom: -12,
                    right: 0,
                    child: IconButton(
                        onPressed: () => _choseImage(context),
                        icon: Icon(
                          Ionicons.camera,
                          color: colorBlue.shade400,
                          size: 30,
                        )),
                  )
                ],
              ),
              CustomTextField(
                  controller: controllerName,
                  label: 'Tên người dùng',
                  hint: userDetail.displayName ?? 'tên hiển thị',
                  error: 'error'),
              CustomTextField(
                  controller: controllerPhone,
                  label: 'Liên lạc',
                  hint: 'số điện thoại',
                  error: 'error'),
              CustomTextField(
                label: 'Email',
                hint: userDetail.email.toString(),
                error: 'error',
                readOnly: true,
              )
            ],
          )),
    );
  }
}
