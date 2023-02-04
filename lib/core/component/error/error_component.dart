import 'package:flutter/material.dart';
import 'package:quotes_app/core/utils/app_colors.dart';
import 'package:quotes_app/core/utils/app_strings.dart';
import 'package:sizer/sizer.dart';

import '../../../config/locale/app_localizations.dart';

class ErrorComponent extends StatelessWidget {
  final VoidCallback? onPress;
  const ErrorComponent({super.key, this.onPress});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Icon(
            Icons.warning_amber_rounded,
            color: AppColors.primaryColor,
            size: 150.sp,
          ),
        ),
        // Container(
        //   margin:  EdgeInsets.symmetric(vertical: 12.sp),
        // child:
        Text(
          AppLocalizations.of(context)!.translate('something_went_wrong')!,
         
          style: Theme.of(context).textTheme.headline1,
        ),
        // )
        SizedBox(height: 1.h),
        Text(
          AppLocalizations.of(context)!.translate('try_again')!,
          style: Theme.of(context).textTheme.headline2,
        ),
        SizedBox(height: 1.h),
        ElevatedButton(
          style: ButtonStyle(
            padding: MaterialStateProperty.all(
                EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 7.w)),
            backgroundColor: MaterialStateProperty.all(AppColors.primaryColor),
            foregroundColor:
                MaterialStateProperty.all(Theme.of(context).primaryColor),
            elevation: MaterialStateProperty.all(500),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.sp),
              ),
            ),
          ),
          onPressed: () {
            if (onPress != null) {
              onPress!();
            }
          },
          child: Text(
            AppLocalizations.of(context)!.translate('reload_screen')!,
            style: Theme.of(context)
                .textTheme
                .headline2!
                .copyWith(color: AppColors.wColor),
          ),
        ),
      ],
    );
  }
}
