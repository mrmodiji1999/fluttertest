import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fluttertest/api/bloc/api_event.dart';
import 'package:fluttertest/api/bloc/api_state.dart';
import 'package:fluttertest/api/postrepo/postrepo.dart';
import 'package:fluttertest/api/utils.dart/enum.dart';
import 'package:fluttertest/model/usermodel.dart';

class ApisBloc extends Bloc<ApisEvent, ApisState> {
  Postrepo postrepo = Postrepo();
  ApisBloc() : super(ApisState()) {
    on<PostfetchEvent>(postfetchEvent);
  }

 FutureOr<void> postfetchEvent(PostfetchEvent event, Emitter<ApisState> emit)async {
 await postrepo.fetchpost().then((value) {
print(value);
print('dajsd');
    emit(state.copyWith(
        poststatus: Poststatus.success, message: 'message', ));
  }).onError((error, stackTrace) {
    emit(state.copyWith(
        poststatus: Poststatus.failure, message: error.toString()));
  });
}

}
