import 'package:edtech/res/app_colors.dart';
import 'package:edtech/src/view/screen/sigin_screen.dart';
import 'package:edtech/src/view/screen/signup_screen.dart';
import 'package:edtech/src/view/widgets/my_tab.dart';
import 'package:edtech/util/system_util.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> tabs = const [
    MyTab(tabName: "Login"),
    MyTab(tabName: "Signup"),
  ];


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemUtil.hideBottomNav();
    SystemUtil.setStatusBarColor(royalBlue);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          //top container
          Expanded(
            flex: 1,
            child: Container(
              decoration: const BoxDecoration(
                  color: royalBlue,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(145),
                      bottomRight: Radius.circular(0))),
              child: Center(
                  child: Image.asset(
                'assets/icons/ic_coding.png',
                scale: 1,
              )),
            ),
          ),

          //main body
          Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.all(15),
                color: Colors.transparent,
                child: DefaultTabController(
                    length: tabs.length,
                    child: Column(
                      children: [
                        //signup or sign in tab
                        TabBar(tabs: tabs),
                        //tab bar screens
                        const Expanded(
                            child: TabBarView(children: [
                          //--------------------------------sign in screen
                          SignInScreen(),

                          //-------------------------------------sign up screen
                          SignupScreen()
                        ])),
                      ],
                    )),
              ))
        ],
      ),
    );
  }
}
