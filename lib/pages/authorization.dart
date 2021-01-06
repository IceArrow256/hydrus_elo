import 'package:flutter/material.dart';

import 'package:desktop_window/desktop_window.dart';

class Authorization extends StatefulWidget {
  @override
  _AuthorizationState createState() => _AuthorizationState();
}

class _AuthorizationState extends State<Authorization> {
  var validation = false;

  Future<void> init() async {
    await DesktopWindow.setMinWindowSize(Size(720, 720));
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hydrus Elo'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            validation = true;
          });
          // Add your onPressed code here!
        },
        child: Icon(Icons.login),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: SizedBox(
          width: 592,
          height: 592,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                child: Text(
                  'Hydrus Client API adress',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              TextField(
                onChanged: (text) {
                  print(text);
                },
                decoration: InputDecoration(hintText: '127.0.0.1:45869'),
              ),
              Visibility(
                visible: validation,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                  child: Text(
                    'Adress is valid',
                    style: TextStyle(fontSize: 18, color: Colors.green),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                child: Text(
                  'Hydrus Clien API access key',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              TextField(
                decoration: InputDecoration(
                    hintText:
                        'xfbpdhjjtx87uqldclbchhixgdrgsrmgfnosjxilo3n9owcmn1tyjclnuinpjx4s'),
              ),
              Visibility(
                visible: validation,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                  child: Text(
                    'Access key is valid',
                    style: TextStyle(fontSize: 18, color: Colors.green),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
