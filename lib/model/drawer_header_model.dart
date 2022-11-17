import 'package:flutter/material.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({
    super.key,
    required this.text,
    this.onTap,
    this.leading,
  });
  final String text;
  final onTap;
  final leading;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 18),
      leading: leading,
      title: Text(text),
      onTap: onTap,
    );
  }
}
