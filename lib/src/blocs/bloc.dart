import 'dart:async';
import 'package:happy_shouket/src/blocs/repository.dart';

import 'authorisation_bloc.dart';
import 'validators.dart';
import 'package:rxdart/rxdart.dart';

class Bloc extends Object with Validators {
  Repository repository = Repository();

  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _loadingData = PublishSubject<bool>();

  // Add data to stream using Dart Getters

  Stream<String> get email => _emailController.stream.transform(validateEmail);
  Stream<String> get password =>
      _passwordController.stream.transform(validatePassword);
  Stream<bool> get submitValid =>
      Rx.combineLatest2(email, password, (m, p) => true);
  Stream<bool> get loading => _loadingData.stream;

  // Change data from stream using Dart Getters
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  void submit() {
    final validEmail = _emailController.value;
    final validPassword = _passwordController.value;
    _loadingData.sink.add(true);

    print('Email is $validEmail');
    print('Password is $validPassword');

    login(validEmail, validPassword);
  }

  login(String email, String password) async {
    String token = await repository.login(email, password);
    _loadingData.sink.add(false);
    authBloc.openSession(token);
  }

  dispose() {
    _emailController.close();
    _passwordController.close();
    _loadingData.close();
  }
}
