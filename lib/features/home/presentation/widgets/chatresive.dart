import 'package:chatapp/features/home/data/messagemodel.dart';
import 'package:flutter/material.dart';

class Chatresive extends StatelessWidget {
  const Chatresive({super.key, required this.message});
  final Messagemodel message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        margin: const EdgeInsets.only(right: 20, left: 20,bottom: 20),
       padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(15),
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
            
          ), color: Colors.blue
        ),
        child: Text(message.message,
        textAlign: TextAlign.center,

        )
        ,

      ),
    );
  }
}