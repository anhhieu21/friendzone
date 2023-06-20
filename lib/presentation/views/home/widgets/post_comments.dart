import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/common/constants/list_img_fake.dart';
import 'package:friendzone/presentation/themes/color.dart';
import 'package:friendzone/state/home/post_cubit/post_cubit_cubit.dart';
import 'package:friendzone/state/home/post_cubit/post_cubit_state.dart';

class PostComments extends StatelessWidget {
  const PostComments({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      sliver: BlocBuilder<PostCubitCubit, PostCubitState>(
        builder: (context, state) {
          final list = state.comments ?? [];
          return SliverList.builder(
            itemCount: [...list, ...list, ...list].length,
            itemBuilder: (_, i) {
              final item = [...list, ...list, ...list][i];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: 16,
                      backgroundImage: CachedNetworkImageProvider(urlAvatar),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: colorGrey.shade200,
                                borderRadius: BorderRadius.circular(12.0)),
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.nameAuthor,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(item.content),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                item.createdAt,
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
