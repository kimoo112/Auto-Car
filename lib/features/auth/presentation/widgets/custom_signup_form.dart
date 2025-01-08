import 'package:auto_car/core/routes/routes.dart';
import 'package:auto_car/core/widgets/custom_button.dart';
import 'package:auto_car/core/widgets/custom_text_form_field.dart';
import 'package:auto_car/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/routes/functions/navigation_functions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';

class CustomSignupForm extends StatefulWidget {
  const CustomSignupForm({
    super.key,
  });

  @override
  State<CustomSignupForm> createState() => _CustomSignupFormState();
}

class _CustomSignupFormState extends State<CustomSignupForm> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(
                  content: Text(
                      'Registration successful! Please log in to continue.')))
              .close;
          customReplacementNavigate(context, loginView);
          context.read<AuthCubit>().clearSignupControllers();
        } else if (state is SignUpFailure) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.errMsg),
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
                  controller: context.read<AuthCubit>().signupName,
                  hintText: 'Name',
                  icon: IconlyLight.profile,
                ),
                20.verticalSpace,
                CustomTextFormField(
                  controller: context.read<AuthCubit>().signupEmail,
                  hintText: 'Email',
                  icon: IconlyLight.message,
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
                  controller: context.read<AuthCubit>().signupPassword,
                  hintText: 'Password',
                  obscureText: true,
                  icon: IconlyLight.lock,
                ),
                20.verticalSpace,
                CustomTextFormField(
                  controller: context.read<AuthCubit>().signupConfirmPassword,
                  hintText: 'Confirm Password',
                  icon: IconlyLight.lock,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Confirm Password is required';
                    }
                    if (value !=
                        context.read<AuthCubit>().signupPassword.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                40.verticalSpace,
                state is SignUpLoading
                    ? CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      )
                    : CustomButton(
                        marginSize: 0,
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            await context.read<AuthCubit>().signup();
                          }
                        },
                        text: 'Signup',
                        borderRadius: 12,
                        textColor: AppColors.white,
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have account ?',
                        style: CustomTextStyles.poppins400Style16),
                    TextButton(
                      onPressed: () {
                        customReplacementNavigate(context, loginView);
                      },
                      child: Text(
                        'Login Now',
                        style: CustomTextStyles.poppins400Style16
                            .copyWith(color: AppColors.primaryColor),
                      ),
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
