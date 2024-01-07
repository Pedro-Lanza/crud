import 'package:flutter/material.dart';

class PostLoading extends StatelessWidget {
  const PostLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Align(child: Text('Posts', style: TextStyle(fontSize: 40))),
        SizedBox(
          height: 50,
        ),
        CircularProgressIndicator(),
      ],
    );
  }
}
