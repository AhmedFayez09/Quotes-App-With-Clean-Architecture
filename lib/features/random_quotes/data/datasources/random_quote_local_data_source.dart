import 'dart:convert';
import 'package:quotes_app/core/error/exceptions.dart';
import 'package:quotes_app/core/utils/app_strings.dart';
import 'package:quotes_app/features/random_quotes/data/models/quote_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class RandomQuoteLocalDataSource {
  Future<QuoteModel> getLastRandomQuote();
  Future<void> cacheQuote(QuoteModel quote);
}

class RandomQuoteLocalDataSourceImpl implements RandomQuoteLocalDataSource {
  final SharedPreferences sharedPreferences;

  RandomQuoteLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<QuoteModel> getLastRandomQuote() {
    final jsonString = sharedPreferences.getString(AppStrings.cacheRandomQuote);

    if (jsonString != null) {
      final cacheRandomQuote = Future.value(QuoteModel.fromJson(json.decode(jsonString)));
      return cacheRandomQuote;
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheQuote(QuoteModel quote) {
  return sharedPreferences.setString(AppStrings.cacheRandomQuote, json.encode(quote));
  }
}
