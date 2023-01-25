import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:login/Screens/homepage/home_page.dart';
import 'package:login/components/my_button.dart';
import 'package:login/controller/sign_up_controller.dart';

class SignUpThree extends StatefulWidget {
  const SignUpThree({super.key});

  @override
  State<SignUpThree> createState() => _SignUpThreeState();
}

class _SignUpThreeState extends State<SignUpThree> {
  SignUpController signUpController = Get.put(SignUpController());
  Future signUserUp() async {
    // create user

    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: signUpController.email.toString(),
        password: signUpController.password.toString());
  }

  @override
  Widget build(BuildContext context) {
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
              crossAxisAlignment: CrossAxisAlignment.end,
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
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 0, 0, 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (signUpController.userType ==
                                      "Student") ...[
                                    Text(
                                      "Admission Year",
                                      style: GoogleFonts.poppins(
                                        fontSize: 18,
                                        color: HexColor("#8d8d8d"),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    TextField(
                                      onChanged: (value) {
                                        signUpController
                                            .setAdmissionYear(value);
                                      },
                                      onSubmitted: (value) {
                                        signUpController
                                            .setAdmissionYear(value);
                                      },
                                      keyboardType: TextInputType.number,
                                      cursorColor: HexColor("#4f4f4f"),
                                      decoration: InputDecoration(
                                        hintText: "2020",
                                        fillColor: HexColor("#f0f3f1"),
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                20, 20, 20, 20),
                                        hintStyle: GoogleFonts.poppins(
                                          fontSize: 15,
                                          color: HexColor("#8d8d8d"),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: BorderSide.none,
                                        ),
                                        filled: true,
                                      ),
                                    ),
                                  ] else if (signUpController.userType ==
                                      "Alumni") ...[
                                    Text(
                                      "Passout Year",
                                      style: GoogleFonts.poppins(
                                        fontSize: 18,
                                        color: HexColor("#8d8d8d"),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    TextField(
                                      onChanged: (value) {
                                        signUpController.setPassOutYear(value);
                                      },
                                      onSubmitted: (value) {
                                        signUpController.setPassOutYear(value);
                                      },
                                      keyboardType: TextInputType.number,
                                      cursorColor: HexColor("#4f4f4f"),
                                      decoration: InputDecoration(
                                        hintText: "2020",
                                        fillColor: HexColor("#f0f3f1"),
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                20, 20, 20, 20),
                                        hintStyle: GoogleFonts.poppins(
                                          fontSize: 15,
                                          color: HexColor("#8d8d8d"),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: BorderSide.none,
                                        ),
                                        filled: true,
                                      ),
                                    ),
                                  ] else
                                    ...[],
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    "Profile Picture",
                                    style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      color: HexColor("#8d8d8d"),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  TextField(
                                    cursorColor: HexColor("#4f4f4f"),
                                    decoration: InputDecoration(
                                      hintText: "Upload photo",
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
                                    "Resume (Optional)",
                                    style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      color: HexColor("#8d8d8d"),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  TextField(
                                    cursorColor: HexColor("#4f4f4f"),
                                    decoration: InputDecoration(
                                      hintText: "Upload Resume",
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
                                    height: 5,
                                  ),
                                  MyButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomeScreen()));
                                      signUserUp();
                                      signUpController.postSignUpDetails();
                                    },
                                    buttonText: 'Submit',
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
