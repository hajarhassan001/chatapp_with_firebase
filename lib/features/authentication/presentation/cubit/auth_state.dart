part of 'auth_cubit.dart';


@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

 class AuthLoading extends AuthState {}
 class AuthSuccess extends AuthState {
 }
 class AuthError extends AuthState {
  final String message;

  AuthError({required this.message});
 }



 class UpLuodImage extends AuthState{
}




 class SignUpLouding extends AuthState{}
 class SignUpSuccess extends AuthState{

  SignUpSuccess();
 }
 class SignUpError extends AuthState{
     final String message;
  SignUpError(this.message);

 }




 class GoogleSignInLouding extends AuthState{}
 class GoogleSignInSuccess extends AuthState{

 GoogleSignInSuccess();
 }
 class GoogleSignInError extends AuthState{
     final String message;
 GoogleSignInError(this.message);

 }





class GetUserLouding extends AuthState{}
class GetUserSuccess extends AuthState{

  GetUserSuccess();
}
class GetUserError extends AuthState{
  final String message;

  GetUserError( this.message);

}



