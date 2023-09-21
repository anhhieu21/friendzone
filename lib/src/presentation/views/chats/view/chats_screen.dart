import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/src/config/themes/color.dart';
import 'package:friendzone/src/domain/models/user_model.dart';
import 'package:friendzone/src/presentation/state.dart';
import 'package:friendzone/src/presentation/view.dart';
import 'package:friendzone/src/presentation/widgets/item_friend.dart';
import 'package:friendzone/src/utils.dart';

import 'package:ionicons/ionicons.dart';

enum MenuChat {
  chat(label: 'Chat', icon: Ionicons.chatbubbles),
  privateChat(label: 'Private chat', icon: Ionicons.shield),
  archiveChat(label: 'Archive chat', icon: Ionicons.folder_open),
  waitingChat(label: 'Waiting chat', icon: Ionicons.chatbubble_ellipses);

  final String label;
  final IconData icon;

  const MenuChat({required this.label, required this.icon});
}

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  @override
  void initState() {
    BlocProvider.of<FriendzoneBloc>(context, listen: false)
        .add(MyFriendEvent());
    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openEndDrawer() {
    _scaffoldKey.currentState!.openEndDrawer();
  }

  void _closeEndDrawer() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final size = SizeEx(context).screenSize;
    final theme = Theme.of(context);
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (_, state) {
        return Scaffold(
          key: _scaffoldKey,
          endDrawer: Drawer(
            child: Container(
              color: theme.scaffoldBackgroundColor,
              padding: const EdgeInsets.fromLTRB(9.0, kToolbarHeight, 8.0, 0),
              child: Column(
                children: MenuChat.values
                    .map(
                      (e) => ItemMenuChat(
                        iconData: e.icon,
                        label: e.label,
                        callback: () {},
                        isSelect: e == MenuChat.chat,
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          appBar: AppBar(
            title: Text(text.chat),
            actions: [
              IconButton(
                  onPressed: _openEndDrawer,
                  icon: const Icon(Ionicons.reorder_three))
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Ionicons.pencil),
                      style: IconButton.styleFrom(backgroundColor: colorWhite),
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
                                      onTap: () =>
                                          controller.closeView(item.name),
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
          ),
          body: state is ListConversationState
              ? ListView.builder(
                  itemCount: state.listConversation.length,
                  itemBuilder: (context, index) {
                    return ItemChat(
                        size: size, item: state.listConversation[index]);
                  })
              : const SizedBox(),
        );
      },
    );
  }
}

class ItemMenuChat extends StatelessWidget {
  final IconData iconData;
  final String label;
  final VoidCallback callback;
  final bool isSelect;
  const ItemMenuChat(
      {super.key,
      required this.iconData,
      required this.label,
      required this.callback,
      this.isSelect = false});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(16.0)),
          child: Row(
            children: [
              Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      color: colorGrey.shade100,
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Icon(iconData)),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(label),
              ))
            ],
          ),
        ),
        if (isSelect)
          Positioned(
            left: 0,
            child: Container(
              height: 30,
              width: 6,
              decoration: const BoxDecoration(
                  color: colorPrimary,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12.0),
                    bottomRight: Radius.circular(12.0),
                  )),
            ),
          ),
      ],
    );
  }
}
