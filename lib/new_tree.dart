import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path/path.dart';

class NewTreePage extends StatefulWidget {
  @override
  State<NewTreePage> createState() => _NewTreePageState();
}

class _NewTreePageState extends State<NewTreePage> {

  // File? _imageFile ;
  // final picker = ImagePicker();
  // Future pickImage() async {
  //   final pickedFile = await picker.getImage(source: ImageSource.camera);
  //   setState(() {
  //     _imageFile = File(pickedFile.path);
  //   });
  // }

  CollectionReference _tree = FirebaseFirestore.instance.collection('tree');

  bool loading = false;

  final _username    = TextEditingController();
  final _location    = TextEditingController();

  takePicture() async{
    // final ImagePicker _picker = ImagePicker();
    // final XFile? photo = await _picker.pickImage(source: ImageSource.camera);

  }

  showAlertDialog(BuildContext context, message) {
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text(message),
      actions: [
        okButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showSuccessAlertDialog(BuildContext context) {
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      },
    );
    AlertDialog alert = AlertDialog(
      title: const Text("Congratulations 🥳"),
      content: const Text("Your Request Has Been Submitted For Review!"),
      actions: [
        okButton,
      ],
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Trees"),
      ),
      body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Hero(
                  child: Image.asset('tree.png', width: 100,),
                  tag: 'tree',
                ),
                const Text("Plant Your Tree & Upload Picture", style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.black),textAlign: TextAlign.center,),
                SizedBox(height: 20,),
                TextField(
                  controller: _username,
                  style:  TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.supervised_user_circle),
                    border: OutlineInputBorder(),
                    labelText: 'Your Name',
                    labelStyle: TextStyle(fontSize: 18),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _location,
                  style:  TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.map),
                    border: OutlineInputBorder(),
                    labelText: 'Tree Location',
                    labelStyle: TextStyle(fontSize: 18),
                  ),
                ),
                SizedBox(height: 20,),
                loading ? LinearProgressIndicator() : ElevatedButton(
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(16),
                      child:  Center(
                        child: const Text("Submit Request", style: TextStyle(fontSize: 24),),
                      )
                  ),
                  onPressed: (){
                    setState(() {
                      loading = true;
                    });
                    if(_username.text.isEmpty){
                      showAlertDialog(context,"Your Name is required");
                      setState(() {
                        loading = false;
                      });
                    }else if(_location.text.isEmpty){
                      showAlertDialog(context,"Tree Location is required");
                      setState(() {
                        loading = false;
                      });
                    }else{

                      DateTime now = DateTime.now();
                      String formattedDate = DateFormat('d-M-y').format(now);

                      _tree.add({
                        'username': _username.text,
                        'location': _location.text,
                        'datetime': formattedDate,
                        'status'  : false,
                      }).then((value) => (){
                      });
                      setState(() {
                        loading = false;
                      });
                      showSuccessAlertDialog(context);
                    }
                  },
                ),
              ],
            ),
          )
      ),
    );
  }

}
