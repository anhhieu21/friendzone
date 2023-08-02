import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/common/extentions/size_extention.dart';

import 'package:friendzone/presentation/themes/color.dart';
import 'package:friendzone/presentation/view.dart';
import 'package:friendzone/presentation/views/profile/widgets/header_profile_user.dart';
import 'package:friendzone/state/profile/user/user_cubit.dart';

const expandedHeight = 340.0;

class ProfileDetailScreen extends StatefulWidget {
  final String id;
  const ProfileDetailScreen({super.key, required this.id});

  @override
  State<ProfileDetailScreen> createState() => _ProfileDetailScreenState();
}

class _ProfileDetailScreenState extends State<ProfileDetailScreen> {
  late ScrollController scrollController;
  @override
  void initState() {
    scrollController = ScrollController();
    BlocProvider.of<UserPreviewCubit>(context, listen: false)
        .loadInitialData(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = SizeEx(context).screenSize;
    return Material(
      child: BlocBuilder<UserPreviewCubit, UserpreviewState>(
        buildWhen: (previous, current) {
          if (current is LoadingState || current is UserDataState) return true;
          return false;
        },
        builder: (context, state) {
          if (state is LoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is UserDataState) {
            final listPost = state.post;
            return CustomScrollView(controller: scrollController, slivers: [
              CustomSliverAppBar(
                scrollController: scrollController,
                expandedHeight: expandedHeight,
                collapsedHeight: kToolbarHeight,
                expandedTitleScale: 1,
                titlePadding: EdgeInsets.zero,
                flexTitle: HeaderProfileUser(
                  size: size,
                  user: state.user,
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                sliver: SliverToBoxAdapter(
                    child: Container(
                        width: size.width,
                        height: 10,
                        color: colorGrey.shade300)),
              ),
              SliverList.builder(
                  itemCount: listPost.length,
                  itemBuilder: (context, index) {
                    final item = listPost[index];
                    return PostItem(item: item, isPreviewUser: true);
                  })
            ]);
          }
          return const SizedBox();
        },
      ),
    );
  }
}
