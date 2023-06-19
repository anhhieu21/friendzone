import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/common/extentions/size_extention.dart';
import 'package:friendzone/data/models/post.dart';
import 'package:friendzone/data/repositories/post_repository.dart';
import 'package:friendzone/presentation/routes/path.dart';
import 'package:friendzone/presentation/themes/color.dart';
import 'package:friendzone/presentation/utils/formatter.dart';
import 'package:friendzone/presentation/views/home/widgets/post_button_bar.dart';
import 'package:friendzone/state.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../common/constants/list_img_fake.dart';

class PostItem extends StatelessWidget {
  final Post item;
  const PostItem({
    Key? key,
    required this.item,
  }) : super(key: key);
  _likePost(BuildContext context) {
    final user =
        BlocProvider.of<MyAccountCubit>(context, listen: false).state.user;
    BlocProvider.of<PostCubitCubit>(context).likePost(item, user!);
  }

  @override
  Widget build(BuildContext context) {
    final size = SizeEx(context).screenSize;
    return BlocProvider(
      create: (_) =>
          PostCubitCubit(RepositoryProvider.of<PostRepository>(context)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PostCubitCubit, PostCubitState>(
          builder: (context, state) {
            var post = item;
            if (state.post != null && state.post!.id == post.id) {
              post = state.post!;
            }
            return GestureDetector(
              onTap: () {
                context.pushNamed(Formatter.nameRoute(RoutePath.postDetail),
                    extra: item);
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16), color: colorWhite),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 24,
                              backgroundImage: CachedNetworkImageProvider(
                                  post.avartarAuthor ?? urlAvatar),
                            ),
                            Expanded(
                              child: ListTile(
                                contentPadding: const EdgeInsets.only(left: 5),
                                title: Text(
                                  post.author,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600),
                                ),
                                subtitle: Text(post.createdAt),
                              ),
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(Ionicons.ellipsis_horizontal)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          post.content,
                        ),
                      ),
                      Container(
                        width: size.width,
                        height: size.width / 1.5,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            image: DecorationImage(
                                image:
                                    CachedNetworkImageProvider(post.imageUrl),
                                fit: BoxFit.cover)),
                      ),
                      PostButtonBar(post: post, callBack: _likePost)
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
