import 'package:flutter/material.dart';
import 'package:friendzone/presentation/themes/color.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';

class DialogCustom {
  DialogCustom._dialogConstructor();
  static final DialogCustom _instance = DialogCustom._dialogConstructor();
  static DialogCustom get instance => _instance;

  showDialogDuration(
          {required BuildContext context,
          required String content,
          Duration? duration}) =>
      showDialog(
          context: context,
          barrierColor: Colors.transparent,
          builder: (_) {
            Future.delayed(
                duration ?? const Duration(seconds: 3), () => context.pop());
            return AlertDialog(
              backgroundColor:
                  const Color.fromARGB(255, 231, 231, 231).withOpacity(0.8),
              titleTextStyle: Theme.of(context).textTheme.bodyMedium,
              titlePadding: const EdgeInsets.symmetric(vertical: 10.0),
              title: Text(content, textAlign: TextAlign.center),
            );
          });

  showDialogCustom(
    BuildContext context,
    String title,
    String content,
    String labelBtn,
    Function()? onPress1,
    Function()? onPress2,
  ) async {
    return showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            titleTextStyle: const TextStyle(
                fontWeight: FontWeight.w600, color: colorBlack, fontSize: 16),
            title: Text(
              title,
              textAlign: TextAlign.center,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(content),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    if (onPress1 != null)
                      CustomButton(
                        onPress: onPress1,
                        icon: const Icon(Ionicons.reload),
                        label: 'Gửi lại',
                      ),
                    if (onPress2 != null)
                      CustomButton(
                        onPress: onPress2,
                        icon: const Icon(Ionicons.arrow_forward_circle_outline),
                        label: labelBtn,
                      )
                  ],
                )
              ],
            ),
          );
        });
  }

  showLoading(BuildContext context, bool isShow) {
    return !isShow
        ? Navigator.pop(context)
        : showDialog(
            context: context,
            builder: (_) => Dialog(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(
                          color: colorPinkButton.shade400,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        const Text(
                          'Vui lòng đợi !',
                        )
                      ],
                    ),
                  ),
                ));
  }
}

class CustomButton extends StatelessWidget {
  final Icon icon;
  final String label;
  final Function() onPress;
  const CustomButton(
      {super.key,
      required this.icon,
      required this.label,
      required this.onPress});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPress,
      style:
          ElevatedButton.styleFrom(backgroundColor: colorPinkButton.shade300),
      icon: icon,
      label: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }
}
