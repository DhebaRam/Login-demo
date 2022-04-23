import 'package:flutter/material.dart';
import 'package:project/login/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var userName = TextEditingController();
  var userEmail = TextEditingController();
  var userPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      key: _formKey,
      child: SingleChildScrollView(
          child: Column(children: [
        const SizedBox(
          height: 100,
        ),
        Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          const Text(
            "Sign up",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Create an Account,Its free",
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey[700],
            ),
          ),
        ]),
        const SizedBox(
          height: 50,
        ),
        Container(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: TextFormField(
            controller: userName,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'UserName',
              suffixIcon: Icon(Icons.account_box),
            ),
            onFieldSubmitted: (value) {},
            validator: (value) {
              if (value!.isEmpty) {
                return "* Required";
              } else if (value != userName.text) {
                return "Invalid User Name";
              }
              return null;
            },
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Container(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: TextFormField(
            controller: userEmail,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Email',
              suffixIcon: Icon(Icons.account_box),
            ),
            onFieldSubmitted: (value) {},
            validator: (value) {
              if (value!.isEmpty) {
                return "* Required";
              } else if (value != userEmail.text) {
                return "Invalid Email";
              }
              return null;
            },
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Container(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: TextFormField(
            controller: userPassword,
            textInputAction: TextInputAction.next,
            obscureText: true,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Password',
              suffixIcon: Icon(Icons.visibility_off),
            ),
            onFieldSubmitted: (value) {},
            validator: (value) {
              if (value!.isEmpty) {
                return "* Required";
              } else if (value.length < 4) {
                return "Minimum password length 4";
              } else if (value != userPassword.text) {
                return "Invalid Password";
              }
              return null;
            },
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: MaterialButton(
            minWidth: double.infinity,
            height: 60,
            onPressed: () async {
              final isValid = _formKey.currentState!.validate();
              if (!isValid) {
                return;
              }
              _formKey.currentState!.save();
              final pref = await SharedPreferences.getInstance();
              setState(() {
                pref.setString("userName", userName.text);
                pref.setString("userEmail", userEmail.text);
                pref.setString("userPassword", userPassword.text);
              });
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const Login()));
            },
            color: Colors.redAccent,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            child: const Text(
              "Sign Up",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Already have an account? "),
            TextButton(
                onPressed: () async {

                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  //pref.remove("user");
                  pref.remove('email');
                  pref.remove('password');

                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const Login()));
                },
                child: const Text(
                  "Login",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ))
          ],
        ),
        const SizedBox(
          height: 30,
          width: double.infinity,
        )
      ])),
    ));
  }
}
