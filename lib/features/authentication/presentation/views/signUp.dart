import 'package:chatapp/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:chatapp/features/authentication/presentation/views/signIn.dart';
import 'package:chatapp/features/authentication/presentation/widgets/custom_TextFrom.dart';
import 'package:chatapp/features/authentication/presentation/widgets/pickimage.dart';
import 'package:chatapp/features/authentication/presentation/widgets/secret_textForm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SignUp extends StatefulWidget {
  const SignUp({super.key});
  static String routeName = "sign_up";

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> fKey = GlobalKey<FormState>();
  GlobalKey<FormState> fKeyP = GlobalKey<FormState>();
  GlobalKey<FormState> cfKeyP = GlobalKey<FormState>();
  GlobalKey<FormState> fKeyn = GlobalKey<FormState>();
  GlobalKey<FormState> fKeyph = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
if(state is SignUpSuccess  ){
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('SignUp Success GO TO Verify Email '))
  );
  Navigator.pushReplacementNamed(context, SignIn.routeName);
}
if(state is SignUpError) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(state.message))
  );
}


           },
            builder: (context, state) {
              return Column(
                children: [
                  
                  const PickaImage(),
                  const Row(
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 55,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  CustomTextfrom(
                    labelText: "Name",
                    controller: context.read<AuthCubit>().nameup,
                    fKey: fKeyn,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextfrom(
                    labelText: "Email",
                    controller: context.read<AuthCubit>().emailup,
                    fKey: fKey,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextfrom(
                    labelText: "Phone",
                    controller: context.read<AuthCubit>().phoneup,
                    fKey: fKeyph,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SecretTextform(
                    labelText: "Password",
                    controller: context.read<AuthCubit>().passup,
                    fKey: fKeyP,
                    controller_parent: null,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SecretTextform(
                    labelText: "Confirm Password",
                    controller: context.read<AuthCubit>().cpassup,
                    fKey: cfKeyP,
                    controller_parent: context.read<AuthCubit>().passup,
                  ),
                   state is SignUpLouding? const CircularProgressIndicator() :
                  MaterialButton(
                    color: Colors.blue,
                    onPressed: () {
                      if (fKey.currentState!.validate() &&
                          fKeyP.currentState!.validate() &&
                          cfKeyP.currentState!.validate() &&
                          fKeyn.currentState!.validate() &&
                          fKeyph.currentState!.validate()) {
                            context.read<AuthCubit>().signUp();
                          }

                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(

                        color: Colors.white,

                        fontSize: 20,



                      ),
                    ),
                  ),
                    
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
