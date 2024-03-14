import 'package:flutter/material.dart';
import 'package:friendzone/src/config.dart';
import 'package:friendzone/src/domain.dart';
import 'package:friendzone/src/presentation/widgets/ontap_effect.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter_slidable/flutter_slidable.dart';

class ItemListConversation extends StatelessWidget {
  final Size size;
  final Conversation item;
  const ItemListConversation(
      {super.key, required this.size, required this.item});
  _onTap(BuildContext context) {
    context.pushNamed(RoutePath.routeName(RoutePath.conversentation),
        extra: item.user);
  }

  @override
  Widget build(BuildContext context) {
    return OnTapEffect(
      radius: 0,
      onTap: () => _onTap(context),
      child: Slidable(
        endActionPane: ActionPane(motion: const ScrollMotion(), children: [
          SlidableAction(
            onPressed: (_) {},
            icon: Ionicons.archive,
            label: 'Archive',
          ),
          SlidableAction(
            onPressed: (_) {},
            icon: Ionicons.shield,
            label: 'Private',
          )
        ]),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            // TODO: add avartar
            Image.network(
              item.user!.avartar,
              // imageBuilder: (context, imageProvider) => CircleAvatar(
              //   backgroundImage: imageProvider,
              //   radius: size.width / 14,
              // ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.user!.name,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(item.message.message),
                ],
              ),
            ),
            Text(
              timeago.format(item.message.createdAt),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ]),
        ),
      ),
    );
  }
}
