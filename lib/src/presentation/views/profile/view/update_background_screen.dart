import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/src/domain.dart';
import 'package:friendzone/src/presentation/state/profile/myaccount/my_account_cubit.dart';
import 'package:friendzone/src/presentation/state/profile/update/update_profile_cubit.dart';
import 'package:friendzone/src/presentation/widgets/avatar_profile.dart';
import 'package:friendzone/src/presentation/widgets/custom_overlayentry.dart';
import 'package:friendzone/src/utils.dart';
import 'package:go_router/go_router.dart';

class UpdateBackgroundScreen extends StatelessWidget {
  UpdateBackgroundScreen({super.key});
  _updateBackgroundProfile(BuildContext context, UserModel user) async {
    BlocProvider.of<UpdateProfileCubit>(context)
        .updateProfile(userModel: user, isUpdateBackground: true);
  }

  final StreamController<bool> _checkBoxController = StreamController<bool>();
  @override
  Widget build(BuildContext context) {
    final size = SizeEx(context).screenSize;
    final theme = Theme.of(context);
    return BlocSelector<MyAccountCubit, MyAccountState, UserModel?>(
        selector: (state) {
      if (state is MyDataState) {
        return state.user;
      }
      return null;
    }, builder: (context, user) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Xem lại thay đổi'),
        ),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(children: [
                SizedBox(height: 140 + size.width / 7.5 - 16.0),
                BlocConsumer<UpdateProfileCubit, UpdateProfileState>(
                  listener: (BuildContext context, UpdateProfileState state) {
                    if (state is UpdateProfileSuccess) {
                      CustomOverlayEntry.instance.hideOverlay();
                      context.pop();
                    }
                    if (state is UpdatingProfile) {
                      CustomOverlayEntry.instance
                          .loadingCircularProgressIndicator(context);
                    }
                  },
                  buildWhen: (_, state) {
                    if (state is UpdateProfileChoseImage) {
                      return true;
                    }
                    return false;
                  },
                  builder: (_, state) => Image.file(
                    (state as UpdateProfileChoseImage).file,
                    width: size.width,
                    height: 140,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 16.0,
                  child: AvatarProfile(
                    url: user!.avartar,
                    radius: size.width / 7.5,
                  ),
                )
              ]),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  Formatter.emailtoDisplayName(user.name),
                  style: theme.textTheme.titleLarge!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ),
            ]),
        bottomNavigationBar: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            CheckboxListTile(
              value: true,
              onChanged: (value) =>
                  _checkBoxController.sink.add(value ?? false),
              title: Text(
                'Chia sẻ lên bảng tin',
                style: theme.textTheme.bodyLarge!
                    .copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 16.0, 16.0),
              child: ElevatedButton(
                  onPressed: () => _updateBackgroundProfile(context, user),
                  child: Text(
                    'Cập nhật ảnh bìa',
                    style: theme.textTheme.bodyLarge!
                        .copyWith(fontWeight: FontWeight.w600),
                  )),
            )
          ],
        ),
      );
    });
  }
}
