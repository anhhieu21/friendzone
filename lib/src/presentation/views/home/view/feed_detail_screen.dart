import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/src/domain/models/feed.dart';
import 'package:friendzone/src/presentation/state.dart';
import 'package:friendzone/src/presentation/widgets/custom_textfield.dart';
import 'package:friendzone/src/core/utils/formatter.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';

class FeedDetailScreen extends StatefulWidget {
  final int? currentPage;
  const FeedDetailScreen({super.key, this.currentPage});

  @override
  State<FeedDetailScreen> createState() => _FeedDetailScreenState();
}

class _FeedDetailScreenState extends State<FeedDetailScreen> {
  PageController _pageController = PageController();
  @override
  void initState() {
    if (widget.currentPage != null) {
      _pageController = PageController(initialPage: widget.currentPage!);
    }
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeedCubit, FeedState>(buildWhen: (previous, current) {
      if (current is FeedLoaded) {
        return true;
      }
      return false;
    }, builder: (context, state) {
      if (state is FeedLoaded) {
        return PageView.builder(
            controller: _pageController,
            itemCount: state.listFeed.length,
            itemBuilder: (_, index) {
              final item = state.listFeed[index];
              return ItemPage(item: item);
            });
      }
      return const SizedBox();
    });
  }
}

class ItemPage extends StatelessWidget {
  final Feed item;
  const ItemPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(mainAxisSize: MainAxisSize.min, children: [
          CircleAvatar(
            radius: 24,
            backgroundImage: NetworkImage(item.avartarAuthor),
          ),
          Expanded(
            child: ListTile(
              contentPadding: const EdgeInsets.only(left: 5),
              title: Text(
                item.author,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Text(Formatter.timeAgo(item.createdAt)),
            ),
          ),
        ]),
        actions: [
          IconButton(
              onPressed: () => context.pop(), icon: const Icon(Ionicons.close))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Image.network(
              item.imagesUrl.first,
            ),
          ),
          _bottomAction(context),
        ],
      ),
    );
  }

  Widget _bottomAction(context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 8, 16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Expanded(child: CustomTextField(hint: 'hint', error: 'error')),
          IconButton(onPressed: () {}, icon: const Icon(Ionicons.send))
        ],
      ),
    );
  }
}
