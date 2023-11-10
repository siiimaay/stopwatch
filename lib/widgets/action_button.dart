import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final String buttonText;
  final Function()? onPressed;
  final Widget? suffixIcon;
  final EdgeInsetsGeometry? padding;
  final Color? borderColor;
  final Size? buttonSize;
  final Color? textColor;
  final Gradient? gradient;

  const ActionButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.suffixIcon,
    this.padding,
    this.borderColor,
    this.buttonSize,
    this.textColor,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.0),
        gradient: gradient,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shadowColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            minimumSize: buttonSize ?? const Size(150, 45),
            side: BorderSide(
                color: borderColor ?? Colors.transparent, width: 0.5)),
        onPressed: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(
              fit: FlexFit.loose,
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(buttonText,
                    style: TextStyle(
                      color: textColor ?? Colors.black26,
                      fontSize: 16,
                    )),
              ),
            ),
            const SizedBox(width: 5),
            if (suffixIcon != null) suffixIcon!,
          ],
        ),
      ),
    );
  }
}
