import 'dart:async';

class Validators {
  // final validateMobile = StreamTransformer<String, String>.fromHandlers(
  //     handleData: (mobile, sink) {
  //   RegExp regExp = new RegExp(r'(^\+?09[0-9]{9}$)');
  //   if ((!regExp.hasMatch(mobile)) && (mobile.length == 10)) {
  //     sink.add(mobile);
  //   } else {
  //     sink.addError('Enter a valid mobile number');
  //   }
  // });

  final validateEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (email.contains('@')) {
      sink.add(email);
    } else {
      sink.addError('Please enter a valid email');
    }
  });

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink) {
      if (password.length > 5) {
        sink.add(password);
      } else {
        sink.addError('Password must be at least 6 characters');
      }
    },
  );
}
