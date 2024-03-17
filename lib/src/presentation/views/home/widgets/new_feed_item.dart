import 'package:flutter/material.dart';
import 'package:friendzone/src/config.dart';
import 'package:friendzone/src/core/utils/constants/gap.dart';
import 'package:friendzone/src/domain.dart';
import 'package:friendzone/src/presentation/widgets/image_view.dart';
import 'package:friendzone/src/utils.dart';

import 'package:go_router/go_router.dart';

import '../../../widgets/ontap_effect.dart';

class ItemNewFeed extends StatelessWidget {
  final Feed item;
  final int index;
  const ItemNewFeed({
    super.key,
    required this.item,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Gap.xs),
      child: SizedBox(
        width: context.screenSize.width / 4,
        child: Card(
          child: Stack(
            children: [
              OnTapEffect(
                onTap: () => context.pushNamed(
                    RoutePath.routeName(RoutePath.detailFeed),
                    extra: index),
                radius: 20,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: kBorderRadius,
                    image: item.imagesUrl.isNotEmpty
                        ? DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              item.imagesUrl.first,
                            ),
                          )
                        : null,
                  ),
                ),
              ),
              Positioned(
                  top: 6,
                  left: 6,
                  child: CircleAvatar(
                    radius: 20,
                    child: CircleAvatar(
                      radius: 18,
                      backgroundImage: NetworkImage(item.avartarAuthor),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class ItemAddFeed extends StatelessWidget {
  const ItemAddFeed({super.key});

  @override
  Widget build(BuildContext context) {
    final size = context.screenSize;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Gap.xs),
      child: Row(
        children: [
          SizedBox(
            width: size.width / 4,
            child: Card(
              child: Column(
                children: [
                  Expanded(
                    flex: 7,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        const Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          bottom: kIconBtnSize,
                          child: ImageViewNetwork(
                            src: urlAvatar,
                            borderRadius: kBorderRadiusOnTop,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: IconButton.filledTonal(
                            onPressed: () => context.pushNamed(
                              RoutePath.routeName(RoutePath.upFeed),
                            ),
                            icon: const Icon(Icons.add),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: Text(
                      'Create\nstory',
                      textAlign: TextAlign.center,
                      style: context.theme.textTheme.titleSmall,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
