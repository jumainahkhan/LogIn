import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:login/Screens/login/login.dart';
import 'package:login/Screens/signup/sign_up_two.dart';
import 'package:login/components/my_button.dart';
import 'package:login/controller/sign_up_controller.dart';

List<String> list = <String>['Student', 'Teacher', 'Alumni'];

class SignUpOne extends StatefulWidget {
  const SignUpOne({super.key});

  @override
  State<SignUpOne> createState() => _SignUpOneState();
}

class _SignUpOneState extends State<SignUpOne> {
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  SignUpController signUpController = Get.put(SignUpController());

  Future signUserUp() async {
    // create user

    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.string, password: passwordController.string);

    //add user details
    // addUserDetails(
    //     dropDownController, emailController.string, passwordController.string);
  }

  // Future addUserDetails(String dropDown, String email, String password) async {
  //   await FirebaseFirestore.instance.collection("user").add({
  //     "userType": dropDown,
  //     "email": email,
  //     "password": password,
  //   });
  // }

  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    debugPrint(signUpController.userType);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: HexColor("#fed8c3"),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(0, 400, 0, 0),
          shrinkWrap: true,
          reverse: true,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Stack(
                  children: [
                    Container(
                      height: 535,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: HexColor("#ffffff"),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                        child: Column(
                          children: [
                            Text(
                              "Sign Up",
                              style: GoogleFonts.poppins(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: HexColor("#4f4f4f"),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 0, 0, 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "User Type",
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      color: HexColor("#8d8d8d"),
                                    ),
                                  ),
                                  DropdownButton<String>(
                                    value: dropdownValue,
                                    icon: const Icon(Icons.arrow_drop_down),
                                    elevation: 16,
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      color: HexColor("#8d8d8d"),
                                    ),
                                    isExpanded: true,
                                    underline: Container(
                                      height: 2,
                                      color: HexColor("#ffffff"),
                                    ),
                                    iconSize: 30,
                                    borderRadius: BorderRadius.circular(20),
                                    onChanged: (String? value) {
                                      setState(() {
                                        dropdownValue = value!;
                                        signUpController.setUserType(value);
                                      });
                                    },
                                    items: list.map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                  const SizedBox(
                                    height: 1,
                                  ),
                                  Text(
                                    "Email",
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      color: HexColor("#8d8d8d"),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  TextField(
                                    controller: emailController.value,
                                    cursorColor: HexColor("#4f4f4f"),
                                    decoration: InputDecoration(
                                      hintText: "hello@gmail.com",
                                      fillColor: HexColor("#f0f3f1"),
                                      contentPadding: const EdgeInsets.fromLTRB(
                                          20, 20, 20, 20),
                                      hintStyle: GoogleFonts.poppins(
                                        fontSize: 15,
                                        color: HexColor("#8d8d8d"),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide.none,
                                      ),
                                      filled: true,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    "Password",
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      color: HexColor("#8d8d8d"),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  TextField(
                                    obscureText: true,
                                    controller: passwordController.value,
                                    cursorColor: HexColor("#4f4f4f"),
                                    decoration: InputDecoration(
                                      hintText: "*************",
                                      fillColor: HexColor("#f0f3f1"),
                                      contentPadding: const EdgeInsets.fromLTRB(
                                          20, 20, 20, 20),
                                      hintStyle: GoogleFonts.poppins(
                                        fontSize: 15,
                                        color: HexColor("#8d8d8d"),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide.none,
                                      ),
                                      filled: true,
                                      focusColor: HexColor("#44564a"),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  MyButton(
                                      buttonText: 'Proceed',
                                      onPressed: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const SignUpTwo(),
                                            ),
                                          )),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(35, 0, 0, 0),
                                    child: Row(
                                      children: [
                                        Text("Already have an account?",
                                            style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              color: HexColor("#8d8d8d"),
                                            )),
                                        TextButton(
                                          child: Text(
                                            "Log In",
                                            style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              color: HexColor("#44564a"),
                                            ),
                                          ),
                                          onPressed: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const LoginScreen(),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Transform.translate(
                        offset: const Offset(0, -253),
                        child: Image.asset(
                          'assets/Images/plants2.png',
                          scale: 1.5,
                          width: double.infinity,
                        )),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
