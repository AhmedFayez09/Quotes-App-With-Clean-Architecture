
import 'package:flutter/material.dart';
import 'package:quotes_app/core/utils/app_colors.dart';

class QuoteReload extends StatelessWidget {
  const QuoteReload({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.primaryColor,

      ),
      child:  Icon(Icons.refresh,color: AppColors.wColor,size: 30,),
    );
  }
}