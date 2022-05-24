import 'package:flutter/material.dart';
import 'package:mobileapps/application/app/contants/custom_color.dart';

class CustomTextButton extends StatelessWidget {
  final String label;
  final Color? labelColor;
  final Function? onPressed;
  final bool? isBusy;
  final Color? color;
  final Color? disabledColor;
  final double? height;
  final TextStyle? textStyle;

  const CustomTextButton(
      {required this.label,
      this.labelColor,
      this.height,
      required this.onPressed,
      this.isBusy = false,
      this.color,
      this.textStyle,
      this.disabledColor,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.06,
      width: MediaQuery.of(context).size.width * 0.5,
      // width: double.infinity,
      child: TextButton(
        onPressed: onPressed != null ? () => onPressed!() : null,
        style: ButtonStyle(
          padding: MaterialStateProperty.resolveWith(
            (states) => const EdgeInsets.symmetric(horizontal: 14),
          ),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return disabledColor ?? CustomColor.primaryRedColor;
              }

              return color ?? Theme.of(context).primaryColor;
            },
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        child: isBusy!
            ? const Text('Sedang Memuat')
            : Text(
                label,
                style: textStyle ??
                    Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: labelColor ?? CustomColor.primaryWhiteColor),
              ),
      ),
    );
  }
}
