import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get_storage/get_storage.dart';
import 'package:taskappwithblocandfirebase/screens/tabs_screen.dart';
import '../screens/register_screen.dart';
import 'package:flutter/material.dart';
import '../screens/forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const id = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false; // Track loading state
  bool _obscureText = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Text(
                        "Wel-come Back",
                        style:
                            TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .05,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/profile.jpg",
                            height: MediaQuery.of(context).size.height * .2,
                            width: MediaQuery.of(context).size.width * .3,
                          ),
                        ],
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextFormField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  labelText: 'Insert email',
                                ),
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Email is required';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextFormField(
                                controller: _passwordController,
                                obscureText: _obscureText,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  labelText: 'Insert password',
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _obscureText = !_obscureText;

                                      });
                                    },
                                    icon: Icon(
                                      _obscureText
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Password is required';
                                  } else if (value.length < 6) {
                                    return 'Password should be at least 6 characters';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: SizedBox(
                                width: double.infinity,
                                height: 60,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black,
                                  ),
                                  onPressed: _isLoading
                                      ? null
                                      : () async {
                                          final isValid = _formKey
                                              .currentState!
                                              .validate();
                                          if (isValid) {
                                            setState(() {
                                              _isLoading =
                                                  true; // Show loading indicator
                                            });
                                            try {
                                              await _auth
                                                  .signInWithEmailAndPassword(
                                                      email: _emailController
                                                          .text
                                                          .trim(),
                                                      password:
                                                          _passwordController
                                                              .text
                                                              .trim())
                                                  .then((value) {
                                                // Save user token on local storage
                                                GetStorage().write('token',
                                                    value.user!.uid);
                                                print(
                                                    "user id is ${GetStorage().read('token')}");
                                                //to save email in local memory
                                                GetStorage().write(
                                                    'email',
                                                    value.user!.email);
                                                // Navigate to the TabsScreen
                                                Navigator
                                                    .pushReplacementNamed(
                                                        context,
                                                        TabsScreen.id);
                                              });
                                            } on FirebaseAuthException catch (e) {
                                              var snackbar = SnackBar(
                                                content: Text(
                                                  "Incorrect username or password",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                backgroundColor: Colors.red,
                                                duration: Duration(
                                                    milliseconds: 3000),
                                              );
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackbar);
                                            } finally {
                                              setState(() {
                                                _isLoading =
                                                    false; // Hide loading indicator
                                              });
                                            }
                                          }
                                        },
                                  child: _isLoading
                                      ? CircularProgressIndicator(
                                          color: Colors.orangeAccent,
                                        )
                                      : const Text(
                                          'Login',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(RegisterScreen.id);
                              },
                              child: const Text(
                                'Don\'t have an Account?',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(ForgotPasswordScreen.id);
                              },
                              child: const Text('Forget Password'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Text(
                "Powered by Amanuel@gmail.com",
                style: TextStyle(color: Colors.redAccent),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
