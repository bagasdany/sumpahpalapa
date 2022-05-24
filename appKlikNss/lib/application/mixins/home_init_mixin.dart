import 'package:mobileapps/application/app/enums/loading_state.dart';
import 'package:stacked/stacked.dart';

mixin HomeInitMixin on ReactiveViewModel {
  LoadingState loadingState = LoadingState.loading;
}
