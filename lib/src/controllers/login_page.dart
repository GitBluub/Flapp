import 'package:flutter/material.dart';
import 'package:flapp/src/views/login_page.dart';

/// Controller for Login Page, where the user will be authenticated
class LoginPageController extends StatelessWidget {
  const LoginPageController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const LoginPageView();
  }
}