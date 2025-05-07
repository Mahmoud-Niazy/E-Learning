import 'package:e_learning/core/cache_helper/cache_helper.dart';
import 'package:e_learning/core/utils/app_keys.dart';
import 'package:e_learning/features/theme/presentation/manager/theme_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeStates>{
  ThemeCubit() : super(ThemeInitialState());

  bool? checkValue;

  Future<void> changeTheme(bool isDark)async{
    emit(ThemeLoadingState());
    checkValue = isDark;
   await CacheHelper.saveData(key: AppKeys.isDarkMode, value: isDark);
    emit(ChangeThemeState());
  }
}