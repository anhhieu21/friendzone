import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/src/config.dart';
import 'package:friendzone/src/domain/models/user_model.dart';
import 'package:friendzone/src/presentation/state.dart';
import 'package:friendzone/src/presentation/widgets/item_friend.dart';
import 'package:friendzone/src/utils.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';

import 'item_list_conversation.dart';

class MainChat extends StatelessWidget {
  const MainChat({super.key});
  _newConversaation(BuildContext context) {
    context.pushNamed(RoutePath.routeName(RoutePath.newConversation));
  }

  @override
  Widget build(BuildContext context) {
    final size = context.screenSize;
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (_, state) => Column(children: [
        PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => _newConversaation(context),
                  icon: const Icon(Ionicons.pencil),
                ),
                Expanded(
                  child: BlocSelector<FriendzoneBloc, FriendzoneState,
                      List<UserModel>>(
                    selector: (state) {
                      if (state is MyFriendState) {
                        return state.list;
                      }
                      return [];
                    },
                    builder: (context, friends) {
                      return SizedBox(
                        height: 40,
                        child: SearchAnchor(
                            viewElevation: 0,
                            viewHintText: 'Searching',
                            builder: (_, controller) {
                              return SearchBar(
                                controller: controller,
                                hintText: 'Searching',
                                leading: const Icon(Ionicons.search),
                                onChanged: (_) {
                                  controller.openView();
                                },
                                onTap: () {
                                  controller.openView();
                                },
                                onSubmitted: (value) {
                                  print(value);
                                },
                              );
                            },
                            suggestionsBuilder: ((_, controller) {
                              return List<ListTile>.generate(friends.length,
                                  (int index) {
                                final item = friends[index];
                                return ListTile(
                                  title: ItemFriend(user: item),
                                  onTap: () => controller.closeView(item.name),
                                );
                              });
                            })),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        state is ListConversationState
            ? Expanded(
                child: ListView.builder(
                    itemCount: state.listConversation.length,
                    itemBuilder: (context, index) {
                      return ItemListConversation(
                          size: size, item: state.listConversation[index]);
                    }),
              )
            : const SizedBox()
      ]),
    );
  }
}
