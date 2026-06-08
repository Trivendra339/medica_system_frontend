
import 'package:flutter/material.dart';

import '../../helper/AppTextStyles.dart';
import '../../helper/colors.dart';
import '../../helper/sizes.dart';

class TRoundButtonFiled extends StatelessWidget {
  final String buttonText;
  final bool isLoading;
  final IconData? icon;
  final bool? isBackgroundColor;
  final Color? backgroundColor,iconColor;
  final double height,width,radius;
  final VoidCallback onPress;
  final bool showBorder;
  final Color borderColor,textColor;
  final double borderWidth;

  const TRoundButtonFiled(
      {super.key,
        required this.buttonText,
        required this.onPress,
        this.icon,
        this.textColor = TAppColors.whiteColor,
        this.iconColor = TAppColors.whiteColor,
        this.isBackgroundColor = true,
        this.backgroundColor = TAppColors.primaryColor,
        this.height =  TAppSizes.buttonHeight,
        this.width = TAppSizes.buttonWidth,
        this.radius = TAppSizes.buttonRadius,
        this.isLoading = false,
        this.borderWidth = 0.0,
        this.showBorder = false,
        this.borderColor = TAppColors.lightGrayColor,
      });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: TAppColors.primaryColor,
      onTap: isLoading? null : onPress,
      child: Container(
          alignment: Alignment.center,
          height: height,
          width: width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              border: showBorder? Border.all(color: borderColor,width: borderWidth) : null,
              color: isBackgroundColor != false ? backgroundColor : null,
          ),
          child: isLoading ?
          Center(child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [

            Text('loading...',style:  TAppTextStyles.bodyText1.copyWith(color: textColor,fontWeight: FontWeight.w700),),

            const SizedBox(width: TAppSizes.spaceBtwItems),

            const SizedBox(
              height: 15, width: 15,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                strokeWidth: 2,
              ),
            ),

          ]),
          ) : Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            icon != null ? Padding(
              padding:  EdgeInsets.only(right: TAppSizes.xs),
              child: Icon(icon, color: iconColor),
            ) : const SizedBox(),
            Text(buttonText, textAlign: TextAlign.center,
            style: TAppTextStyles.bodyText1.copyWith(color: textColor,fontWeight: FontWeight.w700),

             ),
          ]),
      ),
    );
  }
}