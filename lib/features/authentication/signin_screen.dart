import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:zavisoft_task/constants/assets_path.dart';

import '../../../../constants/text_font_style.dart';
import '../../common_widget/custom_button.dart';
import '../../common_widget/custom_text_field.dart';
import '../../constants/validation.dart';
import '../../providers/sign_in_provider.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Consumer<SignInProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: Colors.white,

          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            physics: ClampingScrollPhysics(),
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _formKey,
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome Back",
                      style: TextFontStyle.headLine18CFFFFFFW700.copyWith(
                        color: const Color(0xFF2C3E50),
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    SizedBox(height: 4.h),

                    Text(
                      "Hello there, signin to continue",
                      style: TextFontStyle.headLine18CFFFFFFW700.copyWith(
                        color: const Color(0xFF7F8C8D),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w300,
                      ),
                    ),

                    SizedBox(height: 24.h),

                    Center(
                      child: SvgPicture.asset(
                        AssetsIcon.signupLockIcon,
                        width: 213.w,
                        height: 165.h,
                        fit: BoxFit.cover,
                      ),
                    ),

                    SizedBox(height: 32.h),

                    CustomTextField(
                      hintText: "Email",
                      controller: emailController,
                      validator: emailValidation,
                    ),
                    SizedBox(height: 20.h),

                    CustomTextField(
                      obscureText: !provider.passwordVisible,
                      keyboardType: TextInputType.visiblePassword,
                      hintText: "Password",
                      suffixIcon: IconButton(
                        onPressed: provider.togglePasswordVisibility,
                        icon: SvgPicture.asset(
                          provider.passwordVisible
                              ? AssetsIcon.eyeOff
                              : AssetsIcon.eyeOn,
                          width: 20.w,
                          height: 20.h,
                          fit: BoxFit.none,
                          colorFilter: ColorFilter.mode(
                            Colors.blue,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      textInputAction: TextInputAction.done,
                      controller: passwordController,
                      validator: passwordValidation,
                    ),

                    SizedBox(height: 20.h),

                    CustomButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {}
                      },
                      text: "Sign In",
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
