import 'package:bloc/bloc.dart';

class HeaderModeCubit extends Cubit<HeaderMode> {
  HeaderModeCubit() : super(HeaderMode.dropdown);

  void changeMode(HeaderMode mode) {
    emit(mode);
  }
  
}

enum HeaderMode { dropdown, input }
