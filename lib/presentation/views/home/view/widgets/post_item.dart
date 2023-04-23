import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:friendzone/common/extentions/size_extention.dart';
import 'package:friendzone/data/models/post.dart';
import 'package:friendzone/presentation/themes/color.dart';
import 'package:friendzone/presentation/views/profile/view/widgets/header_profile.dart';
import 'package:ionicons/ionicons.dart';

class PostItem extends StatelessWidget {
  final Post item;
  const PostItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = SizeEx(context).screenSize;
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
                          item.avartarAuthor ?? urlAvatar),
                    ),
                    Expanded(
                      child: ListTile(
                        contentPadding: const EdgeInsets.only(left: 5),
                        title: Text(
                          item.author,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(item.createdAt),
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
                  item.content,
                ),
              ),
              Container(
                width: size.width,
                height: size.width / 1.5,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                        image: CachedNetworkImageProvider(item.imageUrl),
                        fit: BoxFit.cover)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Row(
                        children: [
                          Icon(
                            Ionicons.heart_outline,
                            color: colorBlue.shade400,
                          ),
                          Text(item.like)
                        ],
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: Row(
                        children: [
                          Icon(
                            Ionicons.chatbubble_ellipses_outline,
                            color: colorBlue.shade400,
                          ),
                          const Text('12 comments')
                        ],
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: Row(
                        children: [
                          Icon(
                            Ionicons.arrow_redo_outline,
                            color: colorBlue.shade400,
                          ),
                          const Text('4 shared')
                        ],
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
