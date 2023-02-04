import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quotes_app/config/locale/app_localizations.dart';
import 'package:quotes_app/core/component/error/error_component.dart';
import 'package:quotes_app/core/utils/app_colors.dart';
import 'package:quotes_app/features/random_quotes/presentation/cubit/random_quotes_cubit.dart';
import 'package:quotes_app/features/random_quotes/presentation/widgets/quote_content.dart';
import 'package:quotes_app/features/random_quotes/presentation/widgets/quote_reload.dart';
import 'package:quotes_app/features/splash_screen/presentation/cubit/local_cubit.dart';

class QuoteScreen extends StatefulWidget {
  const QuoteScreen({super.key});

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  _getRandomQuote() {
    BlocProvider.of<RandomQuotesCubit>(context).getRandomQuote();
  }

  @override
  void initState() {
    _getRandomQuote();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.translate_outlined,
              color: AppColors.primaryColor,
            ),
            onPressed: (){
              if(AppLocalizations.of(context)!.isEnLocale){
                BlocProvider.of<LocalCubit>(context).toArabic();

              }else{
                BlocProvider.of<LocalCubit>(context).toEnglish();
              }
            },
          ),
          title: Text(AppLocalizations.of(context)!.translate('app_name')!),
        ),
        body: _buildBodyContent(),
      ),
      onRefresh: () => _getRandomQuote(),
    );
  }

  Widget _buildBodyContent() {
    return BlocBuilder<RandomQuotesCubit, RandomQuotesState>(
      builder: (context, state) {
        if (state is RandomQuotesLoading) {
          return Center(
            child: SpinKitFadingCircle(
              color: AppColors.primaryColor,
            ),
          );
        } else if (state is RandomQuotesLoaded) {
          return Column(
            children: [
              QuoteContant(quote: state.quote),
              InkWell(
                  onTap: () {
                    _getRandomQuote();
                  },
                  child: const QuoteReload()),
            ],
          );
        } else if (state is RandomQuotesError) {
          return ErrorComponent(
            onPress: () => _getRandomQuote(),
          );
        } else {
          return Center(
            child: SpinKitFadingCircle(
              color: AppColors.primaryColor,
            ),
          );
        }
      },
    );
  }
}
