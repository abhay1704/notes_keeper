import 'package:flutter/material.dart';
import 'package:notes_maker/add_note.dart';
import 'dart:math' as math;
import 'note_details.dart';
import 'notes_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'edit_notes.dart';
import 'add_note.dart';

class notes_home extends StatefulWidget {
   notes_home({Key? key}) : super(key: key);
   final Notes notes = Notes();

  @override
  State<notes_home> createState() => _notes_homeState();
}

class _notes_homeState extends State<notes_home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text('My Notes'),
        centerTitle: true,
    ),
    floatingActionButton: FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder:
        (BuildContext context) => AddNotes()));
      },
    ),
      body: StreamBuilder(
         stream: FirebaseFirestore.instance.collection('notes').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if(!snapshot.hasData) {
        return const Center(
         child: CircularProgressIndicator(),
        );
      }

     return ListView(children: <Widget>[
    ...snapshot.data!.docs.map(
    (document) {
    return activityWidget(
    title: document['title'],
    details: document['details'],
    id: document.id,
    );
    },
    ),
    ]);
    }
     ),
    backgroundColor: Colors.yellowAccent,
    );
  }
  }


class activityWidget extends StatelessWidget {
  final String title;
  final String id;
  final String details;
  const activityWidget({required this.title,required this.id,required this.details}) ;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 2.0),
        child: Slidable(
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (context) {
                  Navigator.push(context,
                    MaterialPageRoute (
                      builder: (BuildContext context) => EditNotes(id: id,title: title, details: details),
                    ),
                  );
                },
                backgroundColor: const Color(0xFF7BC043),
                foregroundColor: Colors.white,
                icon: Icons.edit,
                label: 'Edit',
              ),
              SlidableAction(
                onPressed: (context) {
                  FirebaseFirestore.instance.collection('notes').doc(id).delete();
                },
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
            ],
          ),
          child: ListTile(
             leading:Icon(Icons.local_activity_rounded,
                   size: 36.0,
                   color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                                           .withOpacity(1.0),
                        ) ,
            title: Padding(
             padding:  const EdgeInsets.fromLTRB(10.0, 15.0, 4.0, 15.0),
              child: InkWell(
                      child: Text(title,
                             textScaleFactor: 2,
                             style: TextStyle(
                             color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                                        .withAlpha(0xff),
                             fontStyle: FontStyle.italic,
                                ),
                       ),
                   onTap: () {
                              Navigator.push(context,
                            MaterialPageRoute(
                         builder: (BuildContext context) => NoteDetail(title: title,id: id,details: details),
                                   )
                    );
                   },
                   ),
                   ),
          trailing:const Icon(Icons.swipe,
                        size: 36.0,),
    tileColor: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
          .withOpacity(0.3),
    ),
        ),
      ),
      shadowColor: Colors.deepPurple,
    );
  }
}




