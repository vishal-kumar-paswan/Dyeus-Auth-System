import 'package:flutter/material.dart';

class CenterDivider extends StatelessWidget {
  const CenterDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            height: 5,
            color: Colors.grey.shade600,
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'OR',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            height: 6,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}
