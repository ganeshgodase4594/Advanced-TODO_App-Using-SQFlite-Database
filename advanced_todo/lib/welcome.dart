
import 'package:advanced_todo/loginpage.dart';
import 'package:advanced_todo/registerpage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class welcomescreen extends StatelessWidget {
  const welcomescreen({super.key});

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Image.asset(
            'assets/images/img1.png',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 260, left: 60, right: 55),
                child: Text(
                  "Welcome Back!",
                  style: GoogleFonts.lato(
                      textStyle: const TextStyle(color: Colors.white, fontSize: 40,fontWeight: FontWeight.w900)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 65, right: 60),
                child: Center(
                    child: Text(
                  "Enter Your Login Crendential To Access Your Services",
                  style: GoogleFonts.lato(
                      textStyle: const TextStyle(color: Colors.white, fontSize: 15)),
                )),
              ),
              Flexible(
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>  register()),
                              );
                            },
                            child: Container(
                              height: 40,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                ),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 5, left: 40),
                                child: Text(
                                  "Sign Up",
                                  style: GoogleFonts.lato(
                                      textStyle: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => signin()),
                              );
                            },
                            child: Container(
                              height: 40,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 5, left: 40),
                                child: Text(
                                  "Sign in",
                                  style: GoogleFonts.lato(
                                      textStyle: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
