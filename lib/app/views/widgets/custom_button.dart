import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shield/app/utils/text_styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.title,
    Key? key,
    this.onPressed,
    this.kwidth,
    this.kheight,
  }) : super(key: key);

  final void Function()? onPressed;
  final String title;
  final double? kwidth;
  final double? kheight;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: kwidth ?? (MediaQuery.of(context).size.width - 60) * 0.5,
      height: kheight ?? 45,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: onPressed ??
            () => Get.snackbar('Hi', 'You have Pressed $title button'),
        child: Card(
          elevation: 5,
          color: const Color(0xff1b1b1b),
          child: Center(
            child: Text(title, style: kButtonTextStyle()),
          ),
        ),
      ),
    );
  }
}
