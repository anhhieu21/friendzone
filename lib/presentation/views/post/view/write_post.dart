import 'dart:io';

// import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/common/extentions/size_extention.dart';
import 'package:friendzone/data/models/post.dart';
import 'package:friendzone/presentation/themes/color.dart';
import 'package:friendzone/presentation/views/post/cubit/write_post_cubit.dart';
import 'package:friendzone/presentation/views/post/view/widgets/menu_options.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';

class WritePost extends StatelessWidget {
  WritePost({super.key});
  final privateNotifi = ValueNotifier<bool?>(null);

  _uploadPost(BuildContext context, File? file, String content, bool visible) {
    if (file != null && content != "") {
      BlocProvider.of<WritePostCubit>(context)
          .upPost(file, content, 0, visible);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Hay viết gì đó và chọn 1 bức ảnh thật đẹp nào !')));
    }
  }

  _choseImage(BuildContext context) {
    BlocProvider.of<WritePostCubit>(context).choseImage();
  }

  final TextEditingController contentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = SizeEx(context).screenSize;
    return Scaffold(
        appBar: AppBar(title: const Text('Post')),
        body: BlocListener<WritePostCubit, WritePostState>(
          listener: (context, state) {
            // if (state is WritePostChoseImage) imageFile = state.file;
            if (state is WritePostUploadSucces) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Đã đăng bài viết')));
              GoRouter.of(context).pop();
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Align(
                    alignment: Alignment.centerRight,
                    child: MenuOptions(
                      onChanged: (Enum? value) {
                        if (value != null) {
                          privateNotifi.value = getOptionPost(value);
                        }
                      },
                    )),
              ),
              TextField(
                maxLength: 1000,
                controller: contentController,
                decoration: InputDecoration(
                    hintText: 'viết gì đó ở đây',
                    contentPadding: const EdgeInsets.all(8),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(12))),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: BlocBuilder<WritePostCubit, WritePostState>(
                  builder: (context, state) {
                    if (state is WritePostChoseImage) {
                      return Column(
                        children: [
                          Image.file(
                            state.file,
                            fit: BoxFit.cover,
                            height: size.width / 1.2,
                            width: size.width,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: ValueListenableBuilder<bool?>(
                                  valueListenable: privateNotifi,
                                  builder: (context, value, child) {
                                    print(value);
                                    return ElevatedButton(
                                      onPressed: () => _uploadPost(
                                          context,
                                          state.file,
                                          contentController.text,
                                          value ?? true),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: colorBlue.shade200,
                                      ),
                                      child: const Text(
                                        'Đăng bài viết',
                                        style: TextStyle(color: colorWhite),
                                      ),
                                    );
                                  }),
                            ),
                          )
                        ],
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: GestureDetector(
                          onTap: () => _choseImage(context),
                          child: Container(
                            height: size.width / 3,
                            width: size.width / 3,
                            decoration: BoxDecoration(
                                color: colorBlue.shade200,
                                borderRadius: BorderRadius.circular(12)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Ionicons.add_circle,
                                  size: 45,
                                  color: colorGrey.shade200,
                                ),
                                const Text('Chọn ảnh')
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
