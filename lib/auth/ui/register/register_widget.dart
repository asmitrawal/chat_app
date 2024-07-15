import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:page_transition/page_transition.dart';

import 'package:chat_app/auth/cubit/sign_up_cubit.dart';
import 'package:chat_app/auth/ui/login/login_screen.dart';
import 'package:chat_app/common/components/my_button.dart';
import 'package:chat_app/common/components/my_text_field.dart';
import 'package:chat_app/common/state/common_state.dart';

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({super.key});

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  GlobalKey<FormState>? _key = GlobalKey<FormState>();
  TextEditingController? emailController;
  TextEditingController? fullNameController;
  TextEditingController? pwController;
  TextEditingController? confirmPwController;
  @override
  void initState() {
    emailController = TextEditingController();
    fullNameController = TextEditingController();
    pwController = TextEditingController();
    confirmPwController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController!.dispose();
    fullNameController!.dispose();
    pwController!.dispose();
    confirmPwController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: BlocListener<SignUpCubit, CommonState>(
          listener: (context, state) {
            if (state is CommonLoadingState) {
              context.loaderOverlay.show();
            } else {
              context.loaderOverlay.hide();
            }
            if (state is CommonErrorState) {
              Fluttertoast.showToast(msg: state.message ?? "unable to sign up");
            }
            if (state is CommonSuccessState) {
              Navigator.of(context).pushAndRemoveUntil(
                PageTransition(
                  child: LoginScreen(),
                  type: PageTransitionType.fade,
                ),
                (Route<dynamic> route) => false,
              );
            }
          },
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  //logo
                  Icon(Icons.message, size: 60),
                  SizedBox(
                    height: 50,
                  ),

                  //text
                  Text("Lets create an account for you!"),
                  SizedBox(
                    height: 25,
                  ),
                  Form(
                    key: _key,
                    child: Column(
                      children: [
                        //fullName textfield
                        MyTextField(
                          hintText: "Full Name",
                          obscureText: false,
                          controller: fullNameController,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length < 4) {
                              return "Please enter a valid name";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 25,
                        ),

                        //email textfield
                        MyTextField(
                          hintText: "Email",
                          obscureText: false,
                          controller: emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter a valid email";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 25,
                        ),

                        //password textfield
                        MyTextField(
                          hintText: "Password",
                          obscureText: true,
                          controller: pwController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter a valid password";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 25,
                        ),

                        //confirm password textfield
                        MyTextField(
                          hintText: "Confirm Password",
                          obscureText: true,
                          controller: confirmPwController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter a valid password";
                            } else if (value != pwController!.text) {
                              return "Passwords dont match";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 25),
                      ],
                    ),
                  ),

                  //register button
                  MyButton(
                    buttonText: "Register",
                    onTap: () {
                      if (_key!.currentState!.validate()) {
                        context.read<SignUpCubit>().signUp(
                              email: emailController!.text,
                              password: pwController!.text,
                              fullName: fullNameController!.text,
                            );
                      }
                    },
                  ),
                  SizedBox(
                    height: 25,
                  ),

                  //register text
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            PageTransition(
                              child: LoginScreen(),
                              type: PageTransitionType.fade,
                            ),
                            (Route<dynamic> route) => false,
                          );
                        },
                        child: Text(
                          "Login now",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
