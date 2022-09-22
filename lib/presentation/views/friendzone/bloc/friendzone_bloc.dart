import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'friendzone_event.dart';
part 'friendzone_state.dart';

class FriendzoneBloc extends Bloc<FriendzoneEvent, FriendzoneState> {
  FriendzoneBloc() : super(FriendzoneInitial()) {
    on<FriendzoneEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
