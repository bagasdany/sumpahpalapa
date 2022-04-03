import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SwitchButton extends StatefulWidget {
  final bool? value;
  final ValueChanged<bool>? onChanged;
  final String? activeText;
  final String? inactiveText;

  const SwitchButton(
      {Key? key,
      this.value,
      this.onChanged,
      this.activeText,
      this.inactiveText})
      : super(key: key);

  @override
  SwitchButtonState createState() => SwitchButtonState();
}

class SwitchButtonState extends State<SwitchButton>
    with SingleTickerProviderStateMixin {
  Animation? _circleAnimation;
  AnimationController? _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 60));
    _circleAnimation = AlignmentTween(
            begin: widget.value! ? Alignment.centerRight : Alignment.centerLeft,
            end: widget.value! ? Alignment.centerLeft : Alignment.centerRight)
        .animate(CurvedAnimation(
            parent: _animationController!, curve: Curves.linear));
  }

  @override
  Widget build(BuildContext context) {
    var appBarHeight = AppBar().preferredSize.height + 10;

    return AnimatedBuilder(
      animation: _animationController!,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            if (_animationController!.isCompleted) {
              _animationController!.reverse();
            } else {
              _animationController!.forward();
            }
            widget.value == false
                ? widget.onChanged!(true)
                : widget.onChanged!(false);
          },
          child: Container(
            width: 100,
            height: appBarHeight - 30,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: _circleAnimation!.value == Alignment.centerRight
                    ? const Color.fromRGBO(69, 165, 36, 1)
                    : const Color.fromRGBO(222, 31, 54, 1)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                if (_circleAnimation!.value == Alignment.centerRight)
                  const SizedBox(
                    width: 0,
                  ),
                if (_circleAnimation!.value == Alignment.centerRight)
                  Text(
                    widget.activeText!,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.5,
                        fontSize: 12.sp),
                  ),
                Align(
                  alignment: _circleAnimation!.value,
                  child: Container(
                    width: appBarHeight - 46,
                    height: appBarHeight - 46,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(255, 255, 255, 1)),
                    child: Icon(
                      const IconData(0xf126, fontFamily: "MIcon"),
                      color: _circleAnimation!.value == Alignment.centerRight
                          ? const Color.fromRGBO(69, 165, 36, 1)
                          : const Color.fromRGBO(222, 31, 54, 1),
                      size: 16.sp,
                    ),
                  ),
                ),
                if (_circleAnimation!.value == Alignment.centerLeft)
                  Text(
                    widget.inactiveText!,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.5,
                        fontSize: 12.sp),
                  ),
                if (_circleAnimation!.value == Alignment.centerLeft)
                  const SizedBox(
                    width: 0,
                  )
              ],
            ),
          ),
        );
      },
    );
  }
}
