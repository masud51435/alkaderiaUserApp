// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phone_form_field/phone_form_field.dart';

import 'package:foodnanny/app/features/auth/view/singup_phone_screen.dart';
import 'package:foodnanny/app/features/auth/widgets/phone_search_form_field.dart';
import 'package:foodnanny/app/features/bottom_navbar/controller/navbar_controller.dart';
import 'package:foodnanny/app/features/bottom_navbar/views/bottom_navigation.dart';
import 'package:foodnanny/main.dart';
import 'package:foodnanny/utils/helper/get_country_iso.dart';
import 'package:foodnanny/utils/usecase/validation_rules.dart';
import 'package:foodnanny/widgets/loader/loader.dart';
import 'package:get/get.dart';
import '../../../../config/theme/app_color.dart';
import '../../../../utils/svg_icon.dart';
import '../../../../widgets/primary_button.dart';
import '../../../../widgets/text_widget.dart';
import '../../profile/controller/profile_controller.dart';
import '../controller/auth_controller.dart';
import '../widgets/primary_textfield.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key, this.fromOrderHistory = false});

  final bool fromOrderHistory;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthController authController = Get.put(AuthController());
  ProfileController profileController = Get.put(ProfileController());
  final navController = Get.find<NavbarController>();
  final formKey = GlobalKey<FormState>();

  bool passwordVisible = false;
  bool rememberMe = false;
  String companyCountryCode = "";

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
    authController.isEmailLogin.value = false;
    rememberMe = box.read('remember_me') ?? false;
    companyCountryCode =
        profileController.settingModel.data?.companyCountryCode ?? "";
    if (rememberMe == false) {
      authController.emailController.clear();
      authController.loginPhoneController.clear();
      authController.passwordController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        children: [
          AnnotatedRegion<SystemUiOverlayStyle>(
            value: const SystemUiOverlayStyle(
              systemNavigationBarColor: Colors.white,
              systemNavigationBarIconBrightness: Brightness.dark,
              statusBarIconBrightness: Brightness.dark,
              statusBarColor: Colors.transparent,
              statusBarBrightness: Brightness.dark,
            ),
            child: PopScope(
              canPop: !widget.fromOrderHistory,
              onPopInvokedWithResult: (didPop, result) {
                if (!didPop && widget.fromOrderHistory) {
                  navController.changePage(0);
                  Get.off(() => const BottomNavigationScreen());
                }
              },
              child: Scaffold(
                backgroundColor: AppColor.whiteColor,
                body: SafeArea(
                  child: Center(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Column(
                          children: [
                            SvgPicture.asset(
                              SvgIcon.logo,
                              height: 32.h,
                              width: 133.w,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(height: 24.h),
                            Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              child: TextWidget(
                                text: 'WELCOME_BACK'.tr,
                                color: AppColor.black100,
                                fontWeight: FontWeight.w600,
                                fontSize: 22.sp,
                              ),
                            ),
                            SizedBox(height: 32.h),
                            Form(
                              key: formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          text: authController
                                                  .isEmailLogin
                                                  .value
                                              ? 'EMAIL'.tr
                                              : 'PHONE'.tr,
                                          style: GoogleFonts.urbanist(
                                            color: AppColor.black100,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          children: const [
                                            TextSpan(
                                              text: ' *',
                                              style: TextStyle(
                                                color: Colors.red,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          FocusManager.instance.primaryFocus
                                              ?.unfocus();
                                          authController.isEmailLogin.value =
                                              !authController
                                                  .isEmailLogin
                                                  .value;
                                          authController.emailController
                                              .clear();
                                          authController.loginPhoneController
                                              .clear();
                                          authController.passwordController
                                              .clear();
                                        },
                                        child: TextWidget(
                                          text: authController
                                                  .isEmailLogin
                                                  .value
                                              ? 'Use Phone Instead'
                                              : 'Use Email Instead',
                                          color: AppColor.primaryColor,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4.h),
                                  authController.isEmailLogin.value
                                      ? PrimaryTextField(
                                          controller:
                                              authController.emailController,
                                          obscureText: false,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          validator: (value) =>
                                              ValidationRules().email(value),
                                          passwordVisible: false,
                                          suffixIcon: false,
                                          prefixIcon: false,
                                        )
                                      : PhoneSearchFormField(
                                          onPhoneChanged: (nsn, countryCode) {
                                            authController
                                                    .loginPhoneController
                                                    .text =
                                                nsn;
                                            profileController
                                                .callingCode
                                                .value = countryCode;
                                          },
                                          phoneController: PhoneController(
                                            initialValue: PhoneNumber(
                                              isoCode: getIsoCodeFromString(
                                                companyCountryCode,
                                              ),
                                              nsn: authController
                                                  .loginPhoneController
                                                  .text,
                                            ),
                                          ),
                                        ),
                                  SizedBox(height: 16.h),
                                  RichText(
                                    text: TextSpan(
                                      text: 'PASSWORD'.tr,
                                      style: GoogleFonts.urbanist(
                                        color: AppColor.black100,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      children: const [
                                        TextSpan(
                                          text: ' *',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  PrimaryTextField(
                                    controller:
                                        authController.passwordController,
                                    obscureText: true,
                                    prefixIcon: false,
                                    passwordVisible: passwordVisible,
                                    keyboardType: TextInputType.visiblePassword,
                                    suffixIcon: true,
                                    validator: (password) =>
                                        ValidationRules().password(password),
                                  ),
                                  SizedBox(height: 16.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            rememberMe = !rememberMe;
                                          });
                                          box.write('remember_me', rememberMe);
                                        },
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 16.w,
                                              height: 16.h,
                                              child: rememberMe
                                                  ? SvgPicture.asset(
                                                      SvgIcon.tickSquareMarked,
                                                      fit: BoxFit.cover,
                                                      colorFilter:
                                                          ColorFilter.mode(
                                                            AppColor
                                                                .primaryColor,
                                                            BlendMode.srcIn,
                                                          ),
                                                    )
                                                  : SvgPicture.asset(
                                                      SvgIcon.tickSquare,
                                                      fit: BoxFit.cover,
                                                    ),
                                            ),
                                            SizedBox(width: 6.w),
                                            TextWidget(
                                              text: 'REMEMBER_ME'.tr,
                                              color: AppColor.black100,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12.sp,
                                            ),
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Get.to(() => ForgotPasswordScreen());
                                        },
                                        child: TextWidget(
                                          text: 'FORGOT_PASSWORD'.tr,
                                          color: AppColor.primaryColor,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 24.h),
                                  Center(
                                    child: PrimaryButton(
                                      width: 328.w,
                                      onTap: () async {
                                        if (formKey.currentState!.validate()) {
                                          if (authController
                                              .isEmailLogin
                                              .value) {
                                            await authController.userLogin(
                                              email: authController
                                                  .emailController
                                                  .text,
                                              password: authController
                                                  .passwordController
                                                  .text,
                                            );
                                          } else {
                                            await authController.phoneLogin(
                                              countryCode: profileController
                                                  .callingCode
                                                  .value,
                                              phone: authController
                                                  .loginPhoneController
                                                  .text,
                                              password: authController
                                                  .passwordController
                                                  .text,
                                            );
                                          }
                                        }
                                      },
                                      text: 'LOGIN'.tr,
                                    ),
                                  ),
                                  SizedBox(height: 24.h),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextWidget(
                                        text: 'DONT_HAVE_AN_ACCOUNT?'.tr,
                                        color: AppColor.black80,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12.sp,
                                      ),
                                      SizedBox(width: 8.w),
                                      GestureDetector(
                                        onTap: () {
                                          Get.to(() => SingupPhoneScreen());
                                        },
                                        child: TextWidget(
                                          text: 'SIGN_UP'.tr,
                                          color: AppColor.primaryColor,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 24.h),
                                  Center(
                                    child: TextWidget(
                                      text: 'OR'.tr,
                                      color: AppColor.black80,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                  SizedBox(height: 16.h),
                                  _socialButton(
                                    text: 'Login with Facebook',
                                    symbol: 'f',
                                    onTap: () {},
                                  ),
                                  _socialButton(
                                    text: 'Login with Google',
                                    symbol: 'G',
                                    onTap: () {},
                                  ),
                                  _socialButton(
                                    text: 'Login with Apple',
                                    symbol: '?',
                                    onTap: () {},
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          authController.signInLoader.value == true
              ? Positioned(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white60,
                    child: const Center(child: LoaderCircle()),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget _socialButton({
    required String text,
    required String symbol,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48.h,
        width: 328.w,
        margin: EdgeInsets.only(bottom: 12.h),
        decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(color: AppColor.black20, width: 1.w),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextWidget(
              text: symbol,
              color: AppColor.black100,
              fontWeight: FontWeight.bold,
              fontSize: 18.sp,
            ),
            SizedBox(width: 12.w),
            TextWidget(
              text: text,
              color: AppColor.black100,
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
            ),
          ],
        ),
      ),
    );
  }
}
