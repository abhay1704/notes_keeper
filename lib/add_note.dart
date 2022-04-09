import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'notes_data.dart';
import 'dart:math' as math;


class AddNotes extends StatelessWidget {
  AddNotes({Key? key,required this.uid}) : super(key: key);
  final String uid;
  final _formKey = GlobalKey<FormState>();
  final titlecontroller = TextEditingController();
  final detailscontroller = TextEditingController();

  Future<void>updateList(BuildContext context)
  async {
    try {await FirebaseFirestore.instance.collection('notes').doc(uid).collection('UserNotes').add({
      "title":titlecontroller.value.text,
      "details": detailscontroller.value.text
    }
    );
    Navigator.pop(context); } catch(e) {
      print(e.toString());
      Navigator.pop(context);
    }
  }

  final Notes notes = Notes();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Adding New Note"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 7.0,left: 8.0,right: 8.0),

        child: Form(
          key: _formKey,
          child:Column(
            children: [
              Card(
                child: Column(
                  children: [
                    const Text('title',
                      textScaleFactor: 2,
                    ),

                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: titlecontroller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'title is compulsory';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                  .withOpacity(0.4),
              ),
              Card(
                child:Column(
                  children: [
                    const Text('details',
                      textScaleFactor: 2,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.multiline,
                      controller: detailscontroller,
                      maxLines: 4,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Details are compulsory';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
                color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                    .withOpacity(0.4),

              ),

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    updateList(context);
                    Navigator.pop(context);
                  }
                },
                autofocus: true ,

                child: const Text('Add New Notes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
