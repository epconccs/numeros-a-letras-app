import 'dart:async';
import 'package:numeros_a_letras_app/data/number_repository.dart';
import 'package:numeros_a_letras_app/screens/main/nal_state.dart';
import 'package:numeros_a_letras_app/utils/network_validator.dart';

import 'nal_event.dart';

class NalBloc {
  final NumberRepository _numberRepository;
  final _nalStateController = StreamController<NalState>();
  var num = 0.0;

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
      if (event.numberT.isNotEmpty && event.numberT != ".") {
        num = double.tryParse(event.numberT);
        if (num != null) {
          NetworkCheck networkCheck = new NetworkCheck();
          networkCheck.checkInternet(fetchPrefrence);  
        }
      } else {
        _inputNumber.add(NalState.emptyData());
      }
    } else if (event is EmptyDataEvent) {
      _inputNumber.add(NalState.emptyData());
    }
  }

  fetchPrefrence(bool isNetworkPresent) {
    if (isNetworkPresent) {
      _numberRepository
              .fromCancelable(
                  Future.delayed(const Duration(milliseconds: 500), () {
            return _numberRepository.getNumber(num);
          }))
              .then((number) {
            if (number.letters != 'Letras')
              _inputNumber.add(NalState.numberData(number.letters));
            else
              _inputNumber.add(NalState.noInternetConnection());
          });
    } else {
      _inputNumber.add(NalState.noInternetConnection());
    }
  }

  void dispose() {
    _nalEventController.close();
    _nalStateController.close();
  }
}
