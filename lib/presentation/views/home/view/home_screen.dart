import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/common/extentions/size_extention.dart';
import 'package:friendzone/data/models/post.dart';
import 'package:friendzone/data/repositories/post_repository.dart';
import 'package:friendzone/presentation/view.dart';
import 'package:friendzone/presentation/views/home/bloc/post_cubit/post_cubit_cubit.dart';

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
    return BlocProvider(
      create: (context) =>
          PostCubitCubit(RepositoryProvider.of<PostRepository>(context)),
      child: RefreshIndicator(
          onRefresh: () => BlocProvider.of<AllPostCubit>(context).getAllPost(),
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
                      height: kBottomNavigationBarHeight * 2,
                    ),
                  )
                ],
              );
            },
          )),
    );
  }
}
