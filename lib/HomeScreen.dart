import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              child: Text(
                "Welcome User ${user.email} "
              ),
            ),
            FloatingActionButton(child: Text("SignOut")
                ,onPressed:(){try{ FirebaseAuth.instance.signOut();}
            catch(e) {
              print(e);
            }
            } )
          ],
        ),
      ),
    );
  }
}
