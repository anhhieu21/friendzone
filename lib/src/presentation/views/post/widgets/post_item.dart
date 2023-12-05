import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/src/config.dart';
import 'package:friendzone/src/domain.dart';
import 'package:friendzone/src/presentation/shared.dart';
import 'package:friendzone/src/presentation/state.dart';
import 'package:friendzone/src/presentation/view.dart';
import 'package:friendzone/src/utils.dart';

import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';

class PostItem extends StatelessWidget {
  final Post item;
  final bool isPreviewUser;
  const PostItem({Key? key, required this.item, this.isPreviewUser = false})
      : super(key: key);
  _likePost(BuildContext context, UserModel? user) {
    BlocProvider.of<PostCubit>(context).likePost(item, user!);
  }

  _postDetail(BuildContext context) {
    context.read<PostCubit>().commentPost(item.id).then((value) {
      context.pushNamed(RoutePath.routeName(RoutePath.postDetail), extra: item);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = SizeEx(context).screenSize;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<PostCubit, PostCubitState>(
        builder: (context, state) {
          var post = item;
          if (state.post != null && state.post!.id == post.id) {
            post = state.post!;
          }
          return GestureDetector(
            onTap: () => _postDetail(context),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Theme.of(context).cardColor),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Author(isPreviewUser: isPreviewUser, post: post),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        post.content,
                      ),
                    ),
                    SizedBox(
                      width: size.width,
                      height: size.width / 1.5,
                      child: LayoutImages(images: post.imagesUrl),
                    ),
                    BlocSelector<MyAccountCubit, MyAccountState, UserModel?>(
                        selector: (state) {
                      if (state is MyDataState) return state.user;
                      return null;
                    }, builder: (_, state) {
                      return PostButtonBar(
                          post: post, callBack: (value) => _likePost(_, state));
                    })
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class Author extends StatelessWidget {
  final bool isPreviewUser;
  final Post post;
  const Author({super.key, required this.isPreviewUser, required this.post});

  @override
  Widget build(BuildContext context) {
    return OnTapEffect(
      radius: 16,
      onTap: isPreviewUser
          ? () {}
          : () => context.pushNamed(
              RoutePath.routeName(RoutePath.profileDetail),
              extra: post.idUser),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundImage: CachedNetworkImageProvider(post.avartarAuthor),
          ),
          Expanded(
            child: ListTile(
              contentPadding: const EdgeInsets.only(left: 5),
              title: Text(
                post.author,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Text(post.createdAt),
            ),
          ),
          IconButton(
              onPressed: () {}, icon: const Icon(Ionicons.ellipsis_horizontal)),
        ],
      ),
    );
  }
}
