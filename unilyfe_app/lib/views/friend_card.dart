import 'package:flutter/material.dart';
import 'package:unilyfe_app/customized_items/buttons/add_friend_button.dart';
import 'package:unilyfe_app/customized_items/buttons/photo_posting_button.dart';
import '../demo_values.dart';

class FriendCard extends StatelessWidget {
  const FriendCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var classThings = <String>[
      'AD 255',
      'COM 217',
      'CS 252',
      'MA 265',
      'CS 307'
    ];
    var hobbyThings = <String>[
      'art',
      'hiking',
      'biking',
      'crying',
      'simping'
    ];
    return Flex(direction: Axis.horizontal, children: [
      Expanded(
        ///aspectRatio: 4 / 3,
        child: Card(
          elevation: 2,
          child: Container(
            padding: const EdgeInsets.all(32),
            child: Row(
              children: [
                Expanded(
                  /*1*/
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /*2*/
                      Container(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          'Potential Friend',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          'Sophomore',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Text(
                          'user biooooooo',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          'Also likes:',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      chipList(hobbyThings, const Color(0xFFF46C6B)),
                      Container(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          'Also takes:',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      chipList(classThings, const Color(0xFFF99E3E)),
                    ],
                  ),
                ),
                /*3*/
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                          radius: 50.0,
                          backgroundImage:
                              AssetImage('assets/empty-profile.png')),
                      Container(
                          padding: const EdgeInsets.all(8),
                          child: AddFriendButton())
                    ]),
              ],
            ),
          ),
        ),
      )
    ]);
  }

  Widget _buildChip(String label, Color color) {
    return Chip(
      labelPadding: EdgeInsets.all(0.75),
      label: Text(
        label,
        style: TextStyle(color: Colors.white, fontSize: 12),
      ),
      backgroundColor: color,
      elevation: 6.0,
      shadowColor: Colors.grey[60],
      padding: EdgeInsets.all(8.0),
    );
  }

  Widget chipList(List<String> things, Color color) {
    var list = <Widget>[];
    for (var i = 0; i < things.length; i++) {
      list.add(_buildChip(things[i], color));
    }
    Widget chips = Padding(
        padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
        child: Wrap(spacing: 6.0, runSpacing: 6.0, children: list));
    return chips;
  }
}

class _FriendImage extends StatelessWidget {
  const _FriendImage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(flex: 2, child: Image.asset(DemoValues.postImage));
  }
}
