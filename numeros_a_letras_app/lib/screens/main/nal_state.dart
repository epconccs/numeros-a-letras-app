class NalState {
  NalState();
  factory NalState.numberData(String string) = NalDataState;
  factory NalState.numberLoading() = NalLoadingState;
  factory NalState.emptyData() = NalEmptyDataState;
}

class NalDataState extends NalState {
  NalDataState(this.number);
  final String number;
}
class NalEmptyDataState extends NalState{
  final String letters = "Letras";
}
class NalLoadingState extends NalState {}
