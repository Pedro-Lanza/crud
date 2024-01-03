import 'package:flutter/material.dart';

class FormErrorWidget extends StatelessWidget {
  final Exception error;

  FormErrorWidget({required this.error});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            error.toString(),
            style: const TextStyle(color: Colors.red, fontSize: 16),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Retry'),
        ),
      ],
    );
  }
}
