import 'dart:io';

import 'package:chatapp/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';


class PickaImage extends StatelessWidget {
  const PickaImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return    context.read<AuthCubit>().profileImage == null? const CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage("assets/images/personphoto.webp"),
            ): CircleAvatar(
              
              radius: 80,
              backgroundImage: FileImage(File(context.read<AuthCubit>().profileImage!.path))
            );
          },
        ),
        Positioned(
            bottom: 0,
            right: 0,
            child: IconButton(
            //  color: Colors.amber,
                onPressed: ()   {
                  ImagePicker().pickImage(source: ImageSource.gallery).then(
                        (val) {
                          context.read<AuthCubit>().upLuodImage(val!);
                        },
                      );
                },
                icon: const Icon(Icons.add_a_photo)))
      ],
    );
  }
}

