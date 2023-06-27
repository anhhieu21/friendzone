import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/presentation/themes/color.dart';
import 'package:friendzone/state/profile/user/user_cubit.dart';

class ListFollower extends StatelessWidget {
  const ListFollower({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserPreviewCubit, UserpreviewState>(
      buildWhen: (previous, current) {
        if (current is ListFollowerState) {
          return true;
        }
        return false;
      },
      builder: (context, state) {
        if (state is ListFollowerState) {
          return ListView.builder(
              itemCount: state.listFollower.length,
              itemBuilder: (ctx, i) {
                final item = state.listFollower[i];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(item.avatar),
                      ),
                      const SizedBox(width: 8),
                      Expanded(child: Text(item.name)),
                      TextButton(
                          onPressed: () {},
                          style:
                              TextButton.styleFrom(backgroundColor: colorWhite),
                          child: const Text('Theo dõi'))
                    ],
                  ),
                );
              });
        }
        return const SizedBox();
      },
    );
  }
}
