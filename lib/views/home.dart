// ignore: import_of_legacy_library_into_null_safe

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// ignore: unused_import
// ignore: import_of_legacy_library_into_null_safe
import 'package:quotpad/views/createquote.dart';
import 'package:quotpad/views/editquote.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
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

  late String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
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
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("Quotes").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            return StaggeredGridView.countBuilder(
              staggeredTileBuilder: (index) =>
                  StaggeredTile.fit(1),
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              crossAxisCount: 2,
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: (){
                     Navigator.push(
              context, MaterialPageRoute(builder: (_) => EditQuote(docToEdit: snapshot.data!.docs[index],)));
                    
                  },
                  child: Container(
                    child: new Card(
                      color: Colors.grey,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.tealAccent, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(15),
                        margin: EdgeInsets.all(5),
                        color: Colors.tealAccent[100],
                        child: Column(
                          children: <Widget>[
                            Text(
                              snapshot.data?.docs[index]['Content'],
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w300),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
                //
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CreateQuote()));
        },
        child: Icon(Icons.add),
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
            IconButton(
                onPressed: () {}, icon: Icon(Icons.home), color: Colors.white),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.people),
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
// builder: (context, AsyncSnapshot<QuerySnapshot>snapshot) {
//           if (snapshot.hasData) {
//             // return Column(
//             //   children: [Text(snapshot.data.documents[0]['content'])],
//             // );
//             return GridView.builder(
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2),
//                 itemCount: snapshot.data!.docs.length,
//                 itemBuilder: (context, index) {
//                   return Container(
//                     margin: EdgeInsets.all(20),
//                     height: 150,
//                     color: Colors.grey[200],
//                     child: Column(
//                       children: [Text()],
//                     ),
//                   );
//                 });
//           }
