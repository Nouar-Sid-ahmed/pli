import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend_app/models/users/users.dart';
import 'home_screens.dart';
import 'register_screens.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:inputs_components/inputs_components.dart';
import 'package:validators/sanitizers.dart';
import 'package:spotify_sdk/spotify_sdk.dart';
import '../models/users/users.request.dart' as userRequest;
import '../globals.dart' as globals;

class LoginsScreens extends StatefulWidget {
  static String routeName = '/login-screen';

  const LoginsScreens({super.key});
  @override
  LoginsScreensState createState() => LoginsScreensState();
}

class LoginsScreensState extends State<LoginsScreens> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<bool>? _userLogin;
  Future<bool>? _spotifyLogin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              emailInput(
                label: "Email",
                controller: _emailController,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 12.0),
              passwordInput(
                label: "Password",
                controller: _passwordController,
                customValidator: (value) => trim(value).length > 5,
              ),
              const SizedBox(height: 24.0),
              _loginButton(),
              const SizedBox(height: 24.0),
              _registerButton(),
              Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(29, 185, 84, 1),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Center(
                  child:              TextButton(
               onPressed: () {
                setState(() {
                  _spotifyLogin = getAccessToken();
                });
                _spotifyLogin?.then((bool value) {
                  Navigator.of(context).pushNamed(HomeScreens.routeName);
                  return true;
                }, onError: (error) {
                  showPurchaseDialog(context, dialog: error.toString());
                  return false;
                });
               },
               child: Text(
                    "Spotify",
                    style: TextStyle(
                      color: Color(0xFFFAFAFA),
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
              ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  /////////////////////////////////
  /////////// FUTURE /////////////
  ///////////////////////////////

  Future<bool> getAccessToken() async {
    await dotenv.load(fileName: '.env');
    try {
      var authenticationToken = await SpotifySdk.getAccessToken(
          clientId: dotenv.env['CLIENT_ID'].toString(),
          redirectUrl: dotenv.env['REDIRECT_URL'].toString(),
          scope: 'user-read-email,'
              'user-read-private,'
              'playlist-read-private');
      globals.spotifyToken = authenticationToken;
      return userRequest.loginSpotify(authenticationToken.toString());
    } on PlatformException catch (e) {
      return Future.error('$e.code: $e.message');
    } on MissingPluginException {
      // setStatus('not implemented');
      debugPrint('not implemented');
      return Future.error('not implemented');
    }
  }

  /////////////////////////////////
  /////////// WIDGET /////////////
  ///////////////////////////////

  Widget _loginButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: ButtonTheme(
          minWidth: 500.0,
          height: 100.0,
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                /* NE PAS OUBLIER DE RECHANGER */
                setState(() {
                  _userLogin = userRequest.userLogin(
                      _emailController.text, _passwordController.text);
                });
                _userLogin?.then((bool value) {
                  Navigator.of(context).pushNamed(HomeScreens.routeName);
                  return true;
                }, onError: (error) {
                  showPurchaseDialog(context);
                  return false;
                });
              },
              child:
                  const Text('Log In', style: TextStyle(color: Colors.white)),
            ),
          )),
    );
  }

  void showPurchaseDialog(BuildContext context, {String dialog = "Login refused"}) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              dialog,
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

  Widget _registerButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pushNamed(RegisterScreens.routeName);
          },
          style: const ButtonStyle(),
          child: const Text(
            'Sign Up',
            textAlign: TextAlign.left,
            style: TextStyle(
                decoration: TextDecoration.underline,
                color: Color(0xff4c505b),
                fontSize: 18),
          ),
        ),
      ],
    );
  }
}

// class DeepLinkBloc extends Bloc {

//   //Event Channel creation
//   static const stream = const EventChannel('com.example.frontendApp/events');

//   //Method channel creation
//   static const platform = const MethodChannel('com.example.frontendApp/callback');

//   StreamController<String> _stateController = StreamController();

//   Stream<String> get state => _stateController.stream;

//   Sink<String> get stateSink => _stateController.sink;


//   //Adding the listener into contructor
//   DeepLinkBloc() {
//     //Checking application start by deep link
//     startUri().then(_onRedirected);
//     //Checking broadcast stream, if deep link was clicked in opened appication
//     stream.receiveBroadcastStream().listen((d) => _onRedirected(d));
//   }


//   _onRedirected(String uri) {
//     // Here can be any uri analysis, checking tokens etc, if it’s necessary
//     // Throw deep link URI into the BloC's stream
//     stateSink.add(uri);
//   }


//   @override
//   void dispose() {
//     _stateController.close();
//   }


//   Future<String> startUri() async {
//     try {
//       return platform.invokeMethod('initialLink').toString();
//     } on PlatformException catch (e) {
//       return "Failed to Invoke: '${e.message}'.";
//     }
//   }
// }
//  class PocWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     DeepLinkBloc _bloc = Provider.of<DeepLinkBloc>(context);
//     return StreamBuilder<String>(
//       stream: _bloc.state,
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) {
//           return Container(
//               child: Center(
//                   child: Text('No deep link was used  ')));
//         } else {
//           return Container(
//               child: Center(
//                   child: Padding(
//                       padding: EdgeInsets.all(20.0),
//                       child: Text('Redirected: ${snapshot.data}'))));
//         }
//       },
//     );
//   }
// }
