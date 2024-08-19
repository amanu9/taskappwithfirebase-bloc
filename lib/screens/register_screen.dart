// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:taskappwithblocandfirebase/screens/login_screen.dart';

// class RegisterScreen extends StatefulWidget {
//   const RegisterScreen({super.key});
//   static const id = 'register_screen';

//   @override
//   State<RegisterScreen> createState() => _RegisterScreenState();
// }

// class _RegisterScreenState extends State<RegisterScreen> {
//   final _formKey = GlobalKey<FormState>();

//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   bool _isLoading = false;
//   bool _obscureText = true;

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.white,
        
//         body: Padding(
//           padding: const EdgeInsets.all(30.0),
//           child: Column(
//             children: [
          
              
               
//                   const Text("Wel-come To My-Task App ",style: TextStyle(color: Colors.redAccent,fontSize: 20),),
              
              
             
//               const SizedBox(height: 40),  
                
//               Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Image.asset(
//                                 "assets/images/profile.jpg",
//                                 height: MediaQuery.of(context).size.height * .2,
//                                 width: MediaQuery.of(context).size.width * .3,
                                
//                               )
//                             ],
//                           ),
//               Form(
//                 key: _formKey,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       child: TextFormField(
//                         controller: _emailController,
//                         decoration: InputDecoration(
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           labelText: 'Insert email',
//                         ),
//                         keyboardType: TextInputType.emailAddress,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Email is required';
//                           } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
//                             return 'Enter a valid email address';
//                           }
//                           return null;
//                         },
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       child: TextFormField(
//                         controller: _passwordController,
//                          obscureText: _obscureText,
//                         decoration: InputDecoration(
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           labelText: 'Insert password',
//                           suffixIcon: IconButton(
//                             onPressed: () {
//                               setState(() {
//                                 _obscureText = !_obscureText;
//                               });
//                             },
//                             icon: Icon(
//                               _obscureText
//                                 ? Icons.visibility
//                                 : Icons.visibility_off),
//                           ),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Password is required';
//                           } else if (value.length < 6) {
//                             return 'Password should be at least 6 characters';
//                           }
//                           return null;
//                         },
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     SizedBox(
//                       width: double.infinity,
//                       height: 60,
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.black,
//                         ),
//                         onPressed: _isLoading
//                             ? null
//                             : () async {
//                                 final isValid = _formKey.currentState!.validate();
//                                 if (!isValid) {
//                                   return;
//                                 }
//                                 setState(() {
//                                   _isLoading = true; // Set loading to true
//                                 });
              
//                                 try {
//                                   await _auth.createUserWithEmailAndPassword(
//                                       email: _emailController.text.trim(),
//                                       password: _passwordController.text.trim());
//                                   Navigator.pushReplacementNamed(
//                                       context, LoginScreen.id);
//                                 } on FirebaseAuthException catch (e) {
//                                   if (e.code == 'email-already-in-use') {
//                                     final snackBar = SnackBar(
//                                       content: Text(
//                                         "The email address is already in use by another user.",
//                                         style: TextStyle(color: Colors.white),
//                                       ),
//                                       backgroundColor: Colors.red,
//                                       duration: Duration(milliseconds: 3000),
//                                     );
//                                     ScaffoldMessenger.of(context)
//                                         .showSnackBar(snackBar);
//                                   } else {
//                                     final snackBar = SnackBar(
//                                       content: Text(
//                                         "Something went wrong. Please try again.",
//                                         style: TextStyle(color: Colors.white),
//                                       ),
//                                       backgroundColor: Colors.red,
//                                       duration: Duration(milliseconds: 3000),
//                                     );
//                                     ScaffoldMessenger.of(context)
//                                         .showSnackBar(snackBar);
//                                   }
//                                 } finally {
//                                   setState(() {
//                                     _isLoading = false; // Set loading to false
//                                   });
//                                 }
//                               },
//                         child: _isLoading
//                             ? CircularProgressIndicator(
//                                 color: Colors.orangeAccent,
//                               )
//                             : const Text(
//                                 'Register',
//                                 style: TextStyle(color: Colors.white, fontSize: 16),
//                               ),
//                       ),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         Navigator.of(context).pushNamed(LoginScreen.id);
//                       },
//                       child: const Text(
//                         'Already have an Account',
//                         style: TextStyle(color: Colors.blueAccent),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Align(
//                 child: Positioned(
//                   bottom: 0,
                  
                  
                  
                  
//                   child: const Text("Powered by Amanuel@gmail.com",style: TextStyle(fontSize: 12,color: Colors.red),)
                
                
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taskappwithblocandfirebase/screens/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const id = 'register_screen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const Text(
                    "Wel-come To My-Task App",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  const SizedBox(height: 40),
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
                              } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                  .hasMatch(value)) {
                                return 'Enter a valid email address';
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
                                icon: Icon(_obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off),
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
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          height: 60,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                            ),
                            onPressed: _isLoading
                                ? null
                                : () async {
                                    final isValid =
                                        _formKey.currentState!.validate();
                                    if (!isValid) {
                                      return;
                                    }
                                    setState(() {
                                      _isLoading = true;
                                    });

                                    try {
                                      await _auth
                                          .createUserWithEmailAndPassword(
                                              email: _emailController.text.trim(),
                                              password:
                                                  _passwordController.text.trim());
                                      Navigator.pushReplacementNamed(
                                          context, LoginScreen.id);
                                    } on FirebaseAuthException catch (e) {
                                      if (e.code == 'email-already-in-use') {
                                        final snackBar = SnackBar(
                                          content: Text(
                                            "The email address is already in use by another user.",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          backgroundColor: Colors.red,
                                          duration:
                                              Duration(milliseconds: 3000),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      } else {
                                        final snackBar = SnackBar(
                                          content: Text(
                                            "Something went wrong. Please try again.",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          backgroundColor: Colors.red,
                                          duration:
                                              Duration(milliseconds: 3000),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      }
                                    } finally {
                                      setState(() {
                                        _isLoading = false;
                                      });
                                    }
                                  },
                            child: _isLoading
                                ? CircularProgressIndicator(
                                    color: Colors.orangeAccent,
                                  )
                                : const Text(
                                    'Register',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(LoginScreen.id);
                          },
                          child: const Text(
                            'Already have an Account',
                            style: TextStyle(color: Colors.blueAccent),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Text("Powered by Amanuel@gmail.com",style: TextStyle(color: Colors.red),),
            ],
          ),
        ),
      ),
    );
  }
}


