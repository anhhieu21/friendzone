import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';

class CreateReelScreen extends StatefulWidget {
  const CreateReelScreen({super.key});

  @override
  State<CreateReelScreen> createState() => _CreateReelScreenState();
}

class _CreateReelScreenState extends State<CreateReelScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => context.pop(), icon: const Icon(Ionicons.close)),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: kToolbarHeight),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _boxElement(Ionicons.camera_outline, 'Camera'),
            _boxElement(Ionicons.image_outline, 'Gallery'),
          ],
        ),
      ),
    );
  }

  Widget _boxElement(IconData iconData, String label) => Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                blurRadius: 2,
                spreadRadius: 1,
              ),
              BoxShadow(
                blurRadius: 5,
                offset: Offset(0, 2),
                spreadRadius: 2,
              )
            ]),
        child: Row(
          children: [
            Icon(
              iconData,
              size: 40,
            ),
            const SizedBox(width: 8.0),
            Expanded(
                child: Text(
              label,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ))
          ],
        ),
      );
}
