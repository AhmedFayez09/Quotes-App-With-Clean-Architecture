import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes_app/core/usecase/usecases.dart';
import 'package:quotes_app/core/utils/app_strings.dart';
import 'package:quotes_app/features/splash_screen/domain/usecases/change_locale_use_case.dart';
import 'package:quotes_app/features/splash_screen/domain/usecases/get_saved_lang_use_case.dart';
part 'local_state.dart';

class LocalCubit extends Cubit<LocalState> {
  final GetSavedLangUseCase getSavedLangUseCase;
  final ChangeLocaleUseCase changeLocaleUseCase;

  LocalCubit({
    required this.getSavedLangUseCase,
    required this.changeLocaleUseCase,
  }) : super(const ChangeLocaleState(
          selectedLocale: Locale(AppStrings.englishCode),
        ));

// get saved langauge

  String currentLangCode = AppStrings.englishCode;
  Future<void> getSavedLang() async {
    final response = await getSavedLangUseCase.call(NoParams());
    response.fold((failure) => debugPrint(AppStrings.cacheFailure), (value) {
      currentLangCode = value;
      emit(
        ChangeLocaleState(
          selectedLocale: Locale(currentLangCode),
        ),
      );
    });
  }

  Future<void> _changeLang(String langCode) async {
    final response = await changeLocaleUseCase.call(langCode);
    response.fold((failure) => debugPrint(AppStrings.cacheFailure), (value) {
      currentLangCode = langCode;
      emit(
        ChangeLocaleState(
          selectedLocale: Locale(currentLangCode),
        ),
      );
    });
  }

// change Locale
  void toEnglish() => _changeLang(AppStrings.englishCode);
  void toArabic() => _changeLang(AppStrings.arabicCode);
}
