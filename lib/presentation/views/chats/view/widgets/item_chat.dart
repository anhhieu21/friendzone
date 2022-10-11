import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ItemChat extends StatelessWidget {
  final Size size;
  final String item;
  const ItemChat({super.key, required this.size, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        CachedNetworkImage(
          imageUrl: item,
          imageBuilder: (context, imageProvider) => CircleAvatar(
            backgroundImage: imageProvider,
            radius: size.width / 14,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Name your friend',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Text('tin nhắn gần đây'),
            ],
          ),
        ),
        const Text(
          '10p trước',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        ),
      ]),
    );
  }
}
