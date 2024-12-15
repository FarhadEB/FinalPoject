import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_launcher_icons/android.dart';
void main(List<String> args) {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  TextEditingController keyController=TextEditingController();
  TextEditingController valueController=TextEditingController();
  var data='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        
        backgroundColor: Colors.pink,
        title: Center(
          child: Text(
            'Shared Preferences', 
            style: TextStyle(color: Colors.white, fontSize: 40),
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20,),
           Padding (
            padding: EdgeInsets.all(8),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Key'),
                  
                ),
                onChanged: (key){
                 
                },
                controller: keyController,
              ),
            ),
               SizedBox(height: 20,),
           Padding (
            padding: EdgeInsets.all(8),
              child: TextField(

                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Value'),
                ),
                controller: valueController,
              ),
            ),
            SizedBox(height: 20,),
            MaterialButton(color: Colors.red,
              onPressed: () async{
            final SharedPreferences pres=await SharedPreferences.getInstance();
            await pres.setString(keyController.text,valueController.text);
            keyController.clear();
            valueController.clear();
            },child: Text('Save'),
            ),
            SizedBox(height: 20,),
            
            MaterialButton(color: Colors.red,
              onPressed: ()async{
            final SharedPreferences pres=await SharedPreferences.getInstance();
            final String? action= pres.getString(keyController.text);
            setState(() {
              data= action ?? 'Empty||Null'; 
            });
            },child: Text('Restore'),
          
            
            ),
            Text('$data')
          ],
        ),
      ),
    );
  }
}
