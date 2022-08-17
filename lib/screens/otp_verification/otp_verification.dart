import 'dart:async';
import 'package:dyeus_authentication_system/constants.dart';
import 'package:dyeus_authentication_system/services/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sms_autofill/sms_autofill.dart';

class OneTimePassword extends StatefulWidget {
  const OneTimePassword({
    Key? key,
    required this.countryCode,
    required this.phoneNumber,
  }) : super(key: key);

  final String phoneNumber;
  final String countryCode;

  @override
  State<OneTimePassword> createState() => _OneTimePasswordState();
}

class _OneTimePasswordState extends State<OneTimePassword> with CodeAutoFill {
  String initialOtp = '';
  int time = 30;
  Timer? timer;
  bool displayTimer = true;
  bool disableButton = true;
  static const resendButtonText = 'Resend OTP';
  static const submitButtonText = 'Done';
  String defaultButtonText = resendButtonText;
  final TextEditingController _smsController = TextEditingController();

  @override
  void codeUpdated() {
    setState(() {});
  }

  void listenOTP() async {
    await SmsAutoFill().unregisterListener();
    listenForCode();
    SmsAutoFill();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (time > 0) {
        setState(() {
          time--;
        });
      } else {
        timer?.cancel();
        setState(() {
          displayTimer = false;
          disableButton = false;
        });
      }
    });
  }

  @override
  void initState() {
    listenOTP();
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          onPressed: (() => Navigator.pop(context)),
          icon: const Icon(
            CupertinoIcons.arrow_left,
            color: Colors.black,
          ),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.40,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Enter OTP',
                    style: TextStyle(
                      fontFamily: GoogleFonts.lora().fontFamily,
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'A 6 digit code has been sent to ${widget.countryCode} ${widget.phoneNumber}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Text(
                        'Incorrect number?',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextButton(
                        onPressed: (() => Navigator.pop(context)),
                        child: const Text(
                          'Change',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Constants.accentColor,
                          ),
                        ),
                      )
                    ],
                  ),
                  const Spacer(),
                  PinFieldAutoFill(
                      controller: _smsController,
                      codeLength: 6,
                      keyboardType: TextInputType.number,
                      decoration: UnderlineDecoration(
                        textStyle: const TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        colorBuilder:
                            FixedColorBuilder(Colors.black.withOpacity(0.3)),
                      ),
                      currentCode: initialOtp,
                      onCodeSubmitted: (code) {
                        setState(() {
                          initialOtp = code.toString();
                        });
                      },
                      onCodeChanged: (code) {
                        setState(() {
                          initialOtp = code.toString();
                        });
                        if (code?.length == 6) {
                          setState(() {
                            defaultButtonText = submitButtonText;
                            disableButton = false;
                          });
                        }
                      }),
                  const SizedBox(height: 50),
                  InkWell(
                    onTap: () {
                      listenOTP();
                      AuthService.signInWithPhoneNumber(_smsController.text);
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: disableButton
                            ? const Color(0xFFEDFFD0)
                            : Constants.accentColor,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child: Text(
                          defaultButtonText,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Visibility(
              visible: displayTimer,
              replacement: Column(
                children: [
                  const Text(
                    'Didn\'t receieve any code?',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextButton(
                    onPressed: (() {
                      listenOTP();
                      AuthService.autheticateWithPhoneNumber(
                        widget.countryCode,
                        widget.phoneNumber,
                      );
                    }),
                    child: const Text(
                      'Resend code',
                      style: TextStyle(
                        fontSize: 16,
                        color: Constants.accentColor,
                      ),
                    ),
                  )
                ],
              ),
              child: TextButton(
                onPressed: (() {}),
                child: Text(
                  'Resend OTP in $time s',
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
