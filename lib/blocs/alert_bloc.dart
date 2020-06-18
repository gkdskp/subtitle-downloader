import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subtitle_downloader/components/alert_dialog.dart';



abstract class AlertEvents {
  String AlertMsg;
}

class NewAlert extends AlertEvents {
  String alertMsg;

  NewAlert(this.alertMsg);
}

class ResetAlert extends AlertEvents {}
class LoadingStart extends AlertEvents {}


class AlertBloc extends Bloc<AlertEvents, Map<String, dynamic>> {
  @override
  Map<String, dynamic> get initialState => {
    'hasAlert': false
  };

  @override
  Stream<Map<String, dynamic>> mapEventToState(AlertEvents event) async* {
    if(event is NewAlert) {
      yield {
        'hasAlert': true,
        'alertMsg': event.alertMsg,
        'alertType': DialogType.MessageDialog
      };
    } else if(event is ResetAlert) {
      yield {
        'hasAlert': false
      };
    } else if(event is LoadingStart) {
      yield {
        'hasAlert': true,
        'alertMsg': 'Loading',
        'alertType': DialogType.Loading
      };
    }
  }
}