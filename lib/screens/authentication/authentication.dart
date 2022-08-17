import 'package:container_tab_indicator/container_tab_indicator.dart';
import 'package:dyeus_authentication_system/constants.dart';
import 'package:dyeus_authentication_system/screens/signup/signup.dart';
import 'package:flutter/material.dart';
import '../signin/signin.dart';

class Authentication extends StatefulWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(30),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(30.0),
                      ),
                      border: Border.all(
                        width: 1,
                        color: Colors.grey.shade300,
                      ),
                    ),
                    width: 200,
                    height: 48,
                    child: TabBar(
                      controller: tabController,
                      tabs: const [
                        Text(
                          'Signin',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Signup',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                      indicator: const ContainerTabIndicator(
                        color: Constants.accentColor,
                        radius: BorderRadius.all(
                          Radius.circular(30.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
      body: TabBarView(
        controller: tabController,
        children: [
          SignIn(),
          SignUp(),
        ],
      ),
    );
  }
}
