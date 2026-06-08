import 'package:flutter/material.dart';
import '../../helper/AppTextStyles.dart';
import '../../helper/colors.dart';
import '../../helper/sizes.dart';

class TDashboardHeader extends StatelessWidget {
  final String greeting;
  final String title;
  final String subtitle;

  const TDashboardHeader({
    super.key,
    required this.greeting,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(
        TAppSizes.xol,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          TAppSizes.cardRadiusLg,
        ),
        gradient: const LinearGradient(
          colors: [
            TAppColors.primaryColor,
            TAppColors.secondaryColor,
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Text(
            greeting,
            style: TAppTextStyles.bodyText2.copyWith(color: TAppColors.whiteColor),
          ),

          const SizedBox(
            height: TAppSizes.sm,
          ),

          Text(
            title,
            style: TAppTextStyles.headline4.copyWith(color: TAppColors.whiteColor),
          ),

          const SizedBox(
            height: TAppSizes.sm,
          ),

          Text(
            "ID: $subtitle",
            style: TAppTextStyles.bodyText2.copyWith(color: TAppColors.whiteColor),
          ),
        ],
      ),
    );
  }
}