import 'package:mobileapps/application/app/app.locator.dart';
import 'package:mobileapps/application/app/enums/pop_up_dialog_type.dart';
import 'package:mobileapps/ui/customs/custom_pop_up_dialog/base_pop_up_dialog.dart';
import 'package:stacked_services/stacked_services.dart';

void setupPopUpDialogUi() {
  final popUpDialogService = locator<DialogService>();

  final builders = {
    PopUpDialogType.base: (context, sheetRequest, completer) => BasePopUpDialog(
          request: sheetRequest as DialogRequest,
          completer: completer as Function(DialogResponse),
        )
  };
  //pusing pala pusing palapa brodinnn shodiq oke mantap sekali oi oi oi
  popUpDialogService.registerCustomDialogBuilders(builders);
}
