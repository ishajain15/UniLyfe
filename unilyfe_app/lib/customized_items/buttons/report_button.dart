
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unilyfe_app/widgets/provider_widget.dart';
// ignore: must_be_immutable
class ReportButton extends StatefulWidget{
  ReportButtonState createState()=> ReportButtonState();
}

class ReportButtonState extends State<ReportButton>{
  void bottom_Sheet(context){
    reportsheet(context){
      return Container(
          child:Text("new"),
      );
    }
    showModalBottomSheet(context: context, builder: (BuildContext bc){
      return Container(
        height: MediaQuery.of(context).size.height * .60,
        child: Text("hi")
        // child: ElevatedButton(
        //   onPressed: () => reportsheet(context),
        //   style: ElevatedButton.styleFrom(
        //     primary: Color(0xFFF46C6B),
        //     onPrimary: Colors.white,
        //     shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(10.0)),
        //   ),
        //   child: Text(
        //     'Report',
        //   ),
        // ),
      );
    });

  }
      @override
  Widget build(BuildContext context){
        return IconButton(
          icon: Icon(Icons.more_vert),
          onPressed: () => bottom_Sheet(context),
        );
      }
}
