import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/presentation/themes/color.dart';
import 'package:friendzone/presentation/views/post/cubit/write_post_cubit.dart';

class WritePost extends StatelessWidget {
  const WritePost({super.key});

  _uploadPost(BuildContext context, String content) {
    BlocProvider.of<WritePostCubit>(context).upPost(content, 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Post')),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () => _uploadPost(context, "Nature is beutyful"),
              child: const Text(
                'Chọn',
                style: TextStyle(color: colorBlack),
              ))
        ],
      ),
    );
  }
}
