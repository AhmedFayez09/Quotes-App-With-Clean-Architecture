import 'package:quotes_app/core/error/exceptions.dart';
import 'package:quotes_app/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:quotes_app/features/splash_screen/data/datasources/lang_local_data_source.dart';
import 'package:quotes_app/features/splash_screen/domain/repositories/lang_repository.dart';

class LangRepositoryImpl implements LangRepository {
  final LangLocaleDataSource langLocaleDataSource;

  LangRepositoryImpl({required this.langLocaleDataSource});
  @override
  Future<Either<Failure, bool>> changeLang({required String langCode}) async {
    try {
      final langIsChanged =
          await langLocaleDataSource.changeLang(langCode: langCode);
      return Right(langIsChanged);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, String>> getSavedLang() async {
    try {
      final langCode = await langLocaleDataSource.getSavedLang();
      return Right(langCode!);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
