import 'package:flutter/material.dart';

class Dividents extends StatefulWidget {
  @override
  _DividentsState createState() => _DividentsState();
}

class _DividentsState extends State<Dividents> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return Column(
            children: <Widget>[
              ListTile(
                // leading: CircleAvatar(
                //   backgroundImage: AssetImage('assets/images/obama.jpg'),
                // ),
                title: Text('Amount'),
                subtitle: Text('R 6000'),
                trailing: Text('20-03-2020'),
              ),
              Divider(),
            ],
          );
        });
  }
}
