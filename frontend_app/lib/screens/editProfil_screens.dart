import 'package:flutter/material.dart';
import 'home_screens.dart';
import '../models/users/users.request.dart' as userRequest;
import '../globals.dart' as globals;

class EditProfileScreens extends StatefulWidget {
  static String routeName = '/editprofile-screen';

  const EditProfileScreens({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _EditProfileScreensState createState() => _EditProfileScreensState();
}

class _EditProfileScreensState extends State<EditProfileScreens> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();

    controller = TextEditingController(text: globals.username);
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            leading: BackButton(onPressed: () {
              Navigator.of(context).pop();
            }),
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.black,
            elevation: 0,
          ),
          body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 32),
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Username",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    maxLines: 1,
                  ),
                ],
              ),
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 12),
                    ),
                    child: const Text("Save"),
                    onPressed: () {},
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

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
