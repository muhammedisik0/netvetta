import '../models/user_model.dart';

String buildLoginJavaScript(User user) {
  return '''
    var userCodeField = document.querySelector('input[name=kk]');
    var phoneNumberField = document.querySelector('input[name=tel]');
    var passwordField = document.querySelector('input[name=parola]');
    var loginButton = document.querySelector('button');
    userCodeField.value = '${user.code}';
    phoneNumberField.value = '${user.phoneNumber}';
    passwordField.value = '${user.password}';
    loginButton.click();
  ''';
}

int extractUserIdFromUrl(String url) {
  final pattern = RegExp(r'[^0-9]');
  final id = url.replaceAll(pattern, '');
  return int.parse(id);
}
