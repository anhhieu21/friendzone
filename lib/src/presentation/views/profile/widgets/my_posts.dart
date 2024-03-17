import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:friendzone/src/core/utils/constants/gap.dart';
import 'package:friendzone/src/domain.dart';
import 'package:friendzone/src/presentation/state.dart';
import 'package:friendzone/src/presentation/views/profile/widgets/item_post.dart';

const kMaxCrossAxisExtent = 250.0;

class TabMyPosts extends StatelessWidget {
  final Size size;
  final List<Post> listPost;
  const TabMyPosts({super.key, required this.size, required this.listPost});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return RefreshIndicator(
        onRefresh: () => context.read<MyAccountCubit>().myAccountInfo(user.uid),
        child: Padding(
          padding: const EdgeInsets.all(Gap.s),
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
  }
}
