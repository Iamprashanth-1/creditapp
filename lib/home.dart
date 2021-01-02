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
        leading: Icon(Icons.arrow_right_outlined, color: Color(0xFF083386)),
        backgroundColor: Color(0xFF083386),
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
                        child: Text(
                          "Turn on bluetooth",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22),
                        ),
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
                              Icon(Icons.speed_sharp, color: Colors.white),
                              SizedBox(height: 10),
                              Text("Speed",
                                  style: TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center),
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
                              Icon(Icons.directions_car_rounded,
                                  color: Colors.white),
                              SizedBox(height: 10),
                              Text("Vehicle Details",
<<<<<<< HEAD
                                  style: TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center),
=======
                                  style: TextStyle(color: Colors.white)),
>>>>>>> c89e0d93893eb066cc646e2c12ad9a0530503306
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
                              Icon(Icons.developer_board, color: Colors.white),
                              SizedBox(height: 10),
                              Text("Air Fuel Ratio",
                                  style: TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center),
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
                              Icon(Icons.device_thermostat,
                                  color: Colors.white),
                              SizedBox(height: 10),
                              Text("Ambient Air Temperature",
                                  style: TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center),
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
                              Icon(Icons.power_rounded, color: Colors.white),
                              SizedBox(height: 10),
                              Text("Horse Power",
<<<<<<< HEAD
                                  style: TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center),
=======
                                  style: TextStyle(color: Colors.white)),
>>>>>>> c89e0d93893eb066cc646e2c12ad9a0530503306
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
                              Icon(Icons.event, color: Colors.white),
                              SizedBox(height: 10),
                              Text("Barometer",
                                  style: TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center)
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
                              Icon(Icons.developer_board, color: Colors.white),
                              SizedBox(height: 10),
                              Text("Barometric Pressure",
                                  style: TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center),
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
                              Icon(Icons.event, color: Colors.white),
                              SizedBox(height: 10),
                              Text("Catalys Temperature",
                                  style: TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center),
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
                              Icon(Icons.developer_board, color: Colors.white),
                              SizedBox(height: 10),
                              Text("Command Equivalence Ratio",
                                  style: TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center),
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
                              Icon(Icons.event, color: Colors.white),
                              SizedBox(height: 10),
                              Text("Cost Per Mile",
                                  style: TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center),
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
                              Icon(Icons.developer_board, color: Colors.white),
                              SizedBox(height: 10),
                              Text("Command Equivalence Ratio",
                                  style: TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center),
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
                              Icon(Icons.event, color: Colors.white),
                              SizedBox(height: 10),
                              Text("Cost Per Mile",
                                  style: TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center),
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
                              Icon(Icons.developer_board, color: Colors.white),
                              SizedBox(height: 10),
                              Text("CO2 Emissions",
                                  style: TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center),
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
                              Icon(Icons.event, color: Colors.white),
                              SizedBox(height: 10),
                              Text("Distance to Empty Fuel Tank",
                                  style: TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center),
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
                              Icon(Icons.developer_board, color: Colors.white),
                              SizedBox(height: 10),
                              Text("Distance Traveled",
                                  style: TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center),
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
                              Icon(Icons.event, color: Colors.white),
                              SizedBox(height: 10),
                              Text("EGR Commanded",
                                  style: TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center),
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
                              Icon(Icons.developer_board, color: Colors.white),
                              SizedBox(height: 10),
                              Text("EGR Error",
                                  style: TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center),
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
                              Icon(Icons.event, color: Colors.white),
                              SizedBox(height: 10),
                              Text("Engine Coolant Temperature",
                                  style: TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center),
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
                              Icon(Icons.developer_board, color: Colors.white),
                              SizedBox(height: 10),
                              Text("Engine kW",
                                  style: TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center),
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
                              Icon(Icons.event, color: Colors.white),
                              SizedBox(height: 10),
                              Text("Engine Load",
                                  style: TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center),
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
                              Icon(Icons.developer_board, color: Colors.white),
                              SizedBox(height: 10),
                              Text("Engine Oil Temperature",
                                  style: TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center),
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
                              Icon(Icons.event, color: Colors.white),
                              SizedBox(height: 10),
                              Text("Engine RPM",
                                  style: TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center),
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
                              Icon(Icons.developer_board, color: Colors.white),
                              SizedBox(height: 10),
                              Text("Ethanol Fuel Percentage",
                                  style: TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center),
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
                              Icon(Icons.event, color: Colors.white),
                              SizedBox(height: 10),
                              Text("Evap System Vapour Pressure",
                                  style: TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center),
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
                              Icon(Icons.developer_board, color: Colors.white),
                              SizedBox(height: 10),
                              Text("Exhaust Gas Temperature",
                                  style: TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center),
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
                              Icon(Icons.event, color: Colors.white),
                              SizedBox(height: 10),
                              Text("Fuel Cost",
                                  style: TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center),
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
                              Icon(Icons.developer_board, color: Colors.white),
                              SizedBox(height: 10),
                              Text("Fuel Flow Rate",
                                  style: TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center),
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
                              Icon(Icons.event, color: Colors.white),
                              SizedBox(height: 10),
                              Text("Fuel Level",
                                  style: TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center),
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
                              Icon(Icons.developer_board, color: Colors.white),
                              SizedBox(height: 10),
                              Text("Fuel Pressure",
                                  style: TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center),
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
                              Icon(Icons.event, color: Colors.white),
                              SizedBox(height: 10),
                              Text("Fuel Rail Pressure",
                                  style: TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center),
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
                              Icon(Icons.developer_board, color: Colors.white),
                              SizedBox(height: 10),
                              Text("Fuel Trim Bank",
                                  style: TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center),
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
                              Icon(Icons.event, color: Colors.white),
                              SizedBox(height: 10),
                              Text("Cost Per Mile",
                                  style: TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center),
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
