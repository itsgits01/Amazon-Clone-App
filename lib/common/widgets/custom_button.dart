import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomButton extends StatelessWidget {
  final String btnName;
  final Color? color;
  final VoidCallback onTap;

  const CustomButton({
    Key? key,
    required this.btnName,
    required this.onTap,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(50),
      color: color,
      child: InkWell(
        onTap: () {
          // Adding haptic feedback
          HapticFeedback.lightImpact();
          
          // Triggering the provided onTap callback
          onTap();
        },
        borderRadius: BorderRadius.circular(50),
        child: Ink(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
          ),
          child: Center(
            child: Text(
              btnName,
              style: TextStyle(
                color: color == null ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
