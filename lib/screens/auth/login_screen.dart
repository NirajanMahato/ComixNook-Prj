import 'package:comixnook_prj/components/custom_text_field.dart';
import 'package:comixnook_prj/components/password_text_field.dart';
import 'package:comixnook_prj/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/notification_service.dart';
import '../../viewmodels/auth_viewmodel.dart';
import '../../viewmodels/global_ui_viewmodel.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool _obscureTextPassword = true;

  final _formKey = GlobalKey<FormState>();

  void login() async {
    if (_formKey.currentState == null || !_formKey.currentState!.validate()) {
      return;
    }
    _ui.loadState(true);
    try {
      await _authViewModel
          .login(_emailController.text, _passwordController.text)
          .then((value) {
        NotificationService.display(
          title: "Welcome back",
          body:
              "Hello ${_authViewModel.loggedInUser?.name},\n Hope you are having a wonderful day.",
        );
        Navigator.of(context).pushReplacementNamed('/dashboard');
      }).catchError((e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.message.toString())));
      });
    } catch (err) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(err.toString())));
    }
    _ui.loadState(false);
  }

  late GlobalUIViewModel _ui;
  late AuthViewModel _authViewModel;
  @override
  void initState() {
    _ui = Provider.of<GlobalUIViewModel>(context, listen: false);
    _authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/ComixNookLogo2.png",
                    height: 170,
                    width: 170,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: ValidateLogin.emailValidate,
                    prefixIcon: Icons.email,
                    hintText: 'Your Email',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  PasswordTextField(
                    controller: _passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    validator: ValidateLogin.password,
                    prefixIcon: Icons.lock,
                    hintText: 'Your Password',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed("/forget-password");
                        },
                        child: Text(
                          "Forgot password?",
                          style: TextStyle(color: Colors.grey.shade800,fontFamily: 'Gilroy',fontSize: 18.0),
                        ),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(35),
                                    side: BorderSide.none,
                                  )
                              ),
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.symmetric(vertical: 19)),
                          backgroundColor: MaterialStateProperty.all<Color>(KPrimaryColor),
                        ),
                        onPressed: () {
                          login();
                        },
                        child: Text(
                          "LOGIN",
                          style: TextStyle(
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.w400,
                              fontSize: 22,
                              color: KPrimaryLightColor),
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w500,
                            fontSize: 18.5,
                            color: Colors.grey.shade800),
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed("/register");
                          },
                          child: Text(
                            "Sign up",
                            style: TextStyle(
                                fontFamily: 'Gilroy',
                                fontSize: 18.5,
                                color: Colors.deepPurpleAccent),
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ValidateLogin {
  static String? emailValidate(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is required";
    }

    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }
    return null;
  }
}
