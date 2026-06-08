import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plumedica/helper/colors.dart';
import '../../../../helper/sizes.dart';
import '../../../../helper/validation.dart';
import '../widget/round_button.dart';
import 'controller/login_controller.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final registerFormKey = GlobalKey<FormState>();
    final controller = LoginController.instance;
    return Scaffold(
      appBar: AppBar(title: const Text("Doctor Registration")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            Form(
              key: registerFormKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: TAppSizes.spaceBtwSections,
                ),
                child: Column(
                  children: [

                    TextFormField(
                      controller: controller.name,
                      validator: (value) =>
                          TAppValidator.validateEmptyText('Full Name', value),
                      decoration: const InputDecoration(
                        label: Text('Full Name'),
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),

                    const SizedBox(height: TAppSizes.spaceBtwInputFields),

                    TextFormField(
                      controller: controller.email,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) =>
                          TAppValidator.validateEmail(value),
                      decoration: const InputDecoration(
                        label: Text('Email'),
                        prefixIcon: Icon(Icons.email),
                      ),
                    ),


                    const SizedBox(height: TAppSizes.spaceBtwInputFields),

                    TextFormField(
                      controller: controller.mobile,
                      keyboardType: TextInputType.phone,
                      validator: (value) => TAppValidator.validatePhoneNumber(value),
                      decoration: const InputDecoration(
                        label: Text('Mobile Number'),
                        prefixIcon: Icon(Icons.phone),
                      ),
                    ),

                    const SizedBox(height: TAppSizes.spaceBtwInputFields),


                    TextFormField(
                      controller: controller.qualification,
                      validator: (value) => TAppValidator.validateEmptyText('Qualification', value),
                      decoration: const InputDecoration(
                        label: Text('Qualification'),
                        prefixIcon: Icon(Icons.badge),
                      ),
                    ),

                    const SizedBox(height: TAppSizes.spaceBtwInputFields),

                    TextFormField(
                      controller: controller.experience,
                      validator: (value) => TAppValidator.validateEmptyText('Experience', value),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        label: Text('Experience (Years)'),
                        prefixIcon: Icon(Icons.work),
                      ),
                    ),
                    const SizedBox(height: TAppSizes.spaceBtwInputFields),

                    TextFormField(
                      controller: controller.address,
                      validator: (value) => TAppValidator.validateEmptyText('Address', value),
                      decoration: const InputDecoration(
                        label: Text('Address'),
                        prefixIcon: Icon(Icons.medical_services),
                      ),
                    ),

                    const SizedBox(height: TAppSizes.spaceBtwInputFields),

                    TextFormField(
                      controller: controller.hcName,
                      validator: (value) => TAppValidator.validateEmptyText('Hospital/Clinic Name', value),
                      decoration: const InputDecoration(
                        label: Text('Hospital / Clinic Namea'),
                        prefixIcon: Icon(Icons.medical_services),
                      ),
                    ),

                    const SizedBox(height: TAppSizes.spaceBtwInputFields),


                    TextFormField(
                      controller: controller.licenseNumber,
                      validator: (value) => TAppValidator.validateEmptyText('License Number', value),
                      decoration: const InputDecoration(
                        label: Text('License Number'),
                        prefixIcon: Icon(Icons.medical_services),
                      ),
                    ),

                    const SizedBox(height: TAppSizes.spaceBtwInputFields),

                    TextFormField(
                      controller: controller.availabilityDays,
                      decoration: const InputDecoration(
                        label: Text('Availability Days'),
                        prefixIcon: Icon(Icons.local_hospital),
                      ),
                    ),

                    const SizedBox(height: TAppSizes.spaceBtwInputFields),

                    TextFormField(
                      controller: controller.availabilityTime,
                      decoration: const InputDecoration(
                        label: Text('Availability Time'),
                        prefixIcon: Icon(Icons.local_hospital),
                      ),
                    ),

                    const SizedBox(height: TAppSizes.spaceBtwInputFields),

                    Obx(
                          () => TextFormField(
                        controller: controller.password,
                        obscureText: controller.hidePassword.value,
                            validator: (value) => TAppValidator.validatePassword(value),
                        decoration: InputDecoration(
                          label: const Text('Password'),
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            onPressed: controller.hidePassword.toggle,
                            icon: Icon(
                              controller.hidePassword.value
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: TAppSizes.spaceBtwInputFields),

                    Obx(
                          () => TextFormField(
                        controller: controller.confirmPassword,
                        obscureText: controller.hideConfirmPassword.value,
                        validator: (value) => TAppValidator.validatePassword(value),
                        decoration: InputDecoration(
                          label: const Text('Confirm Password'),
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            onPressed:
                            controller.hideConfirmPassword.toggle,
                            icon: Icon(
                              controller.hideConfirmPassword.value
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(width: double.infinity,
              child: Obx((){
                if(controller.isLoadingFile.value) {
                  return Center(child:CircularProgressIndicator());
                }
                if(controller.documentPath.value["succese"] == true){
                   return Row(
                     children: [
                       Expanded(
                         child: OutlinedButton.icon(
                           onPressed: null,
                           icon: const Icon(Icons.upload_file),
                           label: const Text("Upload File"),
                         ),
                       ),
                       Icon(Icons.done,color: TAppColors.primaryColor,)
                     ],
                   );
                }
                return OutlinedButton.icon(
                  onPressed: ()=>controller.uploadFile(),
                  icon: const Icon(Icons.upload_file),
                  label: const Text("Upload File"),
                );
              }),
            ),

            const SizedBox(height: 25),
            Obx(
              ()=> TRoundButtonFiled(
                isLoading: controller.isLoading.value,
                  width: double.infinity,
                  buttonText: 'Register', onPress: (){
                if (registerFormKey.currentState!.validate()) {
                  controller.register();
                }
              })),
          ],
        ),
      ),
    );
  }
}