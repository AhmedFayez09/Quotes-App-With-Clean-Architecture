import 'package:quotes_app/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:quotes_app/core/usecase/usecases.dart';
import 'package:quotes_app/features/splash_screen/domain/repositories/lang_repository.dart';

class ChangeLocaleUseCase implements UseCase<bool, String> {
  final LangRepository langRepository;

  ChangeLocaleUseCase({required this.langRepository});

  @override
  Future<Either<Failure, bool>> call(String langCode) async =>
      await langRepository.changeLang(langCode: langCode);
}
