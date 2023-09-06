import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/src/config.dart';
import 'package:friendzone/src/domain.dart';
import 'package:friendzone/src/presentation/state.dart';
import 'package:friendzone/src/presentation/widgets/ontap_effect.dart';
import 'package:friendzone/src/utils.dart';
import 'package:go_router/go_router.dart';
import 'package:timeago/timeago.dart' as timeago;

class ItemChat extends StatelessWidget {
  final Size size;
  final Conversation item;
  const ItemChat({super.key, required this.size, required this.item});
  _onTap(BuildContext context) {
    context.read<UserPreviewCubit>().loadInitialData(item.id).then((value) =>
        context.pushNamed(Formatter.nameRoute(RoutePath.conversentation),
            extra: value));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: OnTapEffect(
        radius: 16,
        onTap: () => _onTap(context),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          CachedNetworkImage(
            imageUrl: item.image,
            imageBuilder: (context, imageProvider) => CircleAvatar(
              backgroundImage: imageProvider,
              radius: size.width / 14,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.receiver,
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
    );
  }
}
