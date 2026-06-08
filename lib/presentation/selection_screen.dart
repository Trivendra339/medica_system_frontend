import 'package:flutter/material.dart';
import 'package:plumedica/helper/AppTextStyles.dart';
import 'package:plumedica/helper/colors.dart';
import 'package:plumedica/helper/sizes.dart';

import 'auth/login_screen.dart';

class SelectionScreen extends StatelessWidget {
  const SelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(TAppSizes.xl),
                    decoration: BoxDecoration(
                      color: TAppColors.whiteColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withValues(alpha: 0.2),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.medical_services,
                      size: TAppSizes.iconLg*2,
                      color: TAppColors.primaryColor,
                    ),
                  ),
                  const SizedBox(height: TAppSizes.xol),

                   Text(
                    'Doctor Management System',
                    style: TAppTextStyles.headline2.copyWith(color: TAppColors.primaryColor),
                  ),
                  const SizedBox(height: TAppSizes.md),
                  Text(
                    'Choose your role to continue',
                    style: TAppTextStyles.headline5.copyWith(color: TAppColors.textSecondary),
                  ),
                ],
              ),
            ),

            const SizedBox(height: TAppSizes.spaceBtwSections),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: TAppSizes.xol),
                child: Column(
                  children: [
                    // Super Admin Card
                    _buildRoleCard(
                      context: context,
                      title: 'Super Admin',
                      description: 'Full access to manage doctors,\npatients, and system settings',
                      icon: Icons.admin_panel_settings,
                      color: TAppColors.secondaryColor,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(
                              role: 'admin',
                              roleTitle: 'Super Admin',
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: TAppSizes.xol),

                    // Doctor Card
                    _buildRoleCard(
                      context: context,
                      title: 'Doctor',
                      description: 'Manage appointments,\npatients, and prescriptions',
                      icon: Icons.local_hospital,
                      color: TAppColors.primaryColor,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(
                              role: 'doctor',
                              roleTitle: 'Doctor',
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleCard({
    required BuildContext context,
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 8,
        color: Colors.white,
        shadowColor: color.withValues(alpha: 0.4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(TAppSizes.cardRadiusMd),
        ),
        child: Padding(
          padding: const EdgeInsets.all(TAppSizes.xol),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(TAppSizes.lg),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: color.withValues(alpha: 0.3),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Icon(
                  icon,
                  size: TAppSizes.iconMd,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: TAppSizes.spaceBtwItems),


              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TAppTextStyles.headline3.copyWith(color: color),
                    ),
                    const SizedBox(height: TAppSizes.md),
                    Text(
                      description,
                      style: TAppTextStyles.bodyText2,
                    ),
                    const SizedBox(height: TAppSizes.lg),
                    Row(
                      children: [
                        Text(
                          'Login as $title',
                          style: TAppTextStyles.bodyText2.copyWith(color: color),
                        ),
                        const SizedBox(width: TAppSizes.sm),
                        Icon(
                          Icons.arrow_forward,
                          size: TAppSizes.iconMd,
                          color: color,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}