import 'package:flutter/material.dart';
import 'package:friendzone/common/constants/list_img_fake.dart';
import 'package:friendzone/common/extentions/size_extention.dart';
import 'package:friendzone/presentation/views/profile/view/widgets/header_profile.dart';

import 'package:friendzone/presentation/views/profile/view/widgets/item_post.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

const kMaxCrossAxisExtent = 350.0;

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final size = BuildContextX(context).screenSize;
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderProfile(size: size),
            const Padding(
              padding: EdgeInsets.only(top: 10, bottom: 5),
              child: Text('All Post',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            ),
            Expanded(
              child: MasonryGridView.extent(
                  maxCrossAxisExtent: kMaxCrossAxisExtent,
                  itemCount: listPost.length,
                  shrinkWrap: true,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  itemBuilder: (context, index) {
                    final item = listPost[index];
                    return ItemPost(size: size, item: item);
                  }),
            )
            // ElevatedButton(
            //     onPressed: () => GoRouter.of(context).go(RoutePath.signin),
            //     style: ElevatedButton.styleFrom(
            //         elevation: 0,
            //         backgroundColor: colorPinkButton.shade400,
            //         shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(12))),
            //     child: const Text(
            //       'Login',
            //       style: TextStyle(color: colorWhite),
            //     ))
          ],
        ),
      ),
    ));
  }
}
