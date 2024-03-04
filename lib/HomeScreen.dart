import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

extension StringExtension on String {
  String capitalizeFirst() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}

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
      appBar: AppBar(
        title: Center(
          child: Text("MY ACCOUNT"
          ,style: TextStyle(
              color: Colors.white,
              fontSize: 20
            ),),
        ),
        backgroundColor: Colors.black,

      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 10,),
              Container(
                child:Column(
                  children: [
                  Text(
                    "YOU ARE SIGNED IN AS ",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                    Text(
                        "${user.email}".capitalizeFirst()
                    ),
                    SizedBox(height: 10,)
                  ],
                )
                // child: Text(
                //   "YOU ARE SIGNED IN AS \n "
                //       "${user.email}"
                // ),
              ),
              TextButton(
                onPressed: () {
                  try {
                    FirebaseAuth.instance.signOut();
                  } catch (e) {
                    print(e);
                  }
                },
                child: Center(
                  child: Text(
                    "Sign Out",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue, // Set text color to blue
                      decoration: TextDecoration.underline, // Add underline
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity, // Set width to full width
                child: TextButton(
                  onPressed: () {
                    // Add onPressed functionality here
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.lightBlueAccent), // Background color
                    padding: MaterialStateProperty.all(EdgeInsets.all(16.0)), // Add padding for better touch area
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0), // Set BorderRadius to 0 for no border radius
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.account_circle,color: Colors.white,), // Icon on the left
                      Text(
                        "MY PROFILE", // Text of the button
                        style: TextStyle(
                          color: Colors.white, // Text color
                          fontWeight: FontWeight.bold, // Bold text
                          fontSize: 16, // Font size
                        ),
                      ),
                      Icon(Icons.arrow_forward), // Arrow icon on the right
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity, // Set width to full width
                child: TextButton(
                  onPressed: () {
                    // Add onPressed functionality here
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.lightBlueAccent), // Background color
                    padding: MaterialStateProperty.all(EdgeInsets.all(16.0)), // Add padding for better touch area
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0), // Set BorderRadius to 0 for no border radius
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.payment,color: Colors.white,), // Icon on the left
                      Text(
                        "Payment Method", // Text of the button
                        style: TextStyle(
                          color: Colors.white, // Text color
                          fontWeight: FontWeight.bold, // Bold text
                          fontSize: 16, // Font size
                        ),
                      ),
                      Icon(Icons.arrow_forward), // Arrow icon on the right
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity, // Set width to full width
                child: TextButton(
                  onPressed: () {
                    // Add onPressed functionality here
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.lightBlueAccent), // Background color
                    padding: MaterialStateProperty.all(EdgeInsets.all(16.0)), // Add padding for better touch area
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0), // Set BorderRadius to 0 for no border radius
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.directions_car,color: Colors.white,), // Icon on the left
                      Text(
                        "My Vehicle", // Text of the button
                        style: TextStyle(
                          color: Colors.white, // Text color
                          fontWeight: FontWeight.bold, // Bold text
                          fontSize: 16, // Font size
                        ),
                      ),
                      Icon(Icons.arrow_forward), // Arrow icon on the right
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
