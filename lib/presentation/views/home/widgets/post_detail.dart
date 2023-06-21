import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/common/constants/list_img_fake.dart';
import 'package:friendzone/data/models/comment.dart';
import 'package:friendzone/data/models/post.dart';
import 'package:friendzone/presentation/themes/color.dart';
import 'package:friendzone/presentation/views/home/widgets/post_button_bar.dart';
import 'package:friendzone/presentation/views/home/widgets/post_comments.dart';
import 'package:friendzone/state/home/post_cubit/post_cubit_cubit.dart';
import 'package:friendzone/state/profile/myaccount/my_account_cubit.dart';

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
    widget.post.totalComment =
        BlocProvider.of<PostCubitCubit>(context, listen: false)
                .state
                .comments
                ?.length ??
            0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
      child: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                const SliverAppBar(
                  title: Text('Post'),
                  stretch: true,
                  floating: true,
                ),
                SliverToBoxAdapter(
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
                              image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                      widget.post.imageUrl),
                                  fit: BoxFit.cover)),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text('By'),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 2.0),
                                child: Text(
                                  widget.post.author,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              CircleAvatar(
                                radius: 14,
                                backgroundImage: CachedNetworkImageProvider(
                                    widget.post.avartarAuthor ?? urlAvatar),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            widget.post.content,
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
                        PostButtonBar(post: widget.post, callBack: (_) {}),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            'All comments',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const PostComments(),
              ],
            ),
          ),
          Container(
            height: 80,
            color: colorGrey.shade100,
            padding: const EdgeInsets.fromLTRB(16.0, 4.0, 0, 16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: textEditingController,
                    decoration: InputDecoration(
                      filled: true,
                      hintText: 'comment',
                      hintStyle: const TextStyle(fontSize: 14),
                      contentPadding: const EdgeInsets.all(16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () => _insertComment(context),
                    icon: const Icon(Icons.send))
              ],
            ),
          ),
        ],
      ),
    );
  }

  _insertComment(BuildContext context) async {
    if (textEditingController.text.isEmpty) return;
    final user =
        BlocProvider.of<MyAccountCubit>(context, listen: false).state.user!;
    await context.read<PostCubitCubit>().insertCommentPost(
        widget.post.id,
        Comment(
            id: '',
            content: textEditingController.text,
            idUser: user.idUser,
            nameAuthor: user.name,
            createdAt: DateTime.now()));
    textEditingController.clear();
  }
}
