import 'package:e_learning/core/cache_helper/cache_helper.dart';
import 'package:e_learning/core/methods/navigation.dart';
import 'package:e_learning/core/methods/translate.dart';
import 'package:e_learning/core/utils/app_constance.dart';
import 'package:e_learning/core/utils/app_dimensions.dart';
import 'package:e_learning/core/utils/app_styles.dart';
import 'package:e_learning/core/widgets/custom_button.dart';
import 'package:e_learning/core/widgets/custom_text_form_field.dart';
import 'package:e_learning/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:e_learning/features/auth/presentation/views/forget_password_view.dart';
import 'package:e_learning/features/auth/presentation/views/register_view.dart';
import 'package:e_learning/features/auth/presentation/views/widgets/app_logo.dart';
import 'package:e_learning/features/auth/presentation/views/widgets/sign_with_google_icon.dart';
import 'package:e_learning/features/layout/presentation/view/layout_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../../core/methods/show_snack_bar.dart';
import '../../../../core/scocket_io_services/socket_services.dart';
import '../../../../core/widgets/custom_circular_progress_indicator.dart';
import '../../../../core/widgets/custom_text_button.dart';
import '../manager/auth_cubit/auth_states.dart';

class LoginView extends StatelessWidget {
  static var emailController = TextEditingController();
  static var passwordController = TextEditingController();
  static var formKey = GlobalKey<FormState>();

  const LoginView({super.key});

  void clearControllers() {
    emailController.text = '';
    passwordController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppLogo(),
                    SizedBox(
                      height: AppDimensions.screenHeight * .06,
                    ),
                    Text(
                      'login_now_to_explore_courses'.tr,
                      style: AppStyles.style20,
                    ),
                    SizedBox(
                      height: AppDimensions.screenHeight * .03,
                    ),
                    CustomTextFormField(
                      title: 'email'.tr,
                      keyboardType: TextInputType.emailAddress,
                      pIcon: Icons.email_outlined,
                      controller: emailController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                      title: 'password'.tr,
                      pIcon: Icons.lock_open,
                      isPassword: true,
                      isSuffixIconShown: true,
                      controller: passwordController,
                    ),
                    SizedBox(
                      height: AppDimensions.screenHeight * .02,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: CustomTextButton(
                        title: 'forget_password'.tr,
                        onPressed: () {
                          navigate(
                              context: context, screen: ForgetPasswordView());
                          clearControllers();
                        },
                      ),
                    ),
                    SizedBox(
                      height: AppDimensions.screenHeight * .02,
                    ),
                    BlocConsumer<AuthCubit, AuthStates>(
                      listener: (context, state) async {
                        if (state is SignInSuccessfullyState) {
                          showSnackBar(
                            context: context,
                            label: 'success'.tr,
                            color: AppConstance.primaryColor,
                          );
                          navigateAndRemoveUntil(
                            context: context,
                            screen: LayoutView(),
                          );
                          clearControllers();
                          SocketService().init();
                        }
                        if (state is SignInErrorState) {
                          showSnackBar(
                            context: context,
                            label: CacheHelper.isAr != false
                                ? await translateEnglishToArabic(state.error)
                                : state.error,
                            color: Colors.red,
                          );
                        }
                      },
                      builder: (context, state) {
                        var cubit = AuthCubit.get(context);
                        if (state is SignInLoadingState) {
                          return const CustomCircularProgressIndicator();
                        }
                        return CustomButton(
                          backgroundColor: AppConstance.primaryColor,
                          title: 'login'.tr,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              cubit.signIn(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                        );
                      },
                    ),
                    SizedBox(
                      height: AppDimensions.screenHeight * .03,
                    ),
                   SignWithGoogleIcon(),
                    SizedBox(
                      height: AppDimensions.screenHeight * .01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'don_have_an_account'.tr,
                          style: AppStyles.style13
                              .copyWith(fontWeight: FontWeight.w400),
                        ),
                        CustomTextButton(
                          title: 'signup_now'.tr,
                          onPressed: () {
                            navigate(
                              context: context,
                              screen: const RegisterView(),
                            );
                            clearControllers();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
