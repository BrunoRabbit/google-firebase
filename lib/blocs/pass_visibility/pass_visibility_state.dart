part of 'pass_visibility_bloc.dart';

class PassVisibilityState extends Equatable {
  final bool isObscureText;

  const PassVisibilityState(this.isObscureText);

  @override
  List<Object?> get props => [isObscureText];
}
