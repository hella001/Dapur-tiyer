import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop/components/custom_surfix_icon.dart';
import 'package:shop/components/form_error.dart';
import 'package:shop/helper/keyboard.dart';
import 'package:shop/models/loginData.dart';
import 'package:shop/screens/forgot_password/forgot_password_screen.dart';
import 'package:shop/screens/login_success/login_success_screen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../components/default_button.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool? remember = false;
  final List<String?> errors = [];

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  setdata() async {
    SharedPreferences statusLogin = await SharedPreferences.getInstance();
    statusLogin.setInt('status', 1);
  }

  Future<void> login(String email, password) async {
    try {
      final url = "http://perusnia.tk/api/login.php?api_key=fasih123";

      var requestBody = {
        'email': email,
        'password': password,
      };

      http.Response response =
          await http.post(Uri.parse(url), body: requestBody);

      var data = jsonDecode(response.body);
      if (data["error"] == false) {
        setdata();
        Navigator.pushNamed(context, LoginSuccessScreen.routeName);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data['message']),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          DefaultButton(
            text: "Masuk",
            press: () {
              Navigator.pushNamed(context, LoginSuccessScreen.routeName);
              //login(emailController.text, passwordController.text);
            },
          )
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      controller: passwordController,
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Masukkan sandi",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Masukkan email",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
}
