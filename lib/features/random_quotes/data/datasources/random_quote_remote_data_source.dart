import 'package:quotes_app/core/api/api_consumer.dart';
import 'package:quotes_app/core/api/end_points.dart';
import 'package:quotes_app/features/random_quotes/data/models/quote_model.dart';

abstract class RandomQuoteRemoteDataSource {
  Future<QuoteModel> getRandomQuote();
}

class RandomQuoteRemoteDataSourceImpl implements RandomQuoteRemoteDataSource {
  ApiConsumer apiConsumer;

  RandomQuoteRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<QuoteModel> getRandomQuote() async {
    final response = await apiConsumer.get(EndPoints.randomPath);
   return QuoteModel.fromJson(response);
  }
}
