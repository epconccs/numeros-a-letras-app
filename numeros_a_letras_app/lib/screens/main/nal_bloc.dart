import 'dart:async';

import 'package:numeros_a_letras_app/data/number_repository.dart';
import 'package:numeros_a_letras_app/screens/main/nal_state.dart';

import 'nal_event.dart';

class NalBloc {
  int num = 0;
  final NumberRepository _numberRepository;
  final _nalStateController = StreamController<NalState>();

  StreamSink<NalState> get _inputNumber => _nalStateController.sink;
  Stream<NalState> get number => _nalStateController.stream;
  Sink<NalEvent> get new_number_event_sink => _nalEventController.sink;

  final _nalEventController = StreamController<NalEvent>();

  NalBloc(this._numberRepository) {
    _nalEventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(NalEvent event) {
    _inputNumber.add(NalLoadingState());
    if (event is NewNumberEvent) {
      if (event.numberT.isNotEmpty && event.numberT != null) {
        var num = double.parse(event.numberT);
        _numberRepository.getNumber(num).then((number) {
          _inputNumber.add(NalState.numberData(number.letters));
        });
      }
      else{
        _inputNumber.add(NalState.emptyData());
      }
    }
  }
}
