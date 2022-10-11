import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/common/extentions/size_extention.dart';
import 'package:friendzone/presentation/views/home/bloc/allpost/all_post_cubit.dart';
import 'package:friendzone/presentation/views/home/view/widgets/app_bar.dart';
import 'package:friendzone/presentation/views/home/view/widgets/list_new_feed.dart';
import 'package:friendzone/presentation/views/home/view/widgets/list_post.dart';

const urlImg =
    'https://images.unsplash.com/photo-1664574654700-75f1c1fad74e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = BuildContextX(context).screenSize;
    return Scaffold(
      appBar: const CustomAppBar(),
      body: RefreshIndicator(
        onRefresh: () => BlocProvider.of<AllPostCubit>(context).getAllPost(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListNewFeed(size: size),
              const ListPost(),
            ],
          ),
        ),
      ),
    );
  }
}
