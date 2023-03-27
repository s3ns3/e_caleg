
import 'package:flutter_bloc/flutter_bloc.dart';

class RefreshScreenCubit extends Cubit<bool> {
  RefreshScreenCubit(): super(false);

  void refreshScreen() {
    emit(!state);
  }
}