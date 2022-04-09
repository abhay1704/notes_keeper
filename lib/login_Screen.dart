import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController(text: 'Email');

  final passwordController = TextEditingController(text: 'Password');

  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String uid;

  Future<void>SignIn(BuildContext context) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text).then((value)
      {
    if(emailController.value != null && value.user! != null){
     uid = value.user!.uid.toString();
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => (notes_home(uid: uid)))
    );

    } else {
    throw Error();
    }; }
      );} catch(e) {
      setState(() {
        print(e.toString());
        emailController.text='Email';
        passwordController.text='Password';
      });
    }
  }

  Future<void>SignUp(BuildContext context) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text).then((value)
      {
        if(value!=null && value.user! != null){
          uid = value.user!.uid.toString();
          FirebaseFirestore.instance.collection('notes').doc(uid).
          set({"email": emailController.text});//created new document
           FirebaseFirestore.instance.collection('notes').doc(uid).collection('UserNotes')
              .doc().set({
            'title':"to do's",
             'details':"go on edit section to write here",
          });//Started sub collection "UserData" in newly created doc

          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => (notes_home(uid: uid)))
          );
        } else {
          throw Error();

        }; }
      );} catch(e) {
     setState(() {
       print(e.toString());
       emailController.text='Email';
       passwordController.text='Password';
     });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login/Signup'),
        centerTitle: true,
        backgroundColor: Colors.lightBlue[500],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 100.0, 8.0, 16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                      const Text('Notes Keeper',
                      style: const TextStyle(
                        color: Colors.blue,
                        letterSpacing: 1.3,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 100.0, 8.0, 16.0),
                      child: ListTile(
                        leading: const Icon(Icons.email),
                        title: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter email';
                            }
                            return null;
                          } ,
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 16.0),
                      child: ListTile(
                        leading: const Icon(Icons.password_sharp),
                        title: TextFormField(
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value == null || value.isEmpty ) {
                              return 'Enter password';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          SignIn(context);
                        }
                      },
                       child: const Text('Sign In'),
                      autofocus: true,
                  ),
                  ElevatedButton(onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      SignUp(context); } },
                    child: const Text('Sign Up'),
                    autofocus: true,
                  ),
                ],
              )
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.lightBlue[100],
      resizeToAvoidBottomInset: true,
    );
  }
}
