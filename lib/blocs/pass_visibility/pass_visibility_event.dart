part of 'pass_visibility_bloc.dart';

class PassVisibilityEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChangeVisibility extends PassVisibilityEvent {
  final bool isObscureText;
  ChangeVisibility(this.isObscureText);

  @override
  List<Object> get props => [isObscureText];
}
