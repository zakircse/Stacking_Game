import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final text;
  final function;
  MyButton({this.text, this.function});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: MediaQuery.of(context).size.width / 2.5,
            color: Colors.grey[900],
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: text,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
