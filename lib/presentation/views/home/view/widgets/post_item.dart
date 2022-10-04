import 'package:flutter/material.dart';
import 'package:friendzone/common/extentions/size_extention.dart';
import 'package:friendzone/presentation/themes/color.dart';
import 'package:ionicons/ionicons.dart';

class PostItem extends StatelessWidget {
  final String item;
  const PostItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = BuildContextX(context).screenSize;
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
                      backgroundImage: NetworkImage(item),
                    ),
                    const Expanded(
                      child: ListTile(
                        contentPadding: EdgeInsets.only(left: 5),
                        title: Text(
                          'UserName',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text('19-10-2022'),
                      ),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Ionicons.ellipsis_horizontal)),
                  ],
                ),
              ),
              Container(
                width: size.width,
                height: size.width / 1.5,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                        image: NetworkImage(item), fit: BoxFit.cover)),
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
                          const Text('124')
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
