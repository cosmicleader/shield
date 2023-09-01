import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shield/app/utils/text_styles.dart';
import 'package:shield/app/views/themes/colours.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.title,
    Key? key,
    this.onPressed,
    this.kwidth,
    this.kheight,
    this.color,
  }) : super(key: key);

  final void Function()? onPressed;
  final Color? color;
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
          color: color ?? kBlack,
          child: Center(
            child: Text(title,
                style: kButtonTextStyle()
                    .copyWith(color: color == kWhite ? kBlack : kWhite)),
          ),
        ),
      ),
    );
  }
}
