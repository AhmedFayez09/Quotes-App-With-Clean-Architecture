import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:quotes_app/core/api/api_consumer.dart';
import 'package:quotes_app/core/api/dio_consumer.dart';
import 'package:quotes_app/core/network/network_info.dart';
import 'package:quotes_app/features/random_quotes/data/datasources/random_quote_local_data_source.dart';
import 'package:quotes_app/features/random_quotes/data/datasources/random_quote_remote_data_source.dart';
import 'package:quotes_app/features/random_quotes/data/repositories/quote_repository_impl.dart';
import 'package:quotes_app/features/random_quotes/domain/repositories/quote_repository.dart';
import 'package:quotes_app/features/random_quotes/domain/usecases/get_random_quote.dart';
import 'package:quotes_app/features/random_quotes/presentation/cubit/random_quotes_cubit.dart';
import 'package:quotes_app/features/splash_screen/data/datasources/lang_local_data_source.dart';
import 'package:quotes_app/features/splash_screen/domain/usecases/change_locale_use_case.dart';
import 'package:quotes_app/features/splash_screen/domain/usecases/get_saved_lang_use_case.dart';
import 'package:quotes_app/features/splash_screen/presentation/cubit/local_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/api/app_interceptors.dart';
import 'features/splash_screen/data/repositories/lang_repository_lmpl.dart';
import 'features/splash_screen/domain/repositories/lang_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
//! Features

  //Blocs
  sl.registerFactory(() => RandomQuotesCubit(getRandomQuoteUseCase: sl()));
  sl.registerFactory(() => LocalCubit(getSavedLangUseCase: sl(), changeLocaleUseCase: sl()));
  // Use Cases
  sl.registerLazySingleton<GetRandomQuote>(() => GetRandomQuote(quoteRepository: sl()));
  sl.registerLazySingleton<GetSavedLangUseCase>(() => GetSavedLangUseCase(langRepository: sl()));
  sl.registerLazySingleton<ChangeLocaleUseCase>(() => ChangeLocaleUseCase(langRepository: sl()));
  // Repository
  sl.registerLazySingleton<QuoteRepository>(() => QuoteRepositoryImpl(
        networkInfo: sl(),
        randomQuoteRemoteDataSource: sl(),
        randomQuoteLocalDataSource: sl(),
      ));
  sl.registerLazySingleton<LangRepository>(() => LangRepositoryImpl(langLocaleDataSource: sl()));    
  // Data Sources
  sl.registerLazySingleton<RandomQuoteLocalDataSource>(
      () => RandomQuoteLocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<RandomQuoteRemoteDataSource>(
      () => RandomQuoteRemoteDataSourceImpl(apiConsumer: sl()));
  sl.registerLazySingleton<LangLocaleDataSource>(() => LangLocaleDataSourceImpl(sharedPreferences: sl()));    
////! Core

  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: sl()));
  sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(client: sl()));
// ! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => AppInterceptors());
  sl.registerLazySingleton(() => LogInterceptor(
        request: true,
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true,
        error: true,
      ));
}
