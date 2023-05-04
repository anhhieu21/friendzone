import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:friendzone/presentation/views/profile/cubit/myaccount/my_account_cubit.dart';
import 'package:friendzone/presentation/views/profile/view/widgets/item_post.dart';

const kMaxCrossAxisExtent = 250.0;

class MyPosts extends StatelessWidget {
  final Size size;
  const MyPosts({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyAccountCubit, MyAccountState>(
      buildWhen: (previous, current) {
        return previous != current;
      },
      builder: (context, state) {
        if (state is MyAccountInfo) {
          final listPost = [
            ...state.myPostsPublic,
            ...state.myPostsPublic,
            ...state.myPostsPublic,
            ...state.myPostsPublic,
            ...state.myPostsPublic,
          ];
          return RefreshIndicator(
              onRefresh: () => context.read<MyAccountCubit>().myAccountInfo(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: MasonryGridView.count(
                    crossAxisCount: 2,
                    itemCount: listPost.length,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    itemBuilder: (context, index) {
                      final item = listPost[index];
                      return ItemPost(size: size, item: item);
                    }),
              ));
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
