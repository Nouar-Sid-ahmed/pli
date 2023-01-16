import 'package:flutter/material.dart';
import 'home_screens.dart';
import 'editProfil_screens.dart';
import '../globals.dart' as globals;

class UserProfileScreens extends StatefulWidget {
  static String routeName = '/userprofile-screen';

  const UserProfileScreens({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _UserProfileScreensState createState() => _UserProfileScreensState();
}

class _UserProfileScreensState extends State<UserProfileScreens> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            leading: BackButton(onPressed: () {
              Navigator.of(context).pushNamed(HomeScreens.routeName);
            }),
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.black,
            elevation: 0,
          ),
          body: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Center(
                child: Stack(
                  children: [
                    buildImage(),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              buildName(),
              const SizedBox(height: 24),
              Padding(
                // width: double.infinity,
                padding: const EdgeInsets.only(left: 100, right: 100),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      // onPrimary: Colors.white,
                      padding:
                          const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    ),
                    child: const Text("Edit"),
                    onPressed: () {
                      Navigator.of(context).pushNamed(EditProfileScreens.routeName);
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildName() => Column(
        children: [
          Text(
            globals.username,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            globals.email,
            style: const TextStyle(color: Colors.grey),
          )
        ],
      );

  Widget buildImage() {
    const image = NetworkImage(
        'https://media.istockphoto.com/id/1300845620/fr/vectoriel/appartement-dic%C3%B4ne-dutilisateur-isol%C3%A9-sur-le-fond-blanc-symbole-utilisateur.jpg?s=612x612&w=0&k=20&c=BVOfS7mmvy2lnfBPghkN__k8OMsg7Nlykpgjn0YOHj0=');

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image,
          fit: BoxFit.cover,
          width: 128,
          height: 128,
        ),
      ),
    );
  }
}
