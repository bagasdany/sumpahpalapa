import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mobileapps/application/app/contants/custom_color.dart';
import 'package:mobileapps/application/app/contants/icon_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DialogLoading extends StatelessWidget {
  final bool isLoading;
  final Widget child;
  final String? label;

  const DialogLoading(
      {Key? key, required this.isLoading, required this.child, this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!isLoading) return child;

    return Stack(
      children: [
        child,
        const Opacity(
          opacity: 0.6,
          child: ModalBarrier(
            dismissible: false,
            color: Colors.black,
          ),
        ),
        Center(
          child: Container(
            width: 118.w,
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
            decoration: BoxDecoration(
              color: CustomColor.primaryWhiteColor,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  constraints: BoxConstraints(
                      minHeight: 100.h,
                      maxHeight: 100.h,
                      maxWidth: 100.w,
                      minWidth: 100.w),
                  child: Lottie.asset(IconConstants.loaderIcon,
                      width: 200.w, height: 200.h),
                ),
                SizedBox(height: 8.h),
                Text(
                  label ?? 'Mohon tunggu, ya..',
                  style: Theme.of(context).textTheme.caption?.copyWith(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w400,
                      ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
