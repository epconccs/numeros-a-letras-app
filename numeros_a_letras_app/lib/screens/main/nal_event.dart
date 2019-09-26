abstract class NalEvent {}

class NewNumberEvent extends NalEvent {
  String numberT;
  NewNumberEvent(String numberText){
    this.numberT = numberText;
  }
  
}

class EmptyDataEvent extends NalEvent{
  
}