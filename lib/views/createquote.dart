// ignore: import_of_legacy_library_into_null_safe
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CreateQuote extends StatefulWidget {
  const CreateQuote({Key? key}) : super(key: key);

  @override
  _CreateQuoteState createState() => _CreateQuoteState();
}

class _CreateQuoteState extends State<CreateQuote>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  TextEditingController content = TextEditingController();
  final ref = FirebaseFirestore.instance.collection("Quotes");
  // late String content;
  bool isfavourite = false;
  late String id;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // actions: [
        //   TextButton(
        //     onPressed: () {
        //       ref.add({
        //         'Content': content.text,
        //       }).whenComplete(() => Navigator.pop(context));
        //     },
        //     child: Icon(Icons.save),
        //   )
        // ],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              "Quot",
              style: TextStyle(fontSize: 22, color: Colors.white),
            ),
            Text(
              "Pad",
              style: TextStyle(fontSize: 22, color: Colors.cyanAccent),
            )
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                style: TextStyle(fontSize: 18, color: Colors.white,),textAlign: TextAlign.center,
                decoration: InputDecoration(
                    hintText: "Write what you think!!...",
                    contentPadding: EdgeInsets.symmetric(vertical: 30.0)),
                scrollPadding: EdgeInsets.all(50.0),
                keyboardType: TextInputType.multiline,
                maxLines: 30,
                autofocus: true,
                onChanged: (value) {
                  content = value as TextEditingController;
                },
                controller: content,
              )
            ],
          ),
        ),
      ),
      resizeToAvoidBottomInset: true,
      floatingActionButton: FloatingActionButton(
        onPressed: () { ref.add({
                'Content': content.text,
          
        },)..whenComplete(() => Navigator.pop(context));},
          // uploadingData(content);
          // Navigator.of(context).pop();

          
       
        child: Icon(Icons.check),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.black54,
        shape: CircularNotchedRectangle(),
        notchMargin: 5,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // IconButton(
            //     onPressed: () {}, icon: Icon(Icons.), color: Colors.white),
            // IconButton(
            //   onPressed: () {},
            //   icon: Icon(Icons.delete),
            //   color: Colors.white,
            // )
          ],
        ),
      ),
      
    );
  }
}
