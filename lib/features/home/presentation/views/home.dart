import 'package:chatapp/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:chatapp/features/authentication/presentation/views/signIn.dart';
import 'package:chatapp/features/home/data/messagemodel.dart';
import 'package:chatapp/features/home/presentation/widgets/chatresive.dart';
import 'package:chatapp/features/home/presentation/widgets/chatsent.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static String routeName = "HomeScreen";
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override


  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    final message = FirebaseFirestore.instance.collection("message");
    List <Messagemodel> messages = [];
    
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();

                  Navigator.pushReplacementNamed(context, SignIn.routeName);
                },
                icon: const Icon(Icons.logout_outlined))
          ],
        ),
        backgroundColor: Colors.white,
        body: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return Column(
              children: [
                StreamBuilder<QuerySnapshot>(
                  stream: message.orderBy("Created At").snapshots(),
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      for(int i=0;i<snapshot.data!.docs.length;i++){
                        messages.add(
                          Messagemodel.fromjson(
                            snapshot.data!.docs[i]
                          )
                        );

                      }

                    }
                    return 
                    Expanded(
                      child: ListView.builder(
                        itemCount: messages.length,
                        itemBuilder: (context, i) {
                          return  messages[i].sender==FirebaseAuth.instance.currentUser!.email?
                           Chatsent(message: messages[i],):Chatresive(message: messages[i]);
                        },
                      ),
                    );
                  }
                ),
                TextField(
                  controller: controller,
                  decoration: InputDecoration(
                      hintText: 'sent a message',
                      suffixIcon: IconButton(
                          onPressed: () {
                            messages.clear();
                            message.add({
                              "message": controller.text,
                              "Created At": DateTime.now(),
                              "sender": FirebaseAuth.instance.currentUser!.email
                            });
                            controller.clear();
                            setState(() {
                              
                            });
                          },
                          icon: Icon(Icons.send)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      )),
                )
              ],
            );
          },
        ));
  }
}
