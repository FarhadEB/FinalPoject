import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('myBox'); 
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _nameController = TextEditingController();
  final Box _box = Hive.box('myBox'); 
  String? _savedName; 

  void _saveName() {
    String name = _nameController.text; 
    _box.put('name', name); 
    _nameController.clear();
  }

  void _showName() {
    setState(() {
      _savedName = _box.get('name'); 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('An Example of Hive in Flutter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Enter your name'),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: Text('Save Name'),
                  onPressed: _saveName,
                ),
                SizedBox(width: 4,),
                MaterialButton(
                  color: Colors.green,
                  textColor: Colors.white,
                  child: Text('Show Name'),
                  onPressed: _showName, 
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Saved Name: ${_savedName ?? 'No name saved'}',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
