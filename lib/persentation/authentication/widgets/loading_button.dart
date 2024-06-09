import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingButton extends StatelessWidget {
  const LoadingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.purple.shade400,
        ),
        child: Lottie.asset(
          "assets/buttonLoading.json",
          height: 60,
        ),
      ),
    );
  }
}
