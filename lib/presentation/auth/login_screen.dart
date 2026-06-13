import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plumedica/helper/sizes.dart';
import 'package:plumedica/presentation/auth/register_screen.dart';
import 'package:plumedica/presentation/doctor/screen/home_screen.dart';
import 'package:plumedica/presentation/supar_admin/screens/supar_admin_home.dart';
import 'package:plumedica/presentation/widget/padding.dart';
import 'package:plumedica/presentation/widget/round_button.dart';
import '../../../../helper/colors.dart';
import '../../../../helper/validation.dart';
import 'controller/login_controller.dart';

class LoginScreen extends StatelessWidget {
  final String role;
  final String roleTitle;

  const LoginScreen({super.key, required this.role, required this.roleTitle});

  Color get _roleColor {
    return role == 'admin'
        ? TAppColors.secondaryColor
        : TAppColors.primaryColor;
  }

  @override
  Widget build(BuildContext context) {
    final loginFormKey = GlobalKey<FormState>();
    final controller = Get.put(LoginController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: TAppPadding.screenPadding,
          child: Column(
            children: [
              const SizedBox(height: 40),

              // Role Icon
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: _roleColor.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  role == 'admin'
                      ? Icons.admin_panel_settings
                      : Icons.local_hospital,
                  size: 80,
                  color: _roleColor,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Login to your ${roleTitle.toLowerCase()} account',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 40),
              Form(
                key: loginFormKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: TAppSizes.spaceBtwSections,
                  ),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: controller.emailCont,
                        focusNode: controller.emailFocusNode,
                        validator: (value) =>
                            TAppValidator.validateEmail(value),
                        decoration: const InputDecoration(
                          label: Text('email'),
                          prefixIcon: Icon(Icons.email),
                        ),
                      ),

                      const SizedBox(height: TAppSizes.spaceBtwInputFields),

                      Obx(
                        () => TextFormField(
                          controller: controller.passwordCont,
                          focusNode: controller.passwordFocusNode,
                          obscureText: controller.isPasswordVisible.value,
                          validator: (value) => TAppValidator.validateEmptyText(
                            "password",
                            value,
                          ),
                          decoration: InputDecoration(
                            label: const Text('password'),
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                              onPressed: () =>
                                  controller.isPasswordVisible.toggle(),
                              icon: Icon(
                                controller.isPasswordVisible.value
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: TAppSizes.spaceBtwInputFields / 2),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Obx(
                                () => Checkbox(
                                  value: controller.rememberMe.value,
                                  onChanged: (value) =>
                                      controller.rememberMe.value = value!,
                                ),
                              ),
                              const Text('rememberMe'),
                            ],
                          ),

                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'forgetPassword',
                              style: TextStyle(color: TAppColors.primaryColor),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: TAppSizes.spaceBtwSections),

                      // TRoundButtonFiled(buttonText: 'Login', onPress: ()=>controller.isLoading),
                      Obx(
                        () => TRoundButtonFiled(
                          isLoading: controller.isLoading.value,
                          buttonText: 'Login',
                          onPress: () {
                            if (role != 'doctor') {
                              Get.to(SuperAdminDashboardScreen());
                            } else {
                              if (loginFormKey.currentState!.validate()) {
                                controller.login();
                              }
                            }
                          },
                        ),
                      ),

                      const SizedBox(height: TAppSizes.spaceBtwItems),

                      if (role == "doctor")
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have account? "),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RegisterScreen(),
                                  ),
                                );
                              },
                              child: const Text(
                                "Register",
                                style: TextStyle(
                                  color: TAppColors.primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
