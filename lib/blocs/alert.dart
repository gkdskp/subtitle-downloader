import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subtitle_downloader/components/alert_dialog.dart';

class AlertEvent {}

class ShowAlertEvent extends AlertEvent {
  AlertBox alertBox;

  ShowAlertEvent(this.alertBox);
}

class HideAlertEvent extends AlertEvent {}

class AlertBloc extends Bloc<AlertEvent, Map<String, dynamic>> {
  AlertBloc();

  @override
  Map<String, dynamic> get initialState =>
      {'hasAlert': false, 'alertBox': null};

  @override
  Stream<Map<String, dynamic>> mapEventToState(AlertEvent event) async* {
    if (event is ShowAlertEvent) {
      yield {
        'hasAlert': true,
        'alertBox': event.alertBox
      };
    } else {
      yield {
        'hasAlert': false,
        'alertBox': null,
      };
    }
  }
}
