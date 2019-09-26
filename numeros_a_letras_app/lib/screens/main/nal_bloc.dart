import 'dart:async';

import 'package:numeros_a_letras_app/data/number_repository.dart';
import 'package:numeros_a_letras_app/screens/main/nal_state.dart';

import 'nal_event.dart';

class NalBloc {
 
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
      if (event.numberT.isNotEmpty) {
        var num = double.parse(event.numberT);

        _numberRepository
            .fromCancelable(
                Future.delayed(const Duration(milliseconds: 500), () {
          return _numberRepository.getNumber(num);
        }))
            .then((number) {
          _inputNumber.add(NalState.numberData(number.letters));
        });
      } else {
        _inputNumber.add(NalState.emptyData());
      }
    }
    else if (event is EmptyDataEvent){
      _inputNumber.add(NalState.emptyData());
    }
  }

  void dispose() {
    _nalEventController.close();
    _nalStateController.close();
  }
}
