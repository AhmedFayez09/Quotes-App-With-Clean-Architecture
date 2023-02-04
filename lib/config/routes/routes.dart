import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes_app/config/routes/app_routes.dart';
import 'package:quotes_app/core/utils/app_strings.dart';
import 'package:quotes_app/features/favourite_quote/presentation/screens/favorite_qoute_screen.dart';
import 'package:quotes_app/features/random_quotes/presentation/cubit/random_quotes_cubit.dart';
import 'package:quotes_app/features/random_quotes/presentation/screens/quote_screen.dart';
import 'package:quotes_app/features/splash_screen/presentation/screen/splash_screen.dart';
import 'package:quotes_app/injection_container.dart' as di;

class AppRoutes {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashScreen:
        return MaterialPageRoute(
          builder: ((c) => const SplashScreen()),
        );
      case Routes.quoteScreen:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => di.sl<RandomQuotesCubit>(),
                  child: const QuoteScreen(),
                ));

      case Routes.favoriteScrren:
        return MaterialPageRoute(
          builder: ((c) => const FavoriteQuote()),
        );

      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
      builder: ((c) => const Scaffold(
            body: Center(
              child: Text(AppStrings.noRouteFound,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
            ),
          )),
    );
  }
}
