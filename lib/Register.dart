import 'package:classword/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

import 'HomeScreen.dart';
import 'Login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final _formKey = GlobalKey<FormState>();
  final emailcontroller= TextEditingController();
  final passcontroller= TextEditingController();
  final pass1controller= TextEditingController();
  final usercontroller = TextEditingController();
  String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);
    if(value!.isEmpty){return 'Enter some Text';}
    return value.isNotEmpty && !regex.hasMatch(value)
        ? 'Enter a valid email address'
        : null;
  }



  Future signup() async {
    try {
      showLoadingDialog();

      List<String> signInMethods = await FirebaseAuth.instance.fetchSignInMethodsForEmail(emailcontroller.text);
      if (signInMethods.isNotEmpty) {

        Navigator.of(context).pop(); // Hide
        showErrorPopup('User with this email already exists.');
      } else {
        await FirebaseFirestore.instance.collection('user').add({
          'username': usercontroller.text,
          'email': emailcontroller.text,
          'password': passcontroller.hashCode,
          'timestamp': DateTime.now(),
        });
        _sendmail();
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailcontroller.text,
          password: passcontroller.text,
        );
        Navigator.of(context).pop();

        showSuccessPopup('User created successfully');

      }
    } catch (e) {

      print('$e');
      Navigator.of(context).pop();
      showErrorPopup('Error creating user: ${e.toString()}');
    }
  }
  void _sendmail() async{
    String username = 'mustufamapara@gmail.com';
    String password = 'hnfw mtsg vsig wioq';

    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, 'Mustafa Mapara')
      ..recipients.add(emailcontroller.text)
      ..subject = 'Successfully registered ${DateTime.now()}'
      ..text = 'Hello there! you have been registered';
    print(message);
    await send(message, smtpServer);
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
  void showSuccessPopup(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text(errorMessage),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeScreen()), (route) => false);
              },
              child: Text('OK'),
            ),
          ],
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




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Register Page")),
        backgroundColor: Colors.greenAccent,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 20,),
                Container(
                  child: Text("Register Here"
                  ,style: TextStyle(
                      fontSize: 20,
                    ),),
                ),
        
                //UserName
                SizedBox(height: 20,),
                Row(
                  children: [SizedBox(width: 55,),
                    Container(child: Text("Username",
                      style: TextStyle(
                        fontSize: 15,
                      ),),),
                  ],
                ),
                SizedBox(height: 5,),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: TextFormField(
                      validator: (value){
                        if(value==null||value.isEmpty){return 'Please enter some text';}
                        return null;
                      },
                      textInputAction: TextInputAction.done,
                      controller: usercontroller,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        hintText: "Enter Your UserName",
                      ),
                    )
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
                      validator: (value){
                        if(value==null||value.isEmpty){return 'Please enter some text';}
                        return null;
                      },
                      obscureText: true,
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
                Row(
                  children: [SizedBox(width: 55,),
                    Container(child: Text("Confirm Password",
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
                      validator: (value){
                        if(value==null||value.isEmpty){return 'Please enter some text';}
                        else if(value != passcontroller.text){return 'Both Password must be same';}
                        return null;
                      },
                      controller: pass1controller,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        hintText: "Enter Your Password Again",
        
                      ),
                    )
                ),
        
        
                SizedBox(height: 20,),
            GestureDetector(
              onTap: signup,
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                      color:Colors.lightGreen,
                      borderRadius: BorderRadius.circular(10)
                  ),
        
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 20),
                    child: Text("Register"
                      ,style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold,),
                    ),
                  ),
                ),
              ),
            ),
                GestureDetector(
                  child: Text("Already Login?"),
                  onTap: (){
                    Navigator.pushAndRemoveUntil(context,  MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
                    // Navigator.pushAndRemoveUntil(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => LoginPage(),(route) => false)),
                    // );
                  },
                )
              ],
            ),
          ),
        ),
      ),

    );
  }
}
