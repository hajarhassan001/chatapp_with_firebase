import 'package:chatapp/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:chatapp/features/authentication/presentation/views/signUp.dart';
import 'package:chatapp/features/authentication/presentation/widgets/custom_TextFrom.dart';
import 'package:chatapp/features/authentication/presentation/widgets/secret_textForm.dart';
import 'package:chatapp/features/home/presentation/views/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});
  static String routeName = "sign_in";

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  GlobalKey<FormState> fKey = GlobalKey<FormState>();
  GlobalKey<FormState> fKeyP = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            if (FirebaseAuth.instance.currentUser!.emailVerified) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text("Login Success")));
              //  context.read<AuthCubit>().getUserDate();
              Navigator.pushNamed(context, HomeScreen.routeName);
            }else{
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please verify your email')));
            }
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
         else if (state is GoogleSignInSuccess){
            ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text("Login Success With Google")));
              Navigator.pushNamed(context, HomeScreen.routeName);
         }else if (state is GoogleSignInError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
     
        builder: (context, state) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/login.gif",
                    height: 300,
                  ),
                  const Row(
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "Sign In",
                        style: TextStyle(
                          fontSize: 55,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  CustomTextfrom(
                    labelText: "Email",
                    controller: context.read<AuthCubit>().email,
                    fKey: fKey,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SecretTextform(
                    labelText: "Password",
                    controller: context.read<AuthCubit>().pass,
                    fKey: fKeyP,
                    controller_parent: null,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("if you don't have an account"),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, SignUp.routeName);
                        },
                        child: const Text("Sign Up"),
                      ),
                    ],
                  ),
                  state is AuthLoading
                      ? const CircularProgressIndicator()
                      : MaterialButton(
                          color: Colors.blue,
                          onPressed: () {
                            if (fKey.currentState!.validate() &&
                                fKeyP.currentState!.validate()) {
                              context.read<AuthCubit>().signIn();
                            }
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Text(
                            "Sign In",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      state is GoogleSignInLouding
                      ? const CircularProgressIndicator()
                      :       MaterialButton(
                    color: Colors.red,
                    onPressed: () {
                   
                            context.read<AuthCubit>().signInWithGoogle();
                          

                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Text(
                      "SignIn With Google",
                      style: TextStyle(

                        color: Colors.white,

                        fontSize: 20,



                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
