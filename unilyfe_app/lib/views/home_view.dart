import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unilyfe_app/customized_items/buttons/comment_button.dart';
import 'package:unilyfe_app/customized_items/buttons/information_button_all.dart';
import 'package:unilyfe_app/customized_items/buttons/view_info_button.dart';
import 'package:unilyfe_app/widgets/provider_widget.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          InformationButtonAll(),
          Flexible(
            child: StreamBuilder(
                stream: getUserPostsStreamSnapshots(context),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const Text("Loading...");
                  return new ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (BuildContext context, int index) =>
                          buildPostCard(context, snapshot.data.docs[index]));
                }),
          ),
        ],
      ),
    );
  }

  Stream<QuerySnapshot> getUserPostsStreamSnapshots(
      BuildContext context) async* {
    final uid = await Provider.of(context).auth.getCurrentUID();
    yield* FirebaseFirestore.instance
        .collection("posts")
        .orderBy('time', descending: true)
        .snapshots();
    // .collection("userData")
    // .doc(uid)
    // .collection("posts")
    // .snapshots();
  }

  Widget buildPostCard(BuildContext context, DocumentSnapshot post) {
    if (post['postType'] == 0) print("TEXT POST");
    return Container(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 6.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 15,
                      child: Text(
                        "Title: ${(post['title'] == null) ? "n/a" : post['title']}",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 25.0),
                child: Row(
                  children: <Widget>[
                    Text(
                        "Date posted: ${DateFormat('MM/dd/yyyy (h:mm a)').format(post['time'].toDate()).toString()}"),
                    Spacer(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 15,
                      child: Text(
                          "Text: ${(post['text'] == null) ? "n/a" : post['text']}"),
                    ),
                    Spacer(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Row(
                  children: <Widget>[
                    Text("Post channel: ${post['postChannel']}"),
                    Spacer(),
                    ViewInfoButton(),
                  ],
                ),
              ),
              CommentButtonWidget(),
              ElevatedButton(
                  onPressed: () async {
                    final uid = await Provider.of(context).auth.getCurrentUID();
                    // FirebaseFirestore.instance
                    //     .collection("userData")
                    //     .doc(uid)
                    //     .collection("liked_posts")
                    //     .doc(post.id)
                    //     .update({'liked': true});
                    FirebaseFirestore.instance
                        .collection("posts")
                        .doc(post.id)
                        .update({'liked': true});

                    if (post['postChannel'] == "FOOD") {
                      FirebaseFirestore.instance
                          .collection("food_posts")
                          .doc(post.id)
                          .update({'liked': true});
                    } else if (post['postChannel'] == "STUDY") {
                      FirebaseFirestore.instance
                          .collection("study_posts")
                          .doc(post.id)
                          .update({'liked': true});
                    } else if (post['postChannel'] == "SOCIAL") {
                      FirebaseFirestore.instance
                          .collection("social_posts")
                          .doc(post.id)
                          .update({'liked': true});
                    }
                  },
                  child: Text("LIKE")),
              Text("\nLikes: ${post['likes']}"),
              Text("\nLiked: ${post['liked']}"),
              IconTheme(
  data: IconThemeData(
    color: Colors.amber,
    size: 48,
  ),
  child: StarRating(),
),
            ],
          ),
        ),
      ),
    );
  }
}

class StarDisplay extends StatelessWidget {
  final int value;
  const StarDisplay({Key key, this.value = 0})
      : assert(value != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < value ? Icons.star : Icons.star_border,
        );
      }),
    );
  }
}
class StarRating extends StatelessWidget {
  final int value;
  final IconData filledStar;
  final IconData unfilledStar;
  const StarRating({
    Key key,
    this.value = 0,
    this.filledStar,
    this.unfilledStar,
  })  : assert(value != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).accentColor;
    final size = 36.0;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return IconButton(
          onPressed: () {},
          color: index < value ? color : null,
          iconSize: size,
          icon: Icon(
            index < value 
               ? filledStar ?? Icons.star 
               : unfilledStar ?? Icons.star_border,
          ),
          padding: EdgeInsets.zero,
          tooltip: "${index + 1} of 5",
        );
      }),
    );
  }
}
// class StarDisplayWidget extends StatelessWidget {
//   final int value;
//   final Widget filledStar;
//   final Widget unfilledStar;
//   final double size;
//   final Color color;
//   final int marginFactor;

//   const StarDisplayWidget({
//     Key key,
//     this.value = 0,
//     this.filledStar,
//     this.unfilledStar,
//     this.color = Colors.orange,
//     this.size = 20,
//     this.marginFactor = 5,
//   })  : assert(value != null),
//         super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.end,
//       children: List.generate(5, (index) {
//         return Container(
//           width: size - size / marginFactor,
//           height: size,
//           child: Icon(
//             index < value
//                 ? filledStar ?? Icons.star
//                 : unfilledStar ?? Icons.star_border,
//             color: color,
//             size: size,
//           ),
//         );
//       }),
//     );
//   }
// }

// class StarRating extends StatelessWidget {
//   final void Function(int index) onChanged;
//   final int value;
//   final IconData filledStar;
//   final IconData unfilledStar;
//   final double size;
//   final Color color;
//   final int marginFactor;

//   const StarRating({
//     Key key,
//     @required this.onChanged,
//     this.value = 0,
//     this.filledStar,
//     this.unfilledStar,
//     this.color = Colors.orange,
//     this.size = 20,
//     this.marginFactor = 5,
//   })  : assert(value != null),
//         super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//       mainAxisSize: MainAxisSize.min,
//       children: List.generate(5, (index) {
//         return RawMaterialButton(
//           child: Icon(
//             index < value
//                 ? filledStar ?? Icons.star
//                 : unfilledStar ?? Icons.star_border,
//             color: color,
//             size: size,
//           ),
//           materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//           shape: CircleBorder(),
//           constraints: BoxConstraints.expand(
//               width: size - size / marginFactor, height: size),
//           padding: EdgeInsets.zero,
//           highlightColor: Colors.transparent,
//           splashColor: Colors.transparent,
//           onPressed: onChanged != null
//               ? () {
//                   onChanged(value == index + 1 ? index : index + 1);
//                 }
//               : null,
//         );
//       }),
//     );
//   }
// }