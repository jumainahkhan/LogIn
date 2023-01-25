import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

List<String> list = <String>['Student', 'Teacher', 'Alumni'];

class SignUpOne extends StatefulWidget {
  const SignUpOne({super.key});

  @override
  State<SignUpOne> createState() => _SignUpOneState();
}

class _SignUpOneState extends State<SignUpOne> {
  String dropdownValue = list.first;

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
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 0, 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "User Type",
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
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
                                height: 8,
                              ),
                              Text(
                                "Email",
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  color: HexColor("#8d8d8d"),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextField(
                                cursorColor: HexColor("#4f4f4f"),
                                decoration: InputDecoration(
                                  hintText: "hello@gmail.com",
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
                                  prefixIcon: const Icon(Icons.mail_outline),
                                  prefixIconColor: HexColor("#4f4f4f"),
                                  filled: true,
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                "Password",
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  color: HexColor("#8d8d8d"),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextField(
                                cursorColor: HexColor("#4f4f4f"),
                                decoration: InputDecoration(
                                  hintText: "*************",
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
                                  prefixIcon: const Icon(Icons.lock_outline),
                                  filled: true,
                                  focusColor: HexColor("#44564a"),
                                  prefixIconColor: HexColor("#4f4f4f"),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  debugPrint("pressed");
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 10, 10, 10),
                                  child: Container(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 17, 0, 10),
                                    height: 60,
                                    width: 275,
                                    decoration: BoxDecoration(
                                      color: HexColor('#44564a'),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Text(
                                      'Proceed',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
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
    );
  }
}
