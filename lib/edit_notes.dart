import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'notes_data.dart';
import 'dart:math' as math;

class EditNotes extends StatelessWidget {
  final String id;
  final String title;
  final String details;
  EditNotes({required this.id,required this.title,required this.details,});

  final _formKey = GlobalKey<FormState>();

  late final titleeditcontroller = TextEditingController(text: title);
  late final detailseditcontroller = TextEditingController(text: details);



  Future<void>updateList(BuildContext context)
  async {
    try {
      await FirebaseFirestore.instance.collection('notes').doc(id).update({
        "title":titleeditcontroller.value.text,
        "details": detailseditcontroller.value.text
      });
      Navigator.pop(context); } catch(e) {
      print('e');
      Navigator.pop(context);
    }
  }

  final Notes notes = Notes();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editing Notes"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left:8.0 ,right:8.0,top:10 ),

        child: Form(
          key: _formKey,
          child:Column(
            children: [
              Card(
                child: Column(
                  children: [
                    const Text('Name',
                      textScaleFactor: 2,
                    ),

                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: titleeditcontroller,
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
                      controller: detailseditcontroller,
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

                child: const Text('Edit Notes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
