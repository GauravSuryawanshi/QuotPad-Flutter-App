import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EditQuote extends StatefulWidget {
  DocumentSnapshot docToEdit;
  EditQuote({required this.docToEdit});

  @override
  _EditQuoteState createState() => _EditQuoteState();
}

class _EditQuoteState extends State<EditQuote> {
  TextEditingController content = TextEditingController();
  final ref = FirebaseFirestore.instance.collection("Quotes");
  @override
  void initState() {
    content = TextEditingController(text: widget.docToEdit.data()['Content']);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
             widget.docToEdit.reference.delete().whenComplete(() => Navigator.pop(context));
              
            },
            child: Icon(Icons.delete),
          )
        ],
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
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    hintText: "Write what you think!!...",
                    contentPadding: EdgeInsets.symmetric(vertical: 30.0)),
                scrollPadding: EdgeInsets.all(50.0),
                keyboardType: TextInputType.multiline,
                maxLines: 100,
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
        onPressed: () {
          widget.docToEdit.reference.update(
            {
              'Content': content.text,
            },
          ).whenComplete(() => Navigator.pop(context));
        },
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
