import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unilyfe_app/customized_items/buttons/back_button.dart';
import 'state_management.dart';
import 'text_field.dart';
import 'toolbar.dart';

class TextEditor extends StatefulWidget {
  TextEditor({Key key}) : super(key: key);

  @override
  _TextEditorState createState() => _TextEditorState();
}

class _TextEditorState extends State<TextEditor> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EditorProvider>(
      create: (context) => EditorProvider(),
      builder: (context, child) {
        return SafeArea(
          child: Scaffold(
            body: Stack(
              children: <Widget>[
                Container(
              height: 50000,
              color: Colors.white,
                ),
                new Positioned(
                  top: 30,
                  left: 0,
                  right: 0,
                  bottom: 56,
                  child: Consumer<EditorProvider>(
                    builder: (context, state, _) {
                      return SmartTextField(type: state.selectedType);
                    }
                  ),
                ),
                new Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Selector<EditorProvider, SmartTextType>(
                    selector: (buildContext, state) => state.selectedType,
                    builder: (context, selectedType, _) {
                      return Toolbar(
                        selectedType: selectedType,
                        onSelected: Provider.of<EditorProvider>(context,
                          listen: false).setType,
                      );
                    },
                  ),
                  
                ),
        Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          FlatButton(
            onPressed: () => debugPrint("pressed"),
            child: new Text("Add Picture",
              style: new TextStyle(
                fontSize: 16,
                color: Color(0xFFF46C6B)
              )
            )
          ),
            FlatButton(
            onPressed: () => debugPrint("pressed"),
            child: new Text("Post",
              style: new TextStyle(
                fontSize: 16,
                color: Color(0xFFF46C6B)
              )
            )
          ),
        ],
      ),
              ], 
            )
          ),
        );
      }
    );
    
  }
}