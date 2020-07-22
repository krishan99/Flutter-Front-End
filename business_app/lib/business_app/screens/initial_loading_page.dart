import 'package:business_app/business_app/models/user.dart';
import 'package:business_app/business_app/services/services.dart';
import 'package:business_app/theme/themes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InitialLoadingPage extends StatelessWidget {
  Widget _getServerErrorPage() {
    return _getBasicTextPage("There was an error contacting the server. Make sure you have internet.");
  }

  Widget _getBasicTextPage(String text) {
    return Scaffold(
      body: Container(
      padding: EdgeInsets.all(40),
      alignment: Alignment.center,
        child: Text(text, textAlign: TextAlign.center,),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return _getBasicTextPage("Getting Account Data...");

          // case ConnectionState.active:
          //   Future.microtask(() => Navigator.of(context).pushReplacementNamed("/home"));
          //   return _getBasicTextPage("Navigating to home page...");
            
          default:
            if (snapshot.hasData) {
              final user = Provider.of<User>(context, listen: false);
              return FutureBuilder(
                future: user.notifyServerOfSignIn(snapshot.data.email),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return _getBasicTextPage("Contacting Server...");
                    
                    default:
                      if (!snapshot.hasError) {
                        if (user.businessName == null || user.businessName.isEmpty) {
                          Future.microtask(() => Navigator.of(context).pushReplacementNamed("/accountInfo"));
                          return _getBasicTextPage("Navigating to account info...");
                        } else {
                          Future.microtask(() => Navigator.of(context).pushReplacementNamed("/dashboard"));
                          return _getBasicTextPage("Navigating to dashboard...");
                        }
                      } else {
                        Future.microtask(() => Navigator.of(context).pushReplacementNamed("/home"));
                        return _getBasicTextPage("Navigating to home page...");
                      }
                  }
                },
              ); 
            } else {
                return _getServerErrorPage();
            }
        }
      }
    );
  }
}