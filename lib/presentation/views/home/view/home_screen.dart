import 'package:flutter/material.dart';
import 'package:friendzone/common/constants/list_img_fake.dart';
import 'package:friendzone/common/extentions/size_extention.dart';
import 'package:friendzone/presentation/themes/color.dart';
import 'package:friendzone/presentation/views/home/view/widgets/app_bar.dart';
import 'package:friendzone/presentation/views/home/view/widgets/list_post.dart';

const urlImg =
    'https://images.unsplash.com/photo-1664574654700-75f1c1fad74e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = BuildContextX(context).screenSize;
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10),
                height: size.width / 2.5,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: listPost.length,
                    itemBuilder: (context, index) {
                      final item = listPost[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Container(
                            width: size.width / 4,
                            margin: const EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                                border: Border.all(width: 2, color: colorWhite),
                                borderRadius: BorderRadius.circular(25)),
                            child: Container(
                              margin: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                      image: NetworkImage(item),
                                      fit: BoxFit.cover)),
                            )),
                      );
                    }),
              ),
              const ListPost(),
            ],
          ),
        ),
      ),
    );
  }
}
