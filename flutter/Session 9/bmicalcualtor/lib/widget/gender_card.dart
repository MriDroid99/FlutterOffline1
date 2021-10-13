import 'package:flutter/material.dart';

class GenderCard extends StatelessWidget {
  final String gender;
  final IconData icon;
  final Color color;
  const GenderCard(this.gender, this.icon, this.color, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(15), color: color),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 80,
          ),
          Text(
            gender,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
