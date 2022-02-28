import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:happy_shouket/src/sessions_collection/session_three/session_three_screen.dart';

final firestoreInstance = FirebaseFirestore.instance;

class FeedbackData extends StatefulWidget {
  static const String routeName = 'feedback_data';

  @override
  _FeedbackDataState createState() => _FeedbackDataState();
}

// class Record {
//   final String userId;
//   final String feedback;
//   final String additionalComments;
//   final DocumentReference reference;
//
//   Record.fromMap(Map<String, dynamic> map, {this.reference})
//       : assert(map['user'] != null),
//         assert(map['feedback'] != null),
//         assert(map['comment'] != null),
//         userId = map['user'],
//         feedback = map['feedback'],
//         additionalComments = map['comments'];
//
//   Record.fromSnapshot(DocumentSnapshot documentSnapshot)
//       : this.fromMap(documentSnapshot.data(),
//             reference: documentSnapshot.reference);
//   @override
//   String toString() => "Record<$userId:$feedback:$additionalComments>";
// }

class _FeedbackDataState extends State<FeedbackData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('USER FEEDBACK REPORT'),
        actions: [
          TextButton(
            onPressed: () =>
                // signout();
                Navigator.pushNamed(context, SessionThreeScreen.routeName),
            child: Text(
              'Next',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestoreInstance.collection('feedback').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return LinearProgressIndicator();
          }

          return DataTable(
            columns: <DataColumn>[
              DataColumn(label: Text('UserId')),
              DataColumn(label: Text('Feedback')),
              DataColumn(label: Text('Comments')),
              DataColumn(label: Text('FeedBack Session')),
            ],
            rows: _buildList(snapshot.data),
          );
        },
      ),
    );
  }

  List<DataRow> _buildList(QuerySnapshot snapshot) {
    List<DataRow> newList =
        snapshot.docs.map((DocumentSnapshot documentSnapshot) {
      //     BuildContext context, List<DocumentSnapshot> snapshot) {
      //   return snapshot.map((data) => _buildListItem(context, data)).toList();
      // }
      //
      // DataRow _buildListItem(BuildContext context, DocumentSnapshot data) {
      //   final record = Record.fromSnapshot(data);

      return DataRow(cells: [
        DataCell(Text(documentSnapshot['user'].toString())),
        DataCell(Text(documentSnapshot['feedback'].toString())),
        DataCell(Text(documentSnapshot['comments'].toString())),
        DataCell(Text(documentSnapshot['feedbackId'].toString())),
      ]);
    }).toList();
    print(newList);
    return newList;
  }
}
