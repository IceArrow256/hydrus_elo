import 'package:flutter/material.dart';

import 'package:desktop_window/desktop_window.dart';
import 'package:hydrus_dart/hydrus_dart.dart';

class Authorization extends StatefulWidget {
  @override
  _AuthorizationState createState() => _AuthorizationState();
}

class _AuthorizationState extends State<Authorization> {
  var validation = false;

  String _address;
  String _accessKey;

  final _formKey = GlobalKey<FormState>();

  TextEditingController _addressController;
  TextEditingController _accessKeyController;

  bool _isServerAvailable;
  bool _isAccessKeyCorrect;

  String _addressChecked;
  String _accessKeyChecked;

  void _checkAddress() async {
    final String addressChecked = _addressController.value.text;
    Hydrus client = Hydrus('', addressChecked);
    bool isServerAvailable = true;
    try {
      await client.getApiVersion();
    } catch (e) {
      isServerAvailable = false;
    }
    if (addressChecked != _addressController.value.text) {
      return;
    }
    setState(() {
      _addressChecked = addressChecked;
      _isServerAvailable = isServerAvailable;
    });
    await Future.delayed(
      Duration(seconds: 1),
    );
    setState(() {
      _accessKeyChecked = '';
    });
  }

  void _checkAccessKey() async {
    final String accessKeyChecked = _accessKeyController.value.text;
    final String addressChecked = _addressController.value.text;
    Hydrus client = Hydrus(accessKeyChecked, addressChecked);
    bool isAccessKeyCorrect = true;
    try {
      await client.verifyAccessKey();
    } catch (e) {
      isAccessKeyCorrect = false;
    }
    if (accessKeyChecked != _accessKeyController.value.text) {
      return;
    }
    setState(() {
      _accessKeyChecked = accessKeyChecked;
      _isAccessKeyCorrect = isAccessKeyCorrect;
    });
  }

  @override
  void initState() {
    super.initState();
    _addressController = new TextEditingController(text: '127.0.0.1:45869');
    _accessKeyController = new TextEditingController();
  }

  Widget _buildAddressField() {
    return TextFormField(
      autovalidateMode: AutovalidateMode.always,
      decoration: InputDecoration(labelText: 'Hydrus Client API adress'),
      controller: _addressController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Address is required';
        }
        if (_addressController.value.text != _addressChecked) {
          _checkAddress();
          return 'Checking for availability...';
        }
        return !_isServerAvailable ? 'Server isn\'t available' : null;
      },
      onSaved: (value) {
        _address = value;
      },
    );
  }

  Widget _buildAccessKey() {
    return TextFormField(
      autovalidateMode: AutovalidateMode.always,
      controller: _accessKeyController,
      decoration: InputDecoration(
        labelText: 'Hydrus Clien API access key',
      ),
      maxLength: 64,
      validator: (value) {
        if (value.isEmpty) {
          return 'Access key is required';
        }
        if (value.length != 64) {
          return 'Access key length must be 64 characters';
        }
        if (_accessKeyController.value.text != _accessKeyChecked) {
          _checkAccessKey();
          return 'Checking for correcting...';
        }
        return !_isAccessKeyCorrect ? 'Access key isn\'t available' : null;
      },
      onSaved: (value) {
        _accessKey = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    DesktopWindow.setMinWindowSize(Size(720, 720));
    return Scaffold(
        appBar: AppBar(
          title: Text('Hydrus Elo'),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (!_formKey.currentState.validate()) {
              return;
            }
            _formKey.currentState.save();
            print(_address);
            print(_accessKey);
          },
          child: Icon(Icons.login),
          backgroundColor: Colors.green,
        ),
        body: Container(
          margin: EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildAddressField(),
                _buildAccessKey(),
              ],
            ),
          ),
        ));
  }
}
