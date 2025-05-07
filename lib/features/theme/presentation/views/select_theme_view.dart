import 'package:e_learning/core/cache_helper/cache_helper.dart';
import 'package:e_learning/core/utils/app_styles.dart';
import 'package:e_learning/features/theme/presentation/manager/theme_cubit.dart';
import 'package:e_learning/features/theme/presentation/manager/theme_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class SelectThemeView extends StatelessWidget {
  const SelectThemeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'mode'.tr,
          style: AppStyles.style17,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<ThemeCubit, ThemeStates>(
              builder: (context, state) {
                return SwitchListTile(
                  title: Text(
                    'dark_mode'.tr,
                    style: AppStyles.style17,
                  ),
                  value: context
                      .read<ThemeCubit>()
                      .checkValue ?? CacheHelper.isDarkMode,
                  onChanged: (value) {
                    context.read<ThemeCubit>().changeTheme(value);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
