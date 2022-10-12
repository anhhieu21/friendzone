import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:friendzone/presentation/views/profile/myaccount/my_account_cubit.dart';
import 'package:friendzone/presentation/views/profile/view/widgets/item_post.dart';

const kMaxCrossAxisExtent = 350.0;

class MyPosts extends StatelessWidget {
  final Size size;
  const MyPosts({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyAccountCubit, MyAccountState>(
      builder: (context, state) {
        if (state is MyAccountInfo) {
          return MasonryGridView.extent(
              maxCrossAxisExtent: kMaxCrossAxisExtent,
              itemCount: state.myPosts.length,
              shrinkWrap: true,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              itemBuilder: (context, index) {
                final item = state.myPosts[index];
                return ItemPost(size: size, item: item);
              });
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
