import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/common/constants/list_img_fake.dart';
import 'package:friendzone/data/models/post.dart';
import 'package:friendzone/presentation/views/home/widgets/post_button_bar.dart';
import 'package:friendzone/presentation/views/home/widgets/post_comments.dart';
import 'package:friendzone/state/home/post_cubit/post_cubit_cubit.dart';

class PostDetailScreen extends StatelessWidget {
  final Post post;
  PostDetailScreen({super.key, required this.post});
  final TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
      child: CustomScrollView(
        slivers: [
          const SliverAppBar(title: Text('Post')),
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
                            image: CachedNetworkImageProvider(post.imageUrl),
                            fit: BoxFit.cover)),
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
                          backgroundImage: CachedNetworkImageProvider(
                              post.avartarAuthor ?? urlAvatar),
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
                  PostButtonBar(
                      post: post,
                      callBack: (_) {
                        context.read<PostCubitCubit>().commentPost(post.id);
                      }),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      'All comments',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const PostComments()
        ],
      ),
    );

    //   bottomNavigationBar: Container(
    //     padding: const EdgeInsets.only(bottom: 26.0, left: 16, right: 16),
    //     width: size.width,
    //     child: Row(
    //       children: [
    //         Expanded(
    //           child: TextFormField(
    //             controller: textEditingController,
    //             decoration: InputDecoration(
    //               filled: true,
    //               hintText: 'comment',
    //               hintStyle: const TextStyle(fontSize: 14),
    //               contentPadding: const EdgeInsets.all(16),
    //               border: OutlineInputBorder(
    //                 borderRadius: BorderRadius.circular(10),
    //                 borderSide: BorderSide.none,
    //               ),
    //             ),
    //           ),
    //         ),
    //         IconButton(onPressed: () {}, icon: const Icon(Icons.send))
    //       ],
    //     ),
  }
}
