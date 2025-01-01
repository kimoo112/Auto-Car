import 'package:auto_car/core/widgets/custom_button.dart';
import 'package:auto_car/core/widgets/custom_text_form_field.dart';
import 'package:auto_car/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/routes/functions/navigation_functions.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';

class CustomLoginForm extends StatelessWidget {
  const CustomLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Success')))
              .close;
          customReplacementAndRemove(context, appNavigation);
        } else if (state is LoginFailure) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.errMessage),
          ));
        }
      },
      builder: (context, state) {
        GlobalKey<FormState> formKey = GlobalKey();
        return Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                CustomTextFormField(
                  hintText: 'Email',
                  icon: IconlyLight.message,
                  controller: context.read<AuthCubit>().loginEmail,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email address';
                    } else if (!RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                20.verticalSpace,
                CustomTextFormField(
                  hintText: 'Password',
                  obscureText: true,
                  controller: context.read<AuthCubit>().loginPassword,
                  icon: IconlyLight.lock,
                ),
                40.verticalSpace,
                state is LoginLoading
                    ? CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      )
                    : CustomButton(
                        marginSize: 0,
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            await context.read<AuthCubit>().login();
                          }
                        },
                        text: 'Login',
                        borderRadius: 12,
                        textColor: AppColors.white,
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don’t have an account?',
                      style: CustomTextStyles.poppins400Style16,
                    ),
                    TextButton(
                      onPressed: () {
                        customReplacementNavigate(context, signupView);
                      },
                      child: Text('Register Now',
                          style: CustomTextStyles.poppins400Style16
                              .copyWith(color: AppColors.primaryColor)),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
