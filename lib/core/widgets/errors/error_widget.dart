import 'package:flutter/material.dart';
import 'package:habit_go/core/utils/extensions.dart';
import 'package:habit_go/core/values/files.dart';
import 'package:habit_go/core/widgets/buttons/link_button.dart';
import 'package:lottie/lottie.dart';

class CustomErrorWidget extends StatelessWidget {
  final VoidCallback onTryAgain;

  const CustomErrorWidget({
    required this.onTryAgain,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 92,
            child: Lottie.asset(
              Files.errorAnimation,
              filterQuality: FilterQuality.high,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Ops, there was a problem',
            style: context.text.bodyLarge,
          ),
          const SizedBox(height: 10),
          Text(
            'It was not possible to complete the operation.\n'
            'Please, try again.',
            style: context.text.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          LinkButton(
            text: 'Try again',
            onTap: onTryAgain,
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
