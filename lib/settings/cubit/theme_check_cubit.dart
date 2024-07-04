import 'package:chat_app/common/theme/my_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCheckCubit extends Cubit<ThemeData> {
  ThemeCheckCubit() : super(lightMode);

  toggleTheme() {
    switch (state.brightness) {
      case Brightness.light:
        emit(darkMode);
        break;
      case Brightness.dark:
        emit(lightMode);
        break;
      default:
        emit(lightMode);
        break;
    }
  }
}
