import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:login/Screens/signup/sign_up_three.dart';
import 'package:login/components/my_button.dart';

class SignUpTwo extends StatefulWidget {
  const SignUpTwo({super.key});

  @override
  State<SignUpTwo> createState() => _SignUpTwoState();
}

class _SignUpTwoState extends State<SignUpTwo> {
  final mobileNumberController = TextEditingController().obs;
  final nameController = TextEditingController().obs;
  final collegeNameContoller = TextEditingController().obs;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: HexColor("#fed8c3"),
        body: Column(
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
                          height: 8,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 0, 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Mobile Number",
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  color: HexColor("#8d8d8d"),
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              TextField(
                                controller: mobileNumberController.value,
                                keyboardType: TextInputType.number,
                                cursorColor: HexColor("#4f4f4f"),
                                decoration: InputDecoration(
                                  hintText: "1234567890",
                                  fillColor: HexColor("#f0f3f1"),
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(20, 20, 20, 20),
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
                              Text(
                                "Name",
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  color: HexColor("#8d8d8d"),
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              TextField(
                                controller: nameController.value,
                                cursorColor: HexColor("#4f4f4f"),
                                decoration: InputDecoration(
                                  hintText: "Jack Smith",
                                  fillColor: HexColor("#f0f3f1"),
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(20, 20, 20, 20),
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
                              Text(
                                "College Name",
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  color: HexColor("#8d8d8d"),
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              TextField(
                                controller: collegeNameContoller.value,
                                cursorColor: HexColor("#4f4f4f"),
                                decoration: InputDecoration(
                                  hintText: "ABC College",
                                  fillColor: HexColor("#f0f3f1"),
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(20, 20, 20, 20),
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
                                height: 10,
                              ),
                              MyButton(
                                onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SignUpThree())),
                                buttonText: 'Proceed',
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
      ),
    );
  }
}
