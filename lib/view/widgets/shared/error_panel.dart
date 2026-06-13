import 'package:dimos_cats/view/widgets/shared/app_logo.dart';
import 'package:flutter/material.dart';

class ErrorPanel extends StatelessWidget {
  const ErrorPanel({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(10),
      // height: 50,
      // width: MediaQuery.of(context).size.width / 2,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.error,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppLogo(color: Theme.of(context).colorScheme.onError),
          const SizedBox(width: 5),
          Flexible(
            child: Text(
              textAlign: TextAlign.center,
              message,
              maxLines: 3,
              style: TextStyle(color: Theme.of(context).colorScheme.onError),
            ),
          ),
        ],
      ),
    );
  }
}
