import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ppkd_b6/NextSlide.dart';
import 'package:ppkd_b6/extension.dart';

class Formlogin extends StatefulWidget {
  const Formlogin({super.key});
  static const String routeName = "/signin";

  @override
  State<Formlogin> createState() => _FormloginState();
}

class _FormloginState extends State<Formlogin> {
  final _formKey = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.all(35),
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFF6F1EE), Color.fromARGB(255, 214, 236, 238)],
            ),
          ),

          child: Center(
            child: Container(
              width: 320,
              height: 650,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(35),
              ),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 70,
                    width: 70,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/images/kp2_dm.gif"),
                      ),
                    ),
                  ),

                  Text(
                    "Hi Kata",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF7C9A92),
                    ),
                  ),

                  Text(
                    "Make Easy.",
                    style: TextStyle(fontSize: 14, color: Color(0xFF7C9A92)),
                  ),

                  SizedBox(height: 10),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 5,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                        child: TextFormField(
                          controller: emailcontroller,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            hintText: "Masukkan Email Anda",
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF7C9A92)),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF7C9A92)),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Email tidak boleh kosong";
                            } else if (!value.contains('@')) {
                              return "Format Email tidak valid";
                            }
                            return null;
                          },
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                        child: TextFormField(
                          controller: passwordcontroller,
                          obscureText: true,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.key),
                            hintText: "Masukkan Password Anda",
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF7C9A92)),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF7C9A92)),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Password tidak boleh kosong";
                            } else if (value.length < 6) {
                              return "Password Anda Terlalu Singkat";
                            }
                            return null;
                          },
                        ),
                      ),

                      SizedBox(height: 10),

                      Container(
                        margin: EdgeInsets.only(right: 22),

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,

                          children: [
                            GestureDetector(
                              onTap: () {
                                print("Forgot Password Clicked");
                              },
                              child: Text("Forgot Password?"),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                print("Sudah memenuhi syarat");
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Berhasil"),
                                      content: Text("Anda berhasil login"),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            context.push(
                                              Nextslide2(
                                                password:
                                                    passwordcontroller.text,
                                                email: emailcontroller.text,
                                              ),
                                            );
                                          },
                                          child: Text("Lanjut"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            },

                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF7C9A92),
                            ),

                            child: Text(
                              "Sign In",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 10),
                      Center(child: Text("OR")),

                      Container(
                        margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                print("Sudah memenuhi syarat");
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Berhasil"),
                                      content: Text("Anda berhasil login"),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("Lanjut"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            },

                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF7C9A92),
                            ),

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "   Continue with Google",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      Center(
                        child: Text.rich(
                          TextSpan(
                            text: "Akun Baru?",
                            children: [
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Navigator.pop(context),
                                text: " Create an account",
                                style: TextStyle(color: Color(0xFF7C9A92)),
                              ),
                            ],
                          ),
                        ),
                      ),
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
