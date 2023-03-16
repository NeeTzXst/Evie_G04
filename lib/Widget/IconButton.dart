import 'package:flutter/material.dart';

class iconButton extends StatefulWidget {
  final double width;
  final double height;
  final IconData name;
  final double size;
  final Color backColor;
  final Color iconColor;

  const iconButton({
    super.key,
    required this.width,
    required this.height,
    required this.name,
    required this.size,
    required this.backColor,
    required this.iconColor,
  });

  @override
  State<iconButton> createState() => _iconButtonState();
}

class _iconButtonState extends State<iconButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.backColor,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Icon(
        widget.name,
        size: widget.size,
        color: Colors.blue,
      ),
    );
  }
}
