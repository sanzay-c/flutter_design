import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class BioBox extends StatelessWidget {
  const BioBox({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      
      decoration: BoxDecoration(
        // color
        color: Theme.of(context).colorScheme.secondary
      ),
      width: double.infinity,

      child: Text(text.isNotEmpty ? text : "Empty bio.."),
    );
  }
}