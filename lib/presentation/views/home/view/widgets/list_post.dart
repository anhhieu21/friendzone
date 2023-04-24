import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/presentation/views/home/bloc/allpost/all_post_cubit.dart';
import 'package:friendzone/presentation/views/home/view/widgets/post_item.dart';
import 'package:friendzone/presentation/views/profile/cubit/myaccount/my_account_cubit.dart';

class ListPost extends StatelessWidget {
  const ListPost({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AllPostCubit, AllPostState>(
      listener: (context, state) {
        if (state is AllPostShow) {
          context.read<MyAccountCubit>().myAccountInfo();
        }
      },
      child: BlocBuilder<AllPostCubit, AllPostState>(
        builder: (context, state) {
          if (state is AllPostShow) {
            if (state.listPost.isEmpty) {
              return const Center(
                child: Text('Không có bài viết nào cả'),
              );
            }
            return ListView.builder(
                shrinkWrap: true,
                itemCount: state.listPost.length,
                physics: const ScrollPhysics(),
                itemBuilder: (context, index) {
                  final item = state.listPost[index];
                  return PostItem(item: item);
                });
          } else {
            return const Center(
              child: Text('Không có bài viết nào cả'),
            );
          }
        },
      ),
    );
  }
}
