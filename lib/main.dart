import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:treeplantationdrive/new_tree.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'all_tree.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tree Plantation Drive',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'Tree Plantation Drive'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _loading = true;
  String _count = "";

  void getTreeCount(){
    FirebaseFirestore.instance
        .collection('counter')
        .doc('counter')
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        dynamic data = documentSnapshot.data();
        setState(() {
          _count    = data['count'];
          _loading  = false;
        });
      } else {
        //error
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getTreeCount();
  }

  // GoogleSignIn _googleSignIn = GoogleSignIn(
  //   scopes: [
  //     'email',
  //     'https://www.googleapis.com/auth/contacts.readonly',
  //   ],
  // );

  // Future<void> _handleSignIn() async {
  //   try {
  //     await _googleSignIn.signIn();
  //   } catch (error) {
  //     print(error);
  //   }
  // }

  //


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Hero(
                child: Image.asset('tree.png', width: 300,),
                tag: 'tree',
              ),
              SizedBox(height: 20,),
              const Text("Let's Plant With Us", style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.black),),
              const SizedBox(height: 5,),
              const Text("Let's Preserve Pleasant Beauty of Pakistan", style: TextStyle(fontSize: 18, color: Colors.black),),
              const SizedBox(height: 5,),
              Divider(),
              const SizedBox(height: 5,),
              _loading ? Container() : Text("Tree Counter: $_count", style: TextStyle(fontSize: 36, color: Colors.green, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),),
              SizedBox(height: 5,),
              ElevatedButton(
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(16),
                    child:  Center(
                      child: const Text("Plant Your Tree Now", style: TextStyle(fontSize: 32),),
                    )
                ),
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NewTreePage()),
                  );
                },
              ),
              const SizedBox(height: 5,),

              const SizedBox(height: 5,),
              TextButton(onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AllTreePage()),
                );
              }, child: Text("View All Trees", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),)),
            ],
          ),
        )
      ),
    );
  }
}