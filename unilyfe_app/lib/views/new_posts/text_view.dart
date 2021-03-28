import 'package:flutter/material.dart';
import 'package:profanity_filter/profanity_filter.dart';
import 'package:unilyfe_app/models/post.dart';
import 'package:unilyfe_app/views/new_posts/submit_view.dart';

String censorBadWords(String badString) {
  final filter = ProfanityFilter();
  //Censor the string - returns a 'cleaned' string.
  String cleanString = filter.censor(badString);
  print('Censored version of "$badString" is "$cleanString"');
}

class NewPostDateView extends StatelessWidget {
  NewPostDateView({Key key, @required this.post}) : super(key: key);
  final Post post;

  @override
  Widget build(BuildContext context) {
    var _textController = TextEditingController();
    _textController.text = post.text;

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
            SizedBox(
              height: 10,
            ),
            Text(
              'Title: ${post.title}',
            ),
            SizedBox(
              height: 10,
            ),
            Text('\nEnter Text'),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: TextField(
                controller: _textController,
                autofocus: true,
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  post.time = DateTime.now();

                  post.text = _textController.text;

                  //This string contains the profanity 'ass'
                  String badString = 'You are an ass';

                  // //Check for profanity - returns a boolean (true if profanity is present)
                  // bool hasProfanity = filter.hasProfanity(badString);
                  // print('The string $badString has profanity: $hasProfanity');

                  // //Get the profanity used - returns a List<String>
                  // List<String> wordsFound = filter.getAllProfanity(badString);
                  // print('The string contains the words: $wordsFound');

                  

                  
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NewPostBudgetView(post: post)),
                  );
                },
                child: Text('Continue')),
          ],
        ),
      ),
    );
  }
}
