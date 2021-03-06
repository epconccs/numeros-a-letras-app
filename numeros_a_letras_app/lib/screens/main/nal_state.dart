class NalState {
  NalState();
  factory NalState.numberData(String string) = NalDataState;
  factory NalState.numberLoading() = NalLoadingState;
  factory NalState.emptyData() = NalEmptyDataState;
  factory NalState.noInternetConnection() = NoInternetState;
}

class NalDataState extends NalState {
  NalDataState(this.number);
  final String number;
  final String letters = "Letras";
}
class NalEmptyDataState extends NalState{
  final String letters = "Letras";
}
class NalLoadingState extends NalState {}

class NoInternetState extends NalState{}
