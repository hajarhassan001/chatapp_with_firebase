import 'package:bloc/bloc.dart';
import 'package:chatapp/features/authentication/data/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  XFile? profileImage;

  TextEditingController emailup = TextEditingController();
  TextEditingController passup = TextEditingController();
  TextEditingController cpassup = TextEditingController();
  TextEditingController nameup = TextEditingController();
  TextEditingController phoneup = TextEditingController();

  TextEditingController nameUpdate = TextEditingController();
  TextEditingController phoneUpdate = TextEditingController();

  upLuodImage(XFile img) async {
    profileImage = img;
    emit(UpLuodImage());
  }

  signIn() async {
    try {
      emit(AuthLoading());
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email.text, password: pass.text);
      emit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      emit(AuthError(message: e.code));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  signUp() async {
    try {
      emit(SignUpLouding());
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailup.text, password: passup.text);
      addUser(UserModel(
          name: nameup.text,
          email: emailup.text,
          password: passup.text,
          phone: phoneup.text,
          cpassword: cpassup.text));
      emit(SignUpSuccess());
      FirebaseAuth.instance.currentUser!.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      emit(SignUpError(e.code));
    } catch (e) {
      emit(SignUpError(e.toString()));
    }
  }

  signInWithGoogle() async {
    // Trigger the authentication flow
    try {
      emit(GoogleSignInLouding());
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      await FirebaseAuth.instance.signInWithCredential(credential);
      emit(GoogleSignInSuccess());
    } catch (e) {
      emit(GoogleSignInError(e.toString()));
    }
  }

  final user = FirebaseFirestore.instance.collection("user");
  addUser(UserModel userModel) async {
    await user.add({
      "name": userModel.name,
      "email": userModel.email,
      "phone": userModel.phone,
      "password": userModel.password,
      "cpassword": userModel.cpassword,
    });
  }

  getUserDate() async {}
}
