import 'package:quotes_app/core/error/exceptions.dart';
import 'package:quotes_app/core/network/network_info.dart';
import 'package:quotes_app/features/random_quotes/data/datasources/random_quote_local_data_source.dart';
import 'package:quotes_app/features/random_quotes/data/datasources/random_quote_remote_data_source.dart';
import 'package:quotes_app/features/random_quotes/domain/entities/quote.dart';
import 'package:quotes_app/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:quotes_app/features/random_quotes/domain/repositories/quote_repository.dart';

class QuoteRepositoryImpl implements QuoteRepository {
  final NetworkInfo networkInfo;
  final RandomQuoteRemoteDataSource randomQuoteRemoteDataSource;
  final RandomQuoteLocalDataSource randomQuoteLocalDataSource;
  QuoteRepositoryImpl({
    required this.networkInfo,
    required this.randomQuoteRemoteDataSource,
    required this.randomQuoteLocalDataSource,
  });
  @override
  Future<Either<Failure, Quote>> getRandomQuote() async {
    if (await networkInfo.isConnected) {
    try {
      final remoteRandomQuote =
          await randomQuoteRemoteDataSource.getRandomQuote();
      randomQuoteLocalDataSource.cacheQuote(remoteRandomQuote);
      return Right(remoteRandomQuote);
    } on ServerException {
      return Left(ServerFailure());
    }
    }
    else{
       try {
        final cacheRandomQuote =
            await randomQuoteLocalDataSource.getLastRandomQuote();
        return Right(cacheRandomQuote);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
