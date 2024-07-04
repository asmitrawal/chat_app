import 'package:chat_app/auth/ui/login/login_screen.dart';
import 'package:chat_app/settings/ui/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Column(
            children: [
              //logo
              DrawerHeader(
                child: FractionallySizedBox(
                  widthFactor: 0.5,
                  child: Icon(
                    Icons.message,
                    size: 40,
                  ),
                ),
              ),

              //home tile
              Padding(
                padding: const EdgeInsets.only(left: 25, bottom: 25, top: 25),
                child: ListTile(
                  leading: Icon(Icons.home),
                  title: Text("H O M E"),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),

              //settings tile
              Padding(
                padding: const EdgeInsets.only(left: 25, bottom: 25),
                child: ListTile(
                  leading: Icon(Icons.settings),
                  title: Text("S E T T I N G S"),
                  onTap: () {
                    Navigator.of(context).push(
                      PageTransition(
                          child: SettingsScreen(),
                          type: PageTransitionType.fade),
                    );
                  },
                ),
              ),
            ],
          ),

          //logout tile
          Padding(
            padding: const EdgeInsets.only(left: 25, bottom: 25),
            child: ListTile(
              leading: Icon(Icons.logout),
              title: Text("L O G   O U T"),
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                    PageTransition(
                      child: LoginScreen(),
                      type: PageTransitionType.fade,
                    ),
                    (Route<dynamic> route) => false);
              },
            ),
          ),
        ],
      ),
    );
  }
}
