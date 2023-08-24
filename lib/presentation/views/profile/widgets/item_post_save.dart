import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/data.dart';
import 'package:friendzone/presentation/state/profile/myaccount/my_account_cubit.dart';
import 'package:ionicons/ionicons.dart';

class ItemPostSave extends StatelessWidget {
  final Post post;
  const ItemPostSave({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.0)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            height: 60,
            width: 80,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                image: DecorationImage(
                    image: CachedNetworkImageProvider(post.imagesUrl.first),
                    fit: BoxFit.cover)),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                      text: TextSpan(
                          text: 'by ',
                          style: DefaultTextStyle.of(context).style,
                          children: [
                        TextSpan(
                            text: post.author,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      ])),
                  Text(post.content),
                ],
              ),
            ),
          ),
          IconButton(
              onPressed: () => context.read<MyAccountCubit>().unSavePost(post),
              icon: const Icon(Ionicons.bookmarks))
        ],
      ),
    );
  }
}
