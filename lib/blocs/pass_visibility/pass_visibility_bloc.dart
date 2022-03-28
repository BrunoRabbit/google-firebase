import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'pass_visibility_event.dart';
part 'pass_visibility_state.dart';

class PassVisibilityBloc
    extends Bloc<PassVisibilityEvent, PassVisibilityState> {
  PassVisibilityBloc() : super(const PassVisibilityState(true)) {
    on<ChangeVisibility>((event, emit) {
      emit(
        PassVisibilityState(event.isObscureText),
      );
    });
  }
}
