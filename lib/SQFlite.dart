import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

void main(List<String> args) {
  runApp(MaterialApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController controller = TextEditingController();
  var mydata = '';
  late Database db;
  _openDatabase() async {
    var path = await getDatabasesPath();
    db = await openDatabase(
      '$path/mydb.db',
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
            'Create table Students(id integer,name text,age integer);');
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _openDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text('$mydata'),
            TextField(
              controller: controller,
            ),
            Wrap(
              children: [
                ElevatedButton(
                    onPressed: () {
                      _openDatabase();
                    },
                    child: Text('Open Database')),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () async {
                      await db.rawInsert(
                          'Insert into Students (id,name,age) value(1,"Ali","19")');
                    },
                    child: Text('Insert DB')),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () async {
                      List<Map<String, dynamic>> rows = await db
                          .rawQuery('Select * from Students where id=1;');
                      setState(() {
                        mydata = rows.toString();
                      });
                    },
                    child: Text('Select DB')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
