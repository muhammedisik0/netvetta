import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/enum_constants.dart';
import '../constants/message_constants.dart';
import '../constants/route_constants.dart';
import '../constants/uri_constants.dart';
import '../helpers/dialog_helper.dart';
import '../helpers/snackbar_helper.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';
import '../services/storage_service.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/font_awesome_icon_button.dart';
import '../widgets/internet_connectivity_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _userCodeController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _passwordController = TextEditingController();

  String get password => _passwordController.text.trim();

  String get phoneNumber => _phoneNumberController.text.trim();

  String get userCode => _userCodeController.text.trim();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: InternetConnectivityWidget(
          online: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Netvetta Mağazam',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 40),
                      CustomTextField(
                        controller: _userCodeController,
                        hintText: 'Kullanıcı Kodu',
                        inputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        controller: _phoneNumberController,
                        hintText: '(502xxxxxxx)',
                        inputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        controller: _passwordController,
                        hintText: 'Şifre',
                        obscureText: true,
                        inputAction: TextInputAction.done,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 20),
                      MaterialButton(
                        onPressed: _onLogIn,
                        minWidth: double.infinity,
                        height: 48,
                        color: const Color(0xff009688),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Text('Giriş',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16)),
                      ),
                      const SizedBox(height: 10),
                      MaterialButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, RouteConstants.signUp),
                        minWidth: double.infinity,
                        height: 48,
                        color: const Color(0xffff8000),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Text('Üye Ol',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16)),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FontAwesomeIconButton(
                      onPressed: () => _launchUrl(UriConstants.instagram),
                      icon: FontAwesomeIcons.instagram,
                      color: const Color(0xffc2185b),
                    ),
                    const SizedBox(width: 20),
                    FontAwesomeIconButton(
                      onPressed: () => _launchUrl(UriConstants.facebook),
                      icon: FontAwesomeIcons.facebook,
                      color: const Color(0xff1877F2),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _userCodeController.dispose();
    _phoneNumberController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _launchUrl(String url) async {
    try {
      final uri = Uri.parse(url);

      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        if (!mounted) return;
        SnackBarHelper.showError(
            context, MessageConstants.unexpectedErrorOccurred);
      }
    } catch (e) {
      if (!mounted) return;
      SnackBarHelper.showError(
          context, MessageConstants.unexpectedErrorOccurred);
    }
  }

  void _onLogIn() async {
    if (userCode.isEmpty || phoneNumber.isEmpty || password.isEmpty) {
      SnackBarHelper.showError(
          context, MessageConstants.fillInTheRequiredFields);
      return;
    }

    DialogHelper.showLoadingIndicator(context);

    final user = User(
      id: -1,
      userCode: userCode,
      phoneNumber: phoneNumber,
      password: password,
    );

    await AuthService.logIn(user).then((status) {
      if (!mounted) return;

      Navigator.of(context).pop();

      switch (status) {
        case LoginStatus.success:
          StorageService.user = user;

          SnackBarHelper.showSuccess(
              context, MessageConstants.loggedInSuccessfully);

          Navigator.pushReplacementNamed(context, RouteConstants.pages);
          break;
        case LoginStatus.error:
          SnackBarHelper.showError(
              context, MessageConstants.incorrectCredentials);
          break;
        case LoginStatus.failure:
          SnackBarHelper.showError(
              context, MessageConstants.unexpectedErrorOccurred);
          break;
      }
    });
  }
}
