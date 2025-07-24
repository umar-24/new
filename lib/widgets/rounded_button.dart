
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String title;
  final void Function()?  onTap;
  final bool loading;
  const RoundedButton({super.key, required this.title, this.onTap,  this.loading = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap ,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Center(child: loading? const CircularProgressIndicator(strokeWidth: 3 , color: Colors.white,): Text(title , style: const TextStyle(fontSize: 16, color: Colors.white),)),
      ),
    );
  }
}
