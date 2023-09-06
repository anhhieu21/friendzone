import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/src/domain.dart';
import 'package:friendzone/src/presentation/state.dart';
import 'package:friendzone/src/presentation/view.dart';
import 'package:friendzone/src/utils.dart';

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
        child: BlocBuilder<AllPostCubit, AllPostState>(
          builder: (context, state) {
            final listPost = state is AllPostShow ? state.listPost : <Post>[];
            return CustomScrollView(
              controller: scrollController,
              slivers: [
                AppBarHome(scrollController: scrollController),
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
        ));
  }
}
