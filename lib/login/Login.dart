import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project/login/Home.dart';
import 'package:project/login/SignUp.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var passwordController = TextEditingController();
  var emailController = TextEditingController();
  //var userController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? userEmail = "";
  String? userName = "";
  String? userPassword = "";


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 100,
              ),
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Welcome back ! Login ",
                      //with your credentials
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[700],
                      ),
                    ),
                  ]),
              const SizedBox(
                height: 35,
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: TextFormField(
                  controller: emailController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    suffixIcon: Icon(Icons.email),
                  ),
                  //onFieldSubmitted: (value) {},
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "* Required";
                    } else if (value != emailController.text) {
                      return "Invalid User Name";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: TextFormField(
                  obscureText: true,
                  controller: passwordController,
                  keyboardType: TextInputType.number,
                  onFieldSubmitted: (value) {},
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "* Required";
                    } else if (value.length < 4) {
                      return "Minimum password length 4";
                    } else if (value != passwordController.text) {
                      return "Invalid Password";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.visibility_off),
                    labelText: 'Password.',
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: MaterialButton(
                  minWidth: double.infinity,
                  color: Colors.blue,
                  height: 60,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
                  onPressed: () async {
                    final isValid = _formKey.currentState!.validate();
                    if (!isValid) {
                      return;
                    }
                    _formKey.currentState!.save();
                    final pref = await SharedPreferences.getInstance();
                     String? userEmail =
                    pref.getString("userEmail");
                     String? userPassword =
                    pref.getString("userPassword");
                    setState(() {
                      pref.setString("email", emailController.text);
                      pref.setString("password", passwordController.text);
                    });
                    if (emailController.text == userEmail &&
                        passwordController.text ==userPassword) {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const Home()));
                    }
                    else if(emailController.text != userEmail && passwordController.text == userPassword)
                    {
                       showEmail();
                      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      //   content: Text("Invalid User Email")));
                    }
                    else if(emailController.text == userEmail && passwordController.text != userPassword)
                      {
                         showPassword();
                        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        //   content: Text("Invalid Password"),));
                      }
                    else{
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Invalid '),
                      ));
                    }
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Does not have account?"),
                  TextButton(
                      onPressed: () async {
                        SharedPreferences pref =
                            await SharedPreferences.getInstance();
                        pref.remove("userEmail");
                        pref.remove("userName");
                        pref.remove("userPassword");
                        pref.clear();

                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const SignUp()));
                      },
                      child: const Text(
                        "Sign In",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void getPref() async {
    final pref = await SharedPreferences.getInstance();
    userEmail = pref.getString("userEmail");
    userPassword = pref.getString("userPassword");
  }

  Future<void> showEmail() => Fluttertoast.showToast(msg: "Invalid User Email",fontSize: 20);
  Future<void> showPassword() => Fluttertoast.showToast(msg: "Invalid User Email",fontSize: 20);
}


