import 'package:flutter/material.dart';
import 'package:profanity_filter/profanity_filter.dart';
import 'package:unilyfe_app/customized_items/custom_warning.dart';
import 'package:unilyfe_app/models/post.dart';
import 'package:unilyfe_app/views/new_posts/text_view.dart';

String censorBadWords(String badString) {
  final filter = ProfanityFilter();
  //Censor the string - returns a 'cleaned' string.
  var cleanString = filter.censor(badString);
  return cleanString;
}

class NewPostLocationView extends StatelessWidget {
  NewPostLocationView({Key key, @required this.post}) : super(key: key);
  final Post post;

  @override
  Widget build(BuildContext context) {
    var _titleController = TextEditingController();
    _titleController.text = post.title;

    var _locController = TextEditingController();
    _locController.text = post.location;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          'CREATE A TEXT POST',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Enter a Post Title'),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: TextField(
                controller: _titleController,
                autofocus: true,
              ),
            ),
            Text('Enter a location'),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: TextField(
                controller: _locController,
                autofocus: true,
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                post.title = _titleController.text;
                post.location = _locController.text;

                final filter = ProfanityFilter();
                var hasProfanity = filter.hasProfanity(post.title);
                var postIt = true;

                if (hasProfanity) {
                  postIt = false;
                  //Get the profanity used - returns a List<String>
                  var wordsFound = filter.getAllProfanity(post.title);
                  var dialog = CustomAlertDialog(
                      title: 'Do you continue submitting?',
                      message:
                          'The following words will be censored:\n${wordsFound.join(", ")}',
                      onFirstPressed: () {
                        postIt = true;
                        post.title = censorBadWords(post.title);
                        Navigator.of(context, rootNavigator: true).pop();
                      },
                      onSecondPressed: () {
                        postIt = false;
                        //Navigator.of(context).pop();
                        _titleController.clear();
                        _locController.clear();
                      },
                      firstText: 'Yes',
                      secondText: 'No');
                  await showDialog(
                      context: context,
                      builder: (BuildContext context) => dialog);
                }

                if (postIt) {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NewPostDateView(post: post)),
                  );
                }
              },
              child: Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
