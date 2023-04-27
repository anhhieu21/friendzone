import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/common/extentions/size_extention.dart';
import 'package:friendzone/data/models/post.dart';
import 'package:friendzone/presentation/views/home/bloc/allpost/all_post_cubit.dart';
import 'package:friendzone/presentation/views/home/view/widgets/list_new_feed.dart';
import 'package:friendzone/presentation/views/home/view/widgets/list_post.dart';

import '../../profile/cubit/myaccount/my_account_cubit.dart';
import 'widgets/custom_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final size = SizeEx(context).screenSize;
    return RefreshIndicator(
        onRefresh: () => BlocProvider.of<AllPostCubit>(context).getAllPost(),
        child: BlocListener<AllPostCubit, AllPostState>(
          listener: (context, state) {
            if (state is AllPostShow) {
              context.read<MyAccountCubit>().myAccountInfo();
            }
          },
          child: BlocBuilder<AllPostCubit, AllPostState>(
            builder: (context, state) {
              final listPost = state is AllPostShow ? state.listPost : <Post>[];
              return CustomScrollView(
                controller: scrollController,
                slivers: [
                  CustomSliverAppBar(scrollController: scrollController),
                  ListNewFeed(size: size),
                  ListPost(listPost: listPost),
                  SliverToBoxAdapter(
                    child: Container(
                      height: kBottomNavigationBarHeight*2,
                    ),
                  )
                ],
              );
            },
          ),
        ));
  }
}
