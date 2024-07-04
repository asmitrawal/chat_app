import 'package:chat_app/auth/cubit/sign_in_cubit.dart';
import 'package:chat_app/auth/ui/register/register_screen.dart';
import 'package:chat_app/common/components/my_button.dart';
import 'package:chat_app/common/components/my_text_field.dart';
import 'package:chat_app/common/state/common_state.dart';
import 'package:chat_app/home/ui/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:page_transition/page_transition.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController? emailController = TextEditingController();
    TextEditingController? pwController = TextEditingController();
    return Scaffold(
        appBar: AppBar(),
        body: BlocListener<SignInCubit, CommonState>(
          listener: (context, state) {
            if (state is CommonLoadingState) {
              context.loaderOverlay.show();
            } else {
              context.loaderOverlay.hide();
            }
            if (state is CommonErrorState) {
              Fluttertoast.showToast(msg: state.message ?? "unable to sign in");
            }
            if (state is CommonSuccessState) {
              Navigator.of(context).pushAndRemoveUntil(
                PageTransition(
                  child: HomeScreen(),
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
                children: [
                  //logo
                  Icon(Icons.message, size: 60),
                  SizedBox(
                    height: 50,
                  ),

                  //text
                  Text(
                    "Welcome back, you've been missed!",
                    style: TextStyle(fontSize: 15),
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

                  //loginbutton
                  MyButton(
                    buttonText: "Login",
                    onTap: () {
                      context.read<SignInCubit>().signIn(
                            email: emailController.text,
                            password: pwController.text,
                          );
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
                      Text("Not a member? ",
                          style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).colorScheme.onSurface)),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            PageTransition(
                              child: RegisterScreen(),
                              type: PageTransitionType.fade,
                            ),
                            (Route<dynamic> route) => false,
                          );
                        },
                        child: Text(
                          "Register now",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: 14,
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
