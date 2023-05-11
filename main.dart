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
            Stack(
              children: <Widget>[
                Container(
                  color: Color.fromARGB(255, 255, 203, 125),
                  width: double.infinity,
                  height: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 100,
                        backgroundImage: NetworkImage(
                            'https://cdn1.flamp.ru/354baec9d281984eb8926acf2e082787.png'),
                      ),
                      Text(
                        'Jonh Lennon',
                        textScaleFactor: 1.5,
                      )
                    ],
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        width: 150,
                        height: 75,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 8,
                          child: Center(
                            child: Text(
                              '2 / 8 machine tool',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 150,
                        height: 75,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 8,
                          child: Center(
                            child: Text(
                              '78 / 300 mb',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  height: itemHeight,
                  child: Card(
                    margin:
                        EdgeInsets.only(top: 30, bottom: 4, left: 4, right: 4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 8,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(
                                'https://ae04.alicdn.com/kf/H30400a0570bc47d4b71efddb30bb0ca8f.jpg'),
                          ),
                          Column(
                            children: [
                              Text('Last session: 08.06.2022'),
                              Text('-'),
                              Text('Memory used: 3 mb ')
                            ],
                          ),
                          Container(
                            width: 15,
                            height: 15,
                            color: Colors.red,
                          )
                        ]),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 8,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                              'https://avatars.mds.yandex.net/i?id=647597332ebf5dd68e6f3487b727c718-3542421-images-thumbs&n=13'),
                        ),
                        Column(
                          children: [
                            Text('Last session: 01.06.2022'),
                            Text('-'),
                            Text('Memory used: 11 mb ')
                          ],
                        ),
                        Container(
                          width: 15,
                          height: 15,
                          color: Colors.green,
                        )
                      ]),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 8,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                              'https://instrum96.ru/upload/iblock/b98/b98d59f50e1913548142f0c79640dfee.jpg'),
                        ),
                        Column(
                          children: [
                            Text('Last session: 08.03.2022'),
                            Text('-'),
                            Text('Memory used: 5 mb ')
                          ],
                        ),
                        Container(
                          width: 15,
                          height: 15,
                          color: Colors.red,
                        )
                      ]),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 8,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                              'https://cncmodelist.ru/components/com_jshopping/files/img_products/full_IMG_0152.JPG'),
                        ),
                        Column(
                          children: [
                            Text('Last session: 11.09.2021'),
                            Text('-'),
                            Text('Memory used: 13 mb ')
                          ],
                        ),
                        Container(
                          width: 15,
                          height: 15,
                          color: Colors.red,
                        )
                      ]),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 8,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                              'https://alextool.ru/wa-data/public/shop/products/02/00/2/images/3/proxxon-pf-230-1.970.png'),
                        ),
                        Column(
                          children: [
                            Text('Last session: 28.01.2022'),
                            Text('-'),
                            Text('Memory used: 42 mb ')
                          ],
                        ),
                        Container(
                          width: 15,
                          height: 15,
                          color: Colors.green,
                        )
                      ]),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 8,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                              'https://prostan.ru/images/detailed/6/gh-2440_zhd_50000839t_main.png'),
                        ),
                        Column(
                          children: [
                            Text('Last session: 03.03.2022'),
                            Text('-'),
                            Text('Memory used: 2 mb ')
                          ],
                        ),
                        Container(
                          width: 15,
                          height: 15,
                          color: Colors.red,
                        )
                      ]),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 8,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                              'https://instrum96.ru/upload/iblock/b98/b98d59f50e1913548142f0c79640dfee.jpg'),
                        ),
                        Column(
                          children: [
                            Text('Last session: 02.06.2022'),
                            Text('-'),
                            Text('Memory used: 34 mb ')
                          ],
                        ),
                        Container(
                          width: 15,
                          height: 15,
                          color: Colors.red,
                        )
                      ]),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 8,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                              'https://instrum96.ru/upload/iblock/b98/b98d59f50e1913548142f0c79640dfee.jpg'),
                        ),
                        Column(
                          children: [
                            Text('Last session: 02.06.2022'),
                            Text('-'),
                            Text('Memory used: 34 mb ')
                          ],
                        ),
                        Container(
                          width: 15,
                          height: 15,
                          color: Colors.red,
                        )
                      ]),
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
