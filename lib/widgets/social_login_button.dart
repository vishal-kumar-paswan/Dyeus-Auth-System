import 'package:flutter/material.dart';

class SocialLoginButton extends StatelessWidget {
  const SocialLoginButton({
    Key? key,
    required this.iconPath,
    required this.socialName,
    required this.backgroundColor,
    required this.fontColor,
    required this.onClick,
  }) : super(key: key);

  final String iconPath;
  final String socialName;
  final Color backgroundColor;
  final Color fontColor;
  final Function onClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onClick,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              iconPath,
              height: 25,
              width: 25,
            ),
            const SizedBox(width: 7),
            Text(
              'Connect to ',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: fontColor,
              ),
            ),
            Text(
              socialName,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: fontColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
