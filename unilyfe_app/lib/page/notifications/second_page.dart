import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({
    @required this.payload,
    Key key,
  }) : super(key: key);

  final String payload;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Second page - Payload:',
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(height: 8),
              Text(
                payload,
                style: Theme.of(context).textTheme.subtitle2,
              ),
              const SizedBox(height: 8),
              // ignore: deprecated_member_use
              RaisedButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Back'),
              ),
            ],
          ),
        ),
      );
}
