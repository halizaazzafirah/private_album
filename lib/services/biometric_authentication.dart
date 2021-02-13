import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:private_photo_album/screens/tab_screen.dart';

class BiometricAuthentication extends StatefulWidget {
  @override
  _BiometricAuthenticationState createState() =>
      _BiometricAuthenticationState();
}

class _BiometricAuthenticationState extends State<BiometricAuthentication> {
  LocalAuthentication localAuth = LocalAuthentication();
  bool _canCheckBiometric;
  List<BiometricType> _availableBiometric;

  // Check the biometric sensors can use or not
  Future<void> _checkBiometric() async {
    bool canCheckBiometric = await localAuth.canCheckBiometrics;

    setState(() {
      _canCheckBiometric = canCheckBiometric;
    });
  }

  // Get available biometric sensors
  Future<void> _getAvailableBiometrics() async {
    List<BiometricType> availableBiometric =
        await localAuth.getAvailableBiometrics();

    setState(() {
      _availableBiometric = availableBiometric;
    });
  }

  // Authentication
  Future<void> _authenticate() async {
    bool authenticated = false;

    authenticated = await localAuth.authenticateWithBiometrics(
        localizedReason: "Authenticate to access your private photo album.",
        useErrorDialogs: true,
        stickyAuth: false);

    setState(() {
      if (authenticated) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TabScreen(),
          ),
        );
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _checkBiometric();
    _getAvailableBiometrics();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey,
        body: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 12.0,
            horizontal: 24.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 24.0,
                ),
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.fingerprint,
                      size: 130.0,
                    ),
                    SizedBox(height: 15.0),
                    Text(
                      'Fingerprint Authentication',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 15.0),
                    Container(
                      width: double.infinity,
                      child: RaisedButton(
                        onPressed: _authenticate,
                        elevation: 0.0,
                        color: Colors.blueAccent[200],
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 24.0),
                          child: Text(
                            'Authenticate',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
