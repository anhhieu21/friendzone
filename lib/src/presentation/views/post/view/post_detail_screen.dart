import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

import 'package:friendzone/src/config.dart';
import 'package:friendzone/src/domain.dart';
import 'package:friendzone/src/presentation/shared.dart';
import 'package:friendzone/src/presentation/state.dart';
import 'package:friendzone/src/presentation/view.dart';
import 'package:friendzone/src/utils.dart';

class PostDetailScreen extends StatefulWidget {
  final Post post;
  const PostDetailScreen({super.key, required this.post});

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  final TextEditingController textEditingController = TextEditingController();
  @override
  void initState() {
    final provider = BlocProvider.of<PostCubit>(context, listen: false);
    widget.post.totalComment = provider.state.comments?.length ?? 0;
    provider.init(widget.post.id);
    super.initState();
  }

  _savePost() {
    context.read<MyAccountCubit>().savePost(widget.post).then((isSaved) {
      BlocProvider.of<PostCubit>(context, listen: false).init(widget.post.id);
      DialogCustom.instance.showDialogDuration(
          context: context, content: isSaved ? savePostMsg : unSavePostMsg);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          Expanded(child:
              BlocBuilder<PostCubit, PostCubitState>(builder: (context, state) {
            var post = widget.post;
            if (state.post != null && state.post!.id == post.id) {
              post = state.post!;
            }
            final isSaved = state.isSaved ?? false;
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  title: Text(text.post),
                  stretch: true,
                  floating: true,
                  actions: [
                    IconButton(
                      onPressed: _savePost,
                      icon: AnimatedCrossFade(
                        firstChild: const Icon(Ionicons.bookmark),
                        secondChild: const Icon(Ionicons.bookmark_outline),
                        duration: durationAnimation,
                        crossFadeState: isSaved
                            ? CrossFadeState.showFirst
                            : CrossFadeState.showSecond,
                      ),
                    )
                  ],
                ),
                BodyPost(post: post, liked: state.isLiked ?? false),
                PostComments(
                  list: state.comments ?? [],
                ),
              ],
            );
          })),
          Container(
            color: colorGrey.shade100,
            padding: EdgeInsets.fromLTRB(
                16.0, 4.0, 0, MediaQuery.of(context).viewInsets.bottom),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: textEditingController,
                    decoration: InputDecoration(
                      filled: true,
                      hintText: 'commentx',
                      hintStyle: const TextStyle(fontSize: 14),
                      contentPadding: const EdgeInsets.all(16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                BlocSelector<MyAccountCubit, MyAccountState, UserModel?>(
                  selector: (state) {
                    if (state is MyDataState) return state.user;
                    return null;
                  },
                  builder: (_, state) {
                    return IconButton(
                        onPressed: () => _insertComment(context, state),
                        icon: const Icon(Icons.send));
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  _insertComment(BuildContext context, UserModel? user) async {
    if (textEditingController.text.isEmpty) return;

    await context.read<PostCubit>().insertCommentPost(
        widget.post.id,
        Comment(
            id: '',
            content: textEditingController.text,
            idUser: user!.idUser,
            nameAuthor: user.name,
            createdAt: DateTime.now()));
    textEditingController.clear();
  }
}

class BodyPost extends StatelessWidget {
  final Post post;
  final bool liked;
  const BodyPost({
    super.key,
    required this.post,
    required this.liked,
  });
  @override
  Widget build(BuildContext context) {
    final size = SizeEx(context).screenSize;
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: size.width,
              height: size.width / 1.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: LayoutImages(images: post.imagesUrl),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text('By'),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: Text(
                      post.author,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  CircleAvatar(
                    radius: 14,
                    backgroundImage:
                        CachedNetworkImageProvider(post.avartarAuthor),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                post.content,
              ),
            ),
            Center(
              child: Container(
                color: Colors.grey,
                margin: const EdgeInsets.symmetric(vertical: 16.0),
                width: size.width / 2,
                height: 1,
              ),
            ),
            BlocSelector<MyAccountCubit, MyAccountState, UserModel?>(
                selector: (state) {
              if (state is MyDataState) return state.user;
              return null;
            }, builder: (_, state) {
              return PostButtonBar(
                  post: post,
                  liked: liked,
                  callBack: (value) =>
                      _handleCallBack(context, value, post, state!));
            }),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Text(
                'All comments',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _handleCallBack(
      BuildContext context, MenuPost menuPost, Post item, UserModel user) {
    switch (menuPost) {
      case MenuPost.like:
        BlocProvider.of<PostCubit>(context).likePost(item, user);
        break;
      case MenuPost.comment:
        break;
      case MenuPost.share:
        break;
      default:
    }
  }
}
