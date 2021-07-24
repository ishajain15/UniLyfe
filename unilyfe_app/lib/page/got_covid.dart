import 'package:cloud_firestore/cloud_firestore.dart';

/// Flutter code sample for RadioListTile

// ![RadioListTile sample](https://flutter.github.io/assets-for-api-docs/assets/material/radio_list_tile.png)
//
// This widget shows a pair of radio buttons that control the `_character`
// field. The field is of the type `SingingCharacter`, an enum.

import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:unilyfe_app/models/place_search.dart';
import 'package:unilyfe_app/provider/places_provider.dart';
import 'package:unilyfe_app/widgets/provider_widget.dart';
import 'package:uuid/uuid.dart';

bool changed = false;
int balance = 0;

/// This is the main application widget.
// ignore: must_be_immutable
class GotCovidPage extends StatelessWidget {
  GotCovidPage({Key key, this.updateMarker}) : super(key: key);

  final Function updateMarker;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GotCovidPageWidget(updateMarker: updateMarker),
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
  GotCovidPageWidget({Key key, this.updateMarker}) : super(key: key);
  final Function updateMarker;
  @override
  _GotCovidPageWidgetState createState() =>
      _GotCovidPageWidgetState(updateMarker: updateMarker);
}

/// This is the private State class that goes with MyStatefulWidget.
class _GotCovidPageWidgetState extends State<GotCovidPageWidget>
    with ChangeNotifier {
  _GotCovidPageWidgetState({this.updateMarker});
  final Function updateMarker;
  SingingCharacter _character = SingingCharacter.no;
  final _controller = TextEditingController();
  String placeId = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
          child: Column(children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _controller,
                readOnly: true,
                onTap: () async {
                  // generate a new token here
                  final sessionToken = Uuid().v4();
                  final result = await showSearch(
                    context: context,
                    delegate: AddressSearch(sessionToken),
                  );
                  // This will change the text displayed in the TextField
                  if (result != null) {
                    final placeDetails = await PlaceApiProvider(sessionToken)
                        .getPlaceDetailFromId(result.placeId);
                    setState(() {
                      _controller.text = result.description;
                      placeId = placeDetails.placeId;
                    });
                  }
                  // GeoPoint(detail.result.geometry.location.lat,
                  //     detail.result.geometry.location.lng);
                },
                decoration: InputDecoration(
                    hintText: 'Search Location',
                    suffixIcon: Icon(Icons.search_outlined)),
              ),
            ),
            SizedBox(height: 20.0),
            Text('Place: $placeId'),
          ]),
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
        var _places = GoogleMapsPlaces(
          apiKey: 'AIzaSyBW_0mCRvtAq9Pb5KxbsxznM7lgM06kjic',
        );
        var detail = await _places.getDetailsByPlaceId(placeId);

        await FirebaseFirestore.instance.collection('locations').add({
          'coordinates': GeoPoint(detail.result.geometry.location.lat,
              detail.result.geometry.location.lng),
          'name': detail.result.name
        });

        final result = await FirebaseFirestore.instance
            .collection('location_cases')
            .where('name', isEqualTo: detail.result.name)
            .get();

        final List<DocumentSnapshot> documents = result.docs;

        if (documents.isNotEmpty) {
          final docid = result.docs.first.id;
          //exists
          await FirebaseFirestore.instance
              .collection('location_cases')
              .doc(docid)
              .update({'num_cases': FieldValue.increment(1)});
        } else {
          //not exists
          await FirebaseFirestore.instance
              .collection('location_cases')
              .add({'name': detail.result.name, 'num_cases': 1});
        }

        updateMarker();
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
