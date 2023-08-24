import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/common/extentions/size_extention.dart';
import 'package:friendzone/data/models/post.dart';
import 'package:friendzone/data/models/user_model.dart';
import 'package:friendzone/presentation/routes/path.dart';
import 'package:friendzone/presentation/shared/widgets/layout_images.dart';
import 'package:friendzone/presentation/shared/widgets/ontap_effect.dart';
import 'package:friendzone/presentation/utils/formatter.dart';
import 'package:friendzone/presentation/views/home/widgets/post_button_bar.dart';
import 'package:friendzone/presentation/state.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';

class PostItem extends StatelessWidget {
  final Post item;
  final bool isPreviewUser;
  const PostItem({Key? key, required this.item, this.isPreviewUser = false})
      : super(key: key);
  _likePost(BuildContext context, UserModel? user) {
    BlocProvider.of<PostCubitCubit>(context).likePost(item, user!);
  }

  _postDetail(BuildContext context) {
    context.read<PostCubitCubit>().commentPost(item.id).then((value) {
      context.pushNamed(Formatter.nameRoute(RoutePath.postDetail), extra: item);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = SizeEx(context).screenSize;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<PostCubitCubit, PostCubitState>(
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
                      child: OnTapEffect(
                        radius: 16,
                        onTap: isPreviewUser
                            ? () {}
                            : () => context.pushNamed(
                                Formatter.nameRoute(RoutePath.profileDetail),
                                extra: post.idUser),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 24,
                              backgroundImage: CachedNetworkImageProvider(
                                  post.avartarAuthor),
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
                      ),
                      child: LayoutImages(images: post.imagesUrl),
                    ),
                    BlocSelector<MyAccountCubit, MyAccountState, UserModel?>(
                        selector: (state) {
                      if (state is MyDataState) return state.user;
                      return null;
                    }, builder: (_, state) {
                      return PostButtonBar(
                          post: post, callBack: (_) => _likePost(_, state));
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
