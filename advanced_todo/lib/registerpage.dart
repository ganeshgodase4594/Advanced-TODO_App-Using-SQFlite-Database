import 'package:advanced_todo/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';

class register extends StatefulWidget {
  @override
  State<register> createState() => registestate();
}

class registestate extends State<register> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool agreePersonalData = true;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // GlobalKey<FormState> _formKey1= GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/img1.png"),
                    fit: BoxFit.cover)),
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 200),
                decoration:  BoxDecoration(
                  color: const Color.fromARGB(0, 200, 195, 195).withOpacity(0.6),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Center(
                          child: Text(
                            "Get Started",
                            style: GoogleFonts.lato(
                                textStyle: const TextStyle(
                                    color: Colors.blue,
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: name,
                        decoration: InputDecoration(
                          hintText: "Enter Your Name",
                          label: const Text('Your Name'),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter Your Name";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                          controller: email,
                          decoration: InputDecoration(
                            hintText: "Enter Email",
                            label: const Text('Email'),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter Your Email";
                            } else {
                              return null;
                            }
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: password,
                        decoration: InputDecoration(
                          hintText: "Enter Password",
                          label: const Text('Password'),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter Your Password";
                          } else {
                            return null;
                          }
                        },
                        obscureText: true,
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      // i agree to the processing
                      Row(
                        children: [
                          Checkbox(
                            value: agreePersonalData,
                            onChanged: (bool? value) {
                              setState(() {
                                agreePersonalData = value!;
                              });
                            },
                          ),
                          const Text(
                            'I agree to the processing of ',
                            style: TextStyle(
                              color: Colors.black45,
                            ),
                          ),
                          const Text(
                            'Personal data',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15))),
                            fixedSize:
                                const MaterialStatePropertyAll(Size(400, 60)),
                            backgroundColor: const MaterialStatePropertyAll(
                              Colors.blue,
                            )),
                        onPressed: () {
                          bool registervalidate =
                              _formKey.currentState!.validate();

                          if (registervalidate && agreePersonalData) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => signin()),
                            );

                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text("You'r Register Successfully")));
                          } else if (!agreePersonalData) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Login Failed")));
                          }
                        },
                        child: Text(
                          "Sign up",
                          style: GoogleFonts.lato(
                              fontWeight: FontWeight.w900,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 0.7,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 0,
                              horizontal: 10,
                            ),
                            child: Text(
                              'Sign up with',
                              style: TextStyle(
                                color: Colors.black45,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 0.7,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 25,
                      ),

                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Bootstrap.google,
                          ),
                          Icon(
                            Icons.facebook,
                            size: 32,
                          ),
                          Icon(
                            Bootstrap.github,
                            size: 28,
                          ),
                          Icon(
                            BoxIcons.bxl_apple,
                            size: 32,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Already have an account?",
                            style: GoogleFonts.lato(
                                textStyle: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            )),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => signin()));
                              },
                              child: Text(
                                "Sign in",
                                style: GoogleFonts.lato(
                                    textStyle: const TextStyle(
                                        color: Colors.blue, fontSize: 20)),
                              ))
                        ],
                        
                      ),
                      const SizedBox(height: 5,)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
