import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/post.dart';

class HomeView extends StatelessWidget {
  final List<Post> posts = [Post("post #1", DateTime.now(), DateTime.now(), 200.00, "Text"),
  Post("post #2", DateTime.now(), DateTime.now(), 200.00, "Text"),
  Post("post #3", DateTime.now(), DateTime.now(), 200.00, "Text"),
  Post("post #4", DateTime.now(), DateTime.now(), 200.00, "Text"),
  Post("post #5", DateTime.now(), DateTime.now(), 200.00, "Text"),];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new ListView.builder(
        itemCount: posts.length,
        itemBuilder: (BuildContext context, int index) => buildPostCard(context, index)
      ),
    );
  }

  Widget buildPostCard(BuildContext context, int index) {
    final post = posts[index];
    return new Container(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Padding (
                padding: const EdgeInsets.only(top: 8.0, bottom: 6.0),
                child: Row(
                  children: <Widget>[
                    Text(post.title, style: TextStyle(fontSize: 20),),
                    Spacer(),
                  ],
                ),
              ),

              Padding (
                padding: const EdgeInsets.only(top: 8.0, bottom: 40.0),
                child: Row(
                  children: <Widget>[
                    Text("${DateFormat('dd/MM/yyyy').format(post.startDate).toString()} - ${DateFormat('dd/MM/yyyy').format(post.endDate).toString()}"),
                    Spacer(),
                  ],
                ),
              ),

              Padding (
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Row(
                  children: <Widget>[
                    Text(post.budget.toString()),
                    Spacer(),
                    Text(post.postType),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}