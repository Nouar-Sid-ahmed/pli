import 'package:flutter/material.dart';
import '../userProfil_screens.dart';
import '../preference_screens.dart';

import '../login_screens.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  final bool logout = false;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.zero,
        children: ListTile.divideTiles(context: context, tiles: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromRGBO(0, 151, 167, 1),
              // image: DecorationImage(
              //     fit: BoxFit.fill,
              //     image: AssetImage('images/side_menu_background.png'))
            ),
            child: Text(
              'Menu setting',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
          ListTile(
            visualDensity: const VisualDensity(vertical: 4),
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const <Widget>[
                Icon(Icons.account_circle),
              ],
            ),
            title: const Text('Profile'),
            onTap: () => {
              Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return const UserProfileScreens();
                  },
                ),
                (_) => false,
              ),
            },
          ),
          ListTile(
            visualDensity: const VisualDensity(vertical: 4),
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const <Widget>[
                Icon(Icons.favorite),
              ],
            ),
            title: const Text('My artists'),
            onTap: () => {
              Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return const PreferenceScreens();
                  },
                ),
                (_) => false,
              ),
            },
          ),
          ListTile(
            visualDensity: const VisualDensity(vertical: 4),
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const <Widget>[
                Icon(Icons.logout),
              ],
            ),
            title: const Text('Logout'),
            onTap: () => {
              Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return const LoginsScreens();
                  },
                ),
                (_) => false,
              ),
            },
          ),
        ]).toList(),
      ),
    );
  }
}
