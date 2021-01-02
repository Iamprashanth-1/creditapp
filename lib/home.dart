import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:provider/provider.dart';
import 'bluetoo.dart';
import 'shared_pref.dart';
import './widget/dash.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _value;
  bool _connected = false;
  bool _connecting = true;

  _autoConnect(BuildContext context) async {
    final SharedPref sharedPref =
        Provider.of<SharedPrefService>(context, listen: false);
    String address = await sharedPref.getAddress();
    if (address == 'nothing') {
      return;
    } else {
      setState(() {
        _value = address;
      });
      _connect(context);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero, () {
      _autoConnect(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Bluetooth bluetooth = Provider.of<BluetoothService>(context);
    final SharedPref sharedPref = Provider.of<SharedPrefService>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20, top: 20),
              child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Dash()));
                  },
                  child: Text(
                    "Back",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ))),
        ],
        title: Text("OBD Status checks"),
      ),
      body: RefreshIndicator(
          // ignore: missing_return
          onRefresh: () async {
            await sharedPref.getTurnOffFan();
            setState(() {});
          },
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  color: Colors.white),
              child: ListView(children: <Widget>[
                FutureBuilder<List<BluetoothDevice>>(
                  future: bluetooth.getDevices(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: <Widget>[
                              DropdownButtonFormField(
                                items: snapshot.data
                                    .map((e) => DropdownMenuItem(
                                          child: Text(e.name),
                                          value: e.address,
                                        ))
                                    .toList(),
                                onChanged: _connected
                                    ? null
                                    : (value) {
                                        setState(() {
                                          _value = value;
                                          print(_value);
                                        });
                                      },
                                value: _value,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                                disabledHint:
                                    Text("Disconnect to change device"),
                              ),
                              RaisedButton(
                                child:
                                    Text(_connected ? "Disconnect" : "Connect"),
                                onPressed: _connecting
                                    ? null
                                    : () {
                                        _connected
                                            ? _disconnect(context)
                                            : _connect(context);
                                      },
                                color: _connected ? Colors.red : Colors.green,
                                textColor: Colors.white,
                              )
                            ],
                          ),
                        );
                      }
                      return Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text("Turn on bluetooth"),
                      );
                    }
                    return CircularProgressIndicator();
                  },
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          onPressed: () {},
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 1.5,
                          color: Color(0xFF083386),
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Icon(Icons.developer_board),
                              SizedBox(height: 10),
                              Text("Experiences"),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 24),
                      Expanded(
                        child: RaisedButton(
                          onPressed: () {},
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 1.5,
                          color: Color(0xFF083386),
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Icon(Icons.event),
                              SizedBox(height: 10),
                              Text("Events"),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          onPressed: () {},
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 1.5,
                          color: Color(0xFF083386),
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Icon(Icons.developer_board),
                              SizedBox(height: 10),
                              Text("Experience"),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: RaisedButton(
                          onPressed: () {},
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 1.5,
                          color: Color(0xFF083386),
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Icon(Icons.event),
                              SizedBox(height: 10),
                              Text("Events"),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          onPressed: () {},
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 1.5,
                          color: Color(0xFF083386),
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Icon(Icons.developer_board),
                              SizedBox(height: 10),
                              Text("Experiences"),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 24),
                      Expanded(
                        child: RaisedButton(
                          onPressed: () {},
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 1.5,
                          color: Color(0xFF083386),
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Icon(Icons.event),
                              SizedBox(height: 10),
                              Text("Events"),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          onPressed: () {},
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 1.5,
                          color: Color(0xFF083386),
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Icon(Icons.developer_board),
                              SizedBox(height: 10),
                              Text("Experiences"),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 24),
                      Expanded(
                        child: RaisedButton(
                          onPressed: () {},
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 1.5,
                          color: Color(0xFF083386),
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Icon(Icons.event),
                              SizedBox(height: 10),
                              Text("Events"),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          onPressed: () {},
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 1.5,
                          color: Color(0xFF083386),
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Icon(Icons.developer_board),
                              SizedBox(height: 10),
                              Text("Experiences"),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 24, height: 10),
                      Expanded(
                        child: RaisedButton(
                          onPressed: () {},
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 1.5,
                          color: Color(0xFF083386),
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Icon(Icons.event),
                              SizedBox(height: 10),
                              Text("Events"),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]))),
    );
  }

  _connect(BuildContext context) async {
    final Bluetooth bluetooth =
        Provider.of<BluetoothService>(context, listen: false);
    final SharedPref sharedPref =
        Provider.of<SharedPrefService>(context, listen: false);
    bool status = await bluetooth.connectTo(_value);
    await sharedPref.setAddress(_value);
    if (status) {
      sharedPref.getStatus('light').then((value) {
        value ? bluetooth.write('L') : bluetooth.write('7');
      });
      sharedPref.getStatus('fan').then((value) {
        value ? bluetooth.write('F') : bluetooth.write('3');
      });
    }
    setState(() {
      _connected = status;
      _connecting = false;
    });
  }

  _disconnect(BuildContext context) async {
    final Bluetooth bluetooth =
        Provider.of<BluetoothService>(context, listen: false);
    bluetooth.disconnect();
    setState(() {
      _connected = false;
    });
  }
}
