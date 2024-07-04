// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String buttonText;
  final void Function()? onTap;
  const MyButton({
    Key? key,
    required this.buttonText,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25),
      child: InkWell(
        child: Container(
          padding: EdgeInsets.all(16),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(buttonText),
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
