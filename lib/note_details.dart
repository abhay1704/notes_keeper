import 'package:flutter/material.dart';
import 'dart:math' as math;


class NoteDetail extends StatefulWidget {
  final String id;
  final String title;
  final String details;
  const NoteDetail({required this.title,required this.id,required this.details});

  @override
  State<NoteDetail> createState() => _NoteDetailState();
}

class _NoteDetailState extends State<NoteDetail> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text(widget.title),
      ) ,
      body: Card(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 8.0, 10.0, 10.0),
          child: SingleChildScrollView(
            child: Text(widget.details,
              textScaleFactor: 2,
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w700,
                color: Color((math.Random().nextDouble() * 0x00FF00).toInt())
                    .withAlpha(0xff).withOpacity(1.0),
              ),
            softWrap: true,
         overflow: TextOverflow.clip,
            ),
          ),
        ),
        color: Color((math.Random().nextDouble() * 0x00FF00).toInt())
       .withOpacity(0.3),
      ),
    );
  }
}
