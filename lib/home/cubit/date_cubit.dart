import 'package:flutter_bloc/flutter_bloc.dart';

class DateCubit extends Cubit<DateTime> {
  DateCubit() : super(DateTime.now());

  void dateChanged(DateTime newDate) => emit(newDate);
}
