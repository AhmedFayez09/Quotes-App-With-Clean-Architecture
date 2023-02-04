import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes_app/bloc_observer.dart';
import 'package:quotes_app/config/locale/app_localizations_setup.dart';
import 'package:quotes_app/config/routes/routes.dart';
import 'package:quotes_app/config/themes/app_theme.dart';
import 'package:quotes_app/core/utils/app_strings.dart';
import 'package:sizer/sizer.dart';
import 'features/splash_screen/presentation/cubit/local_cubit.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  BlocOverrides.runZoned(
    () {
      runApp(const MyApp());
    },
    blocObserver: AppBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => di.sl<LocalCubit>()..getSavedLang(),
          ),
        ],
        child: BlocBuilder<LocalCubit, LocalState>(
          buildWhen: (previous, current) {
            return previous != current;
          },
          builder: (context, state) {
            return MaterialApp(
              locale: state.locale,
              debugShowCheckedModeBanner: false,
              title: AppStrings.appTitle,
              theme: appData(),
              onGenerateRoute: AppRoutes.onGenerateRoute,
              supportedLocales: AppLocalizationsSetup.supportedLocales,
              localeResolutionCallback:
                  AppLocalizationsSetup.localeResolutionCallback,
              localizationsDelegates:
                  AppLocalizationsSetup.localizationsDelegates,
            );
          },
        ),
      );
    });
  }
}
