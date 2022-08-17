import 'package:dyeus_authentication_system/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../constants.dart';
import '../../widgets/center_divider.dart';
import '../../widgets/social_login_button.dart';
import '../otp_verification/otp_verification.dart';

class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);
  late String _phoneNumber;
  late String _countryCode;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 20),
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(flex: 2),
              Text(
                'Welcome to App',
                style: TextStyle(
                  fontFamily: GoogleFonts.lora().fontFamily,
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(flex: 2),
              const Text(
                'Please signup with your phone number to get regiestered.',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 12),
              IntlPhoneField(
                disableLengthCheck: true,
                style: const TextStyle(
                  fontSize: 18,
                ),
                showDropdownIcon: false,
                flagsButtonMargin: const EdgeInsets.all(12),
                decoration: InputDecoration(
                  hintText: 'Phone Number',
                  hintStyle: const TextStyle(fontSize: 18),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade200,
                    ),
                    borderRadius: BorderRadius.circular(13),
                  ),
                ),
                initialCountryCode: 'IN',
                onChanged: (phone) {
                  _countryCode = phone.countryCode;
                  _phoneNumber = phone.number;
                },
              ),
              const Spacer(),
              InkWell(
                onTap: (() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OneTimePassword(
                        countryCode: _countryCode,
                        phoneNumber: _phoneNumber,
                      ),
                    ),
                  );
                  AuthService.autheticateWithPhoneNumber(
                      _countryCode, _phoneNumber);
                }),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Constants.accentColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Center(
                    child: Text(
                      'Continue',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              const CenterDivider(),
              const Spacer(),
              SocialLoginButton(
                iconPath: 'assets/icons/metamask.png',
                socialName: 'Metamask',
                backgroundColor: Colors.grey.shade200,
                fontColor: Colors.black,
                onClick: () {},
              ),
              const SizedBox(height: 15),
              SocialLoginButton(
                iconPath: 'assets/icons/google.png',
                socialName: 'Google',
                backgroundColor: Colors.grey.shade200,
                fontColor: Colors.black,
                onClick: () {},
              ),
              const SizedBox(height: 15),
              SocialLoginButton(
                iconPath: 'assets/icons/apple.png',
                socialName: 'Apple',
                backgroundColor: Colors.black,
                fontColor: Colors.white,
                onClick: () {},
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Don\'t have an account?',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Signup',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Constants.accentColor,
                      ),
                    ),
                  )
                ],
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
