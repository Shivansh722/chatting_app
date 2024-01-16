import 'package:chat/services/authentication/auth_service.dart';
import "package:flutter/material.dart";

import 'package:chat/pages/setting_page.dart';
class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logout() {
    final auth = AuthService();
    auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(children: [
        //logo
        DrawerHeader(
          child: Center(
            child: Icon(
              Icons.chat,
              size: 60,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        //home list tile 
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            title: const Text("H O M E"),
            leading: const Icon(Icons.home),
            onTap: () {
             //pop the drawer
             Navigator.pop(context);
            },
          ),
        ),

        //settings list tile
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            title: const Text("S E T T I N G S"),
            leading: const Icon(Icons.settings),
            onTap: () { 
              //pop the drawer
              Navigator.pop(context);

              //navigate to settings page
              Navigator.push(context, 
              MaterialPageRoute(
                builder: (context) => const SettingPage(),
                ));
             
            },
          ),
        ),

        //logout list tile

        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 10.0,),
          child: ListTile(
            title: Text("L O G O U T"),
            leading: Icon(Icons.logout),
            onTap: logout,
          ),
        ),
      ]),
    );
  }
}