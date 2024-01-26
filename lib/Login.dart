import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailcontroller= TextEditingController();

  final passcontroller= TextEditingController();
  Future signin()  async {
    try {
      showLoadingDialog();

      List<String> signInMethods = await FirebaseAuth.instance
          .fetchSignInMethodsForEmail(emailcontroller.text);
      if (signInMethods.isNotEmpty) {
        Navigator.of(context).pop(); // Hide
        showErrorPopup('User with this email already exists.');
      }
      else {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailcontroller.text, password: passcontroller.text);
        Navigator.of(context).pop();
      }
    }
    catch(e){
      print(e);
      Navigator.of(context).pop();
      showErrorPopup(' ${e.toString()}');
    }
  }
    void showLoadingDialog() {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Signing up...'),
              ],
            ),
          );
        },
      );
    }
    void showErrorPopup(String errorMessage) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(errorMessage),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }

  String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return value!.isNotEmpty && !regex.hasMatch(value)
        ? 'Enter a valid email address'
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Login Page")),
        backgroundColor: Colors.greenAccent,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20,),
            Container(
              child: Text("Login Here"
                ,style: TextStyle(
                  fontSize: 20,
                ),),
            ),
            SizedBox(height: 20,),
            Row(
              children: [SizedBox(width: 55,),
                Container(child: Text("Email",
                  style: TextStyle(
                    fontSize: 15,
                  ),),),
              ],
            ),
            SizedBox(height: 5,),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  validator: validateEmail,
                  controller: emailcontroller,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    hintText: "Enter Your Email",
                  ),
                )
            ),

            SizedBox(height: 20,),
            Row(
              children: [SizedBox(width: 55,),
                Container(child: Text("Password",
                  style: TextStyle(
                    fontSize: 15,
                  ),),),
              ],
            ),
            SizedBox(height: 5,),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: TextFormField(
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  validator: validateEmail,
                  controller: passcontroller,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    hintText: "Enter Your Password",
                  ),
                )
            ),

            SizedBox(height: 20,),
            GestureDetector(
              onTap: signin,
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                      color:Colors.lightGreen,
                      borderRadius: BorderRadius.circular(10)
                  ),

                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 20),
                    child: Text("Login"
                      ,style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold,),
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              child: Text("Wanna Register?"),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
              },
            )
          ],
        ),
      ),

    );
  }
}
