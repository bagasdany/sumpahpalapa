import 'package:flutter/cupertino.dart';

class OnBoardingModel {
  final String? imagePath;
  final String? title;
  final String? description;
  final String? image;
  final Color? primaryColor;
  final Color? color;
  final Color? secondaryColor;
  final String? type;
  final TextAlign position;
  final double right;
  final double left;
  final double sizeh;
  final double sizew;
  final double right2;
  final double left2;
  final double right3;
  final double left3;

  OnBoardingModel(
      {this.imagePath,
      this.title,
      this.description,
      this.image,
      this.color,
      this.primaryColor,
      this.secondaryColor,
      this.type,
      required this.right,
      required this.left,
      required this.sizeh,
      required this.sizew,
      required this.right2,
      required this.left2,
      required this.right3,
      required this.left3,
      required this.position});
}
