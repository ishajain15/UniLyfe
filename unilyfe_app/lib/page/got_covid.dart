import 'package:cloud_firestore/cloud_firestore.dart';

/// Flutter code sample for RadioListTile

// ![RadioListTile sample](https://flutter.github.io/assets-for-api-docs/assets/material/radio_list_tile.png)
//
// This widget shows a pair of radio buttons that control the `_character`
// field. The field is of the type `SingingCharacter`, an enum.

import 'package:flutter/material.dart';
import 'package:unilyfe_app/widgets/provider_widget.dart';
import 'package:search_map_place/search_map_place.dart';

bool changed = false;
int balance = 0;

/// This is the main application widget.
// ignore: must_be_immutable
class GotCovidPage extends StatelessWidget {
  GotCovidPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GotCovidPageWidget(),
    );
  }
}

bool isChanged() {
  return changed;
}

void resetChanged() {
  changed = false;
}

int getBalance() {
  return balance;
}

enum SingingCharacter { yes, no }

/// This is the stateful widget that the main application instantiates.
// ignore: must_be_immutable
class GotCovidPageWidget extends StatefulWidget {
  GotCovidPageWidget({Key key}) : super(key: key);
  @override
  _GotCovidPageWidgetState createState() => _GotCovidPageWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _GotCovidPageWidgetState extends State<GotCovidPageWidget> {
  SingingCharacter _character = SingingCharacter.no;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(
            'DO YOU HAVE COVID-19?',
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey[600],
            ),
          ),
        ),
        RadioListTile<SingingCharacter>(
          title: Text(
            'NO',
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey[600],
            ),
          ),
          value: SingingCharacter.no,
          groupValue: _character,
          onChanged: (SingingCharacter value) {
            setState(() {
              _character = value;
            });
          },
        ),
        RadioListTile<SingingCharacter>(
          title: Text(
            'YES',
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey[600],
            ),
          ),
          value: SingingCharacter.yes,
          groupValue: _character,
          onChanged: (SingingCharacter value) {
            setState(() {
              _character = value;
            });
          },
        ),
        Visibility(
          visible: _character == SingingCharacter.yes,
          child: SearchMapPlaceWidget(
            hasClearButton: true,
            placeType: PlaceType.address,
            placeholder: 'Enter locations',
            apiKey: 'AIzaSyAi0MNwGpYcpEsiXdd7pc-gHRRsx9JIWTA',
            onSelected: (Place place) async {
              // Geolocation geolocation = await place.geolocation;
              //print(geolocation.coordinates);
            },
          ),
        ),
        submitButton(),
      ],
    );
  }

  // to make plus/minus thing work no matter what, if user is in collection, plus equals false and minus equals true
  // and vice versa. and instead of !plus and !minus, it would be plus and minus
  Widget submitButton() {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        primary: Colors.grey, // background
      ),
      onPressed: () async {
        changed = true;
        var current_uid = await Provider.of(context).auth.getCurrentUID();
        final db = FirebaseFirestore.instance;
        final snapshot = await FirebaseFirestore.instance
            .collection('Covid_info')
            .doc(current_uid) // varuId in your case
            .get();
        if (_character == SingingCharacter.yes) {
          await db
              .collection('Covid_info')
              .doc(current_uid)
              .set({'country': 'USA'});
          if ((balance == 0 || balance == -1) && !snapshot.exists) balance += 1;
        } else {
          await db.collection('Covid_info').doc(current_uid).delete();
          if ((balance == 0 || balance == 1) && snapshot.exists) balance -= 1;
        }
      },
      child: Text('SUBMIT'),
    );
  }
}
