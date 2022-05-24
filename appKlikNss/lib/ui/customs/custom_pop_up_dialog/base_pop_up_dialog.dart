import 'package:flutter/material.dart';
import 'package:mobileapps/application/app/contants/custom_color.dart';
import 'package:mobileapps/ui/shared/custom_text_button.dart';
import 'package:stacked_services/stacked_services.dart';

class BasePopUpDialog extends StatelessWidget {
  final DialogRequest? request;
  final Function(DialogResponse)? completer;
  final String? title;
  final String? description;

  const BasePopUpDialog(
      {Key? key, this.request, this.completer, this.title, this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: contentBox(context),
    );
  }

  Widget contentBox(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.24,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            request!.title!,
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
          ),
          const SizedBox(height: 10),
          Text(request!.description!),
          const SizedBox(height: 10),
          CustomTextButton(
            color: CustomColor.primaryRedColor,
            label: request!.mainButtonTitle!,
            onPressed: () => completer!(
              DialogResponse(confirmed: true),
            ),
          )
          ///// mayans oi oi oi
        ],
      ),
    );
  }
}
