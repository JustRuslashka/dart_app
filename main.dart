import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const MyHomePage(title: 'Flutter Home Page'),
    );
  }
}

class NewScreen extends StatelessWidget {
  const NewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Screen'),
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Text(
            'This is a new screen!',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        tooltip: 'Go back',
        child: Icon(Icons.arrow_back),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<Data>>? _futureData;

  @override
  void initState() {
    super.initState();
    _futureData = fetchData();
  }

  Future<List<Data>> fetchData() async {
    final response =
        await http.get(Uri.parse('https://cnc.kovalev.team/get/5'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<Data> dataList = [];

      for (var item in data) {
        dataList.add(Data.fromJson(item));
      }

      return dataList;
    } else {
      throw Exception('Failed to load data');
    }
  }

  void _goToNewScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double itemWidth = 150;
    double itemHeight = 130;

    void MachineTap() {}

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          FlatButton(
            onPressed: _goToNewScreen,
            child: Text('Go to new screen'),
            textColor: Colors.white,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: FutureBuilder<List<Data>>(
                  future: _futureData,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          Data data = snapshot.data[index];
                          return ListTile(
                            title: Text(data.name),
                            subtitle: Text(data.value),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return CircularProgressIndicator();
                    }
                  }),
            ),
            
                ),
              ],
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class Data {
  final String name;
  final String value;

  Data({required this.name, required this.value});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      name: json['name'],
      value: json['value'],
    );
  }
}
