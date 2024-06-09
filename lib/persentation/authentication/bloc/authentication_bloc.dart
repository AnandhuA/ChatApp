import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<SignupButtonClickEvent>(_signupButtonClick);
    on<LoginButtonClickEvent>(_loginButtonClick);
  }

  FutureOr<void> _signupButtonClick(
    SignupButtonClickEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(SignupLoadingState());

    final CollectionReference user =
        FirebaseFirestore.instance.collection("Users");
    try {
      await _auth.createUserWithEmailAndPassword(
          email: event.email, password: event.password);
      if (_auth.currentUser!.email != null) {
        user.doc(_auth.currentUser!.email).set(
          {"Name": event.name, "Phone": event.phone},
        );
        return emit(SignupSuccessState());
      }
    } on FirebaseAuthException catch (e) {
      return emit(SignupErrorState(error: e.code));
    }
  }

  FutureOr<void> _loginButtonClick(
    LoginButtonClickEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(LoginLoadingState());

    try {
      await _auth.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      if (_auth.currentUser != null) {
        return emit(LoginSuccessState());
      }
    } on FirebaseAuthException catch (e) {
      return emit(LoginErrorState(error: e.code));
    }
  }
}
