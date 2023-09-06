import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/src/config.dart';
import 'package:friendzone/src/domain.dart';
import 'package:friendzone/src/presentation/shared.dart';
import 'package:friendzone/src/presentation/state.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';

class UpNewFeedScreen extends StatelessWidget {
  const UpNewFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context)
        .textTheme
        .bodyMedium!
        .copyWith(fontWeight: FontWeight.bold);
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<FeedCubit, FeedState>(
          listener: (_, state) {
            if (state is FeedLoading) {
              DialogCustom.instance.showLoading(context, true);
            }
            if (state is FeedCreated) {
              GoRouter.of(context).go(RoutePath.main);
            }
          },
          child: Padding(
            padding: const EdgeInsets.only(bottom: kBottomNavigationBarHeight),
            child: Stack(
              children: [
                Positioned(
                    top: 0,
                    right: 16,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _buttonOption(
                            "Nhãn dán", Ionicons.logo_octocat, textStyle),
                        _buttonOption(
                            "Văn bản", Ionicons.text_outline, textStyle),
                        _buttonOption(
                            "Gắn thẻ", Ionicons.people_outline, textStyle),
                      ],
                    )),
                const ImageView(),
                Positioned(
                  left: 16,
                  right: 16,
                  bottom: 16,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(Ionicons.settings_outline)),
                          Text(
                            "Quyền riêng tư",
                            style: textStyle,
                          )
                        ],
                      ),
                      BlocSelector<MyAccountCubit, MyAccountState, UserModel?>(
                        selector: (state) {
                          if (state is MyDataState) {
                            return state.user;
                          }
                          return null;
                        },
                        builder: (_, user) => ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: colorBlue),
                            onPressed: () => _createFeed(context, user!),
                            child: const Text(
                              "Chia sẽ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }

  _createFeed(BuildContext context, UserModel userModel) {
    BlocProvider.of<FeedCubit>(listen: false, context).createFeed(userModel);
  }

  Widget _buttonOption(String label, IconData iconData, TextStyle style) =>
      OnTapEffect(
        onTap: () {},
        radius: 8,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(label, style: style),
              const SizedBox(width: 8),
              Icon(iconData)
            ],
          ),
        ),
      );
}

class ImageView extends StatelessWidget {
  const ImageView({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context)
        .textTheme
        .bodyMedium!
        .copyWith(fontWeight: FontWeight.bold);
    return BlocSelector<FeedCubit, FeedState, File?>(selector: (state) {
      if (state is FeedPickImage) {
        return state.file;
      }
      return null;
    }, builder: (_, file) {
      return Center(
        child: file == null
            ? _buttonPickImage(_, textStyle)
            : Image.file(file, fit: BoxFit.cover),
      );
    });
  }

  Widget _buttonPickImage(BuildContext context, TextStyle textStyle) {
    return TextButton(
      onPressed: () => _pickImage(context),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Ionicons.add_circle_sharp),
          Text(
            'Chọn ảnh',
            style: textStyle,
          )
        ],
      ),
    );
  }

  _pickImage(BuildContext context) async {
    await BlocProvider.of<FeedCubit>(listen: false, context).pickImage();
  }
}
