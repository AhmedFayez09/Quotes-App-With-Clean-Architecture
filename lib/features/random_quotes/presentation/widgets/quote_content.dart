import 'package:flutter/material.dart';
import 'package:quotes_app/core/utils/app_colors.dart';
import 'package:quotes_app/features/random_quotes/domain/entities/quote.dart';

class QuoteContant extends StatelessWidget {
  final Quote quote;
  const QuoteContant({super.key, required this.quote});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(
            quote.content,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Text(
              quote.auther,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          )
        ],
      ),
    );
  }
}
