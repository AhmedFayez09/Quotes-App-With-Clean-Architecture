part of 'local_cubit.dart';

abstract class LocalState extends Equatable {
  final Locale locale;
  const LocalState(
    this.locale,
  );

  @override
  List<Object> get props => [locale];
}

class ChangeLocaleState extends LocalState {

const ChangeLocaleState( {required Locale selectedLocale}) 
: super(selectedLocale);
  // const ChangeLocaleState(super.locale, this.selectedLocale);
}
