class NalState {
  NalState();
  factory NalState.numberData(String string) = NalDataState;
  factory NalState.numberLoading() = NalLoadingState;
}

class NalDataState extends NalState {
  NalDataState(this.number);
  final String number;
}

class NalLoadingState extends NalState {}
