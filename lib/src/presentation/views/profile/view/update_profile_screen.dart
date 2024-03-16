import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/src/presentation/shared.dart';
import 'package:friendzone/src/presentation/state.dart';
import 'package:friendzone/src/utils.dart';

import 'package:ionicons/ionicons.dart';

import '../../../../core/config/themes/color.dart';
import '../../../../domain/models/user_model.dart';

class UpdateProfileScreen extends StatelessWidget {
  final UserModel userDetail;
  UpdateProfileScreen({super.key, required this.userDetail});
  final TextEditingController controllerName = TextEditingController();
  final TextEditingController controllerPhone = TextEditingController();
  final TextEditingController controllerBio = TextEditingController();
  final stream = FirebaseAuth.instance.authStateChanges();
  _updatedUser(BuildContext context) async {
    final name = controllerName.text.trim();
    final phone = controllerPhone.text.trim();
    final bio = controllerBio.text.trim();
    if (name.isNotEmpty) {
      userDetail.name = name;
    }
    if (phone.isNotEmpty) {
      userDetail.phone = phone;
    }
    if (bio.isNotEmpty) {
      userDetail.bio = bio;
    }
    BlocProvider.of<UpdateProfileCubit>(context)
        .updateProfile(userModel: userDetail);
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
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Stack(
                  children: [
                    BlocConsumer<UpdateProfileCubit, UpdateProfileState>(
                        listener: (context, state) {
                      if (state is UpdatingProfile) {
                        CustomOverlayEntry.instance
                            .loadingCircularProgressIndicator(context);
                      }
                      if (state is UpdateProfileSuccess) {
                        context
                            .read<MyAccountCubit>()
                            .myAccountInfo(userDetail.idUser);
                        CustomOverlayEntry.instance.hideOverlay();
                      }
                    }, builder: (_, state) {
                      if (state is UpdateProfileChoseImage) {
                        return CircleAvatar(
                          radius: size.width / 8,
                          backgroundImage: FileImage(state.file),
                        );
                      } else {
                        return CircleAvatar(
                          radius: size.width / 8,
                          backgroundImage: NetworkImage(userDetail.avartar),
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
                    hint: userDetail.name,
                    error: 'error'),
                CustomTextField(
                    controller: controllerPhone,
                    label: 'Liên lạc',
                    hint: userDetail.phone,
                    error: 'error'),
                CustomTextField(
                  label: text.email,
                  hint: userDetail.email,
                  error: 'error',
                  readOnly: true,
                ),
                CustomTextField(
                  controller: controllerBio,
                  label: 'Bio',
                  hint: userDetail.bio ?? '',
                  error: 'error',
                )
              ],
            )),
      ),
    );
  }
}
