import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes_app/core/usecase/usecases.dart';
import 'package:quotes_app/core/utils/app_strings.dart';
import 'package:quotes_app/features/random_quotes/domain/entities/quote.dart';
import 'package:quotes_app/features/random_quotes/domain/usecases/get_random_quote.dart';
import '../../../../core/error/failures.dart';
part 'random_quotes_state.dart';

class RandomQuotesCubit extends Cubit<RandomQuotesState> {
  final GetRandomQuote getRandomQuoteUseCase;
  RandomQuotesCubit({required this.getRandomQuoteUseCase})
      : super(RandomQuotesInitial());

  Future<void> getRandomQuote() async {
    emit(RandomQuotesLoading());
    Either<Failure, Quote> response = await getRandomQuoteUseCase(NoParams());
    emit(
      response.fold(
        (failure) => RandomQuotesError(msg: _mapFailureTOMsg(failure)),
        (quote) => RandomQuotesLoaded(quote: quote),
      ),
    );
  }

  String _mapFailureTOMsg(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return AppStrings.serverFailure;
      case CacheFailure:
        return AppStrings.cacheFailure;
      default:
        return AppStrings.unexpectedError;
    }
  }
}
