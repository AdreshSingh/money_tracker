import 'package:flutter/material.dart';

class PlusButton extends StatelessWidget {
  final Function() function;
  const PlusButton({
    super.key,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        width: 75,
        height: 75,
        decoration: BoxDecoration(
          color: Colors.grey[400],
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            "+",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
