import 'package:comixnook_prj/components/custom_text_field.dart';
import 'package:comixnook_prj/components/password_text_field.dart';
import 'package:comixnook_prj/constants.dart';
import 'package:comixnook_prj/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/notification_service.dart';
import '../../viewmodels/auth_viewmodel.dart';
import '../../viewmodels/global_ui_viewmodel.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();

  bool _obscureTextPassword = true;
  bool _obscureTextPasswordConfirm = true;

  late GlobalUIViewModel _ui;
  late AuthViewModel _authViewModel;

  @override
  void initState() {
    _ui = Provider.of<GlobalUIViewModel>(context, listen: false);
    _authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    super.initState();
  }


  void register() async{
    if(_formKey.currentState == null || !_formKey.currentState!.validate()){
      return;
    }
    _ui.loadState(true);
    try{
      await _authViewModel.register(
          UserModel(
              email: _emailController.text,
              password: _passwordController.text,
              name: _nameController.text
          )).then((value) {

        NotificationService.display(
          title: "Welcome to this app",
          body: "Hello ${_authViewModel.loggedInUser?.name},\n Thank you for registering in this application.",
        );
        Navigator.of(context).pushReplacementNamed("/login");
      })
          .catchError((e){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message.toString())));
      });
    }catch(err){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(err.toString())));
    }
    _ui.loadState(false);
  }
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/ComixNookLogo2.png",
                    height: 150,
                    width: 150,
                  ),
                  SizedBox(height: 10,),
                  CustomTextField(
                    controller: _nameController,
                    validator: ValidateSignup.name,
                    keyboardType: TextInputType.name,
                    prefixIcon: Icons.person,
                    hintText: 'Full Name',
                  ),
                  SizedBox(height: 15),
                  CustomTextField(
                    controller: _emailController,
                    validator: ValidateSignup.emailValidate,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Icons.email,
                    hintText: 'Email Address',
                  ),
                  SizedBox(height: 15,),
                  PasswordTextField(
                    controller: _passwordController,
                    validator: (value) => ValidateSignup.password(value, _confirmPasswordController),
                    keyboardType: TextInputType.visiblePassword,
                    prefixIcon: Icons.lock,
                    hintText: 'Password',
                  ),
                  SizedBox(height: 15),
                  PasswordTextField(
                    controller: _confirmPasswordController,
                    validator: (value) => ValidateSignup.password(value, _passwordController),
                    keyboardType: TextInputType.visiblePassword,
                    prefixIcon: Icons.lock_clock,
                    hintText: 'Confirm Password',
                  ),
                  SizedBox(height: 30,),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(35),
                              )
                          ),
                          padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.symmetric(vertical: 20)),
                          backgroundColor: MaterialStateProperty.all<Color>(KPrimaryColor),
                        ),
                        onPressed: (){
                          register();
                        }, child: const Text("SIGNUP", style: TextStyle(
                        fontSize: 20,
                      color: KPrimaryLightColor,
                    ),)),
                  ),
                  SizedBox(height: 13,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account? ", style: TextStyle(
                        fontFamily: 'Gilroy',
                          color: Colors.grey.shade800,
                        fontSize: 18.5
                      ),),
                      InkWell(
                          onTap: (){
                            Navigator.of(context).pop();
                          },
                          child: Text("Sign in", style: TextStyle(color: Colors.deepPurpleAccent,
                              fontSize: 18.5,fontWeight: FontWeight.w500,fontFamily: 'Gilroy'),))
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

class ValidateSignup{
  static String? name(String? value){
    if(value == null || value.isEmpty ){
      return "Name is required";
    }
    return null;
  }
  static String? emailValidate(String? value){

    final RegExp emailValid =
    RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if(value == null || value.isEmpty ){
      return "Email is required";
    }
    if(!emailValid.hasMatch(value)){
      return "Please enter a valid email";
    }
    return null;
  }
  static String? password(String? value, TextEditingController otherPassword){
    if(value == null || value.isEmpty ){
      return "Password is required";
    }
    if(value.length < 8){
      return "Password should be at least 8 character";
    }
    if(otherPassword.text != value){
      return "Please make sure both the password are the same";
    }
    return null;
  }
}
