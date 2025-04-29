import 'package:e_learning/core/methods/navigation.dart';
import 'package:e_learning/core/methods/show_snack_bar.dart';
import 'package:e_learning/core/utils/app_constance.dart';
import 'package:e_learning/core/utils/app_dimensions.dart';
import 'package:e_learning/core/utils/app_styles.dart';
import 'package:e_learning/core/widgets/custom_button.dart';
import 'package:e_learning/core/widgets/custom_circular_progress_indicator.dart';
import 'package:e_learning/core/widgets/custom_text_form_field.dart';
import 'package:e_learning/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:e_learning/features/auth/presentation/manager/auth_cubit/auth_states.dart';
import 'package:e_learning/features/auth/presentation/views/reset_password_view.dart';
import 'package:e_learning/features/auth/presentation/views/widgets/app_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../core/cache_helper/cache_helper.dart';
import '../../../../core/methods/translate.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  static var emailController = TextEditingController();
  static var formKey = GlobalKey<FormState>();

  Future<void> validate(BuildContext context) async {
    if(formKey.currentState!.validate()){
      await context.read<AuthCubit>().sendPasswordResetCode(emailController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Stack(
            children: [
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppLogo(),
                    SizedBox(
                      height: AppDimensions.screenHeight * .1,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${'please_enter_your'.tr} ${'email'.tr}',
                          style: AppStyles.style17,
                        ),
                        SizedBox(
                          height: AppDimensions.screenHeight * .05,
                        ),
                        CustomTextFormField(
                          pIcon: Icons.email_outlined,
                          title: 'email'.tr,
                          controller: emailController,
                        ),
                        SizedBox(
                          height: AppDimensions.screenHeight * .02,
                        ),
                        Text(
                          'we_will_send_you_a_code'.tr,
                          style:
                              AppStyles.style13.copyWith(color: Colors.black26),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              BlocConsumer<AuthCubit, AuthStates>(
                listener: (context, state) async{
                  if (state is SendPasswordResetCodeSuccessfullyState) {
                    showSnackBar(
                      context: context,
                      label: 'check_your_email'.tr,
                      color: AppConstance.primaryColor,
                    );
                    navigateAndRemoveUntil(context: context, screen: ResetPasswordView(email: state.email,));
                  }
                  if(state is SendPasswordResetCodeErrorState){
                    showSnackBar(
                      context: context,
                      label: CacheHelper.isAr != false ? await translateEnglishToArabic(state.error) : state.error,
                      color: Colors.red,
                    );
                  }
                },
                builder: (context, state) {
                  if(state is SendPasswordResetCodeLoadingState){
                    return CustomCircularProgressIndicator();
                  }
                  return Positioned(
                    bottom: AppDimensions.screenHeight * .03,
                    right: 0,
                    left: 0,
                    child: CustomButton(
                      backgroundColor: AppConstance.primaryColor,
                      title: 'confirm'.tr,
                      onPressed: () async {
                        await validate(context);
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
