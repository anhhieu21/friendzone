import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/src/config.dart';
import 'package:friendzone/src/domain/models/user_model.dart';
import 'package:friendzone/src/presentation/shared.dart';
import 'package:friendzone/src/presentation/state/friend_zone/friendzone_bloc.dart';
import 'package:friendzone/src/presentation/widgets/item_friend.dart';
import 'package:go_router/go_router.dart';

class NewConversationScreen extends StatelessWidget {
  NewConversationScreen({super.key});
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('New conversation'),
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextFormField(
                autofocus: true,
                controller: _searchController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(right: 8.0),
                  filled: true,
                  hintText: 'searching',
                  fillColor: colorWhite,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(16.0)),
                  prefixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text(
                          'To:',
                          style: theme.textTheme.bodyLarge!
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Sugget',
            style: theme.textTheme.bodyLarge!
                .copyWith(fontWeight: FontWeight.w600),
          ),
          Expanded(
            child:
                BlocSelector<FriendzoneBloc, FriendzoneState, List<UserModel>>(
              selector: (state) {
                if (state is MyFriendState) {
                  return state.list;
                }
                return [];
              },
              builder: (context, friends) => ListView.builder(
                  itemCount: friends.length,
                  itemBuilder: (_, i) {
                    final item = friends[i];
                    return OnTapEffect(
                      onTap: () => context.pushNamed(
                          RoutePath.routeName(RoutePath.conversentation),
                          extra: item),
                      radius: 16.0,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: ItemFriend(user: item),
                      ),
                    );
                  }),
            ),
          ),
        ]),
      ),
    );
  }
}
