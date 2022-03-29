import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AllTreePage extends StatefulWidget {
  @override
  State<AllTreePage> createState() => _AllTreePageState();
}

class _AllTreePageState extends State<AllTreePage> {

  final Stream<QuerySnapshot> _treeStream = FirebaseFirestore.instance.collection('tree').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Trees"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _treeStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
              return ListTile(
                  leading: CircleAvatar(child: Image.asset('tree.png'), backgroundColor: Colors.white,),
                  title: Text(data['location'] ?? '', style: TextStyle(fontSize: 18),),
                  subtitle: Text("Planted by ${data['username']}", style: TextStyle(fontSize: 16),),
                  trailing: Text("${data['datetime']}"),
              );
            }).toList(),
          );
        })
    );
  }
}
