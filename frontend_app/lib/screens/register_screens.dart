import 'package:flutter/material.dart';
import 'home_screens.dart';
import 'preference_screens.dart';
import '../models/users/users.request.dart' as userRequest;
import '../globals.dart' as globals;

class RegisterScreens extends StatefulWidget {
  static String routeName = '/register-screen';

  const RegisterScreens({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _RegisterScreensState createState() => _RegisterScreensState();
}

class _RegisterScreensState extends State<RegisterScreens> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<bool>? _userRegister;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        // backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        body: Stack(
          children: [
            Container(
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.only(top: 50),
              child: const Text(
                'Create Account',
                style: TextStyle(color: Colors.black, fontSize: 33),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 35, right: 35),
                      child: Column(
                        children: [
                          TextField(
                            style: const TextStyle(color: Colors.black),
                            controller: _usernameController,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.grey,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                hintText: "Username",
                                hintStyle: const TextStyle(
                                    color: Color.fromRGBO(56, 56, 56, 1)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextField(
                            style: const TextStyle(color: Colors.black),
                            controller: _emailController,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.grey,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                hintText: "Email",
                                hintStyle: const TextStyle(
                                    color: Color.fromRGBO(56, 56, 56, 1)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextField(
                            controller: _passwordController,
                            style: const TextStyle(color: Colors.black),
                            obscureText: true,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.grey,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                hintText: "Password",
                                hintStyle: const TextStyle(
                                    color: Color.fromRGBO(56, 56, 56, 1)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          ButtonTheme(
                              minWidth: 500.0,
                              height: 100.0,
                              child: _buttonSignIn()),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ////////////////////////////////
  /////////// FUTUR /////////////
  //////////////////////////////

  FutureBuilder<bool> buildFutureBuilderForData() {
    return FutureBuilder<bool>(
      // future: _userRegister,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (_userRegister != null) {
                  Navigator.of(context).pushNamed(PreferenceScreens.routeName);
                }
              },
              child:
                  const Text('Sign in', style: TextStyle(color: Colors.white)),
            ),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}',
              style: const TextStyle(color: Colors.white));
        }

        return const CircularProgressIndicator();
      },
    );
  }

  // FutureBuilder<users.UsersAuth> buildFutureBuilder() {
  //   return FutureBuilder<users.UsersAuth>(
  //     future: _userRegister,
  //     builder: (context, snapshot) {
  //       if (snapshot.hasData) {
  //         return Text(snapshot.data!.id, style: TextStyle(color: Colors.white));
  //       } else if (snapshot.hasError) {
  //         return Text('${snapshot.error}',
  //             style: TextStyle(color: Colors.white));
  //       }

  //       return const CircularProgressIndicator();
  //     },
  //   );
  // }

  /////////////////////////////////
  /////////// WIDGET /////////////
  ///////////////////////////////
  void showPurchaseDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              "Register refused",
            ),
            actions: <Widget>[
              ElevatedButton(
                child: const Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  Widget _buttonSignIn() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          /* NE PAS OUBLIER DE RECHANGER */
          setState(() {
            _userRegister = userRequest.userRegister(_usernameController.text,
                _emailController.text, _passwordController.text);
          });
          _userRegister?.then((bool value) {
            Navigator.of(context).pushNamed(HomeScreens.routeName);
            // Navigator.of(context).pushNamed(PreferenceScreens.routeName);
            return true;
          }, onError: (error) {
            showPurchaseDialog(context);
            return false;
          });
        },
        child: const Text('Sign in', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
