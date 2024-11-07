import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'firebase_options.dart';

void main() async {
   await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  TextEditingController nametxt = TextEditingController();
  File? image_file;
  Uint8List? web_image_file;
  ImagePicker pick=ImagePicker();
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
       
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              constraints: BoxConstraints(maxWidth: 300),
              margin: EdgeInsets.all(10),
              child: TextField(
                controller: nametxt,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter Name",
                  suffixIcon: Icon(Icons.person)
                ),
              ),
            ),
            FloatingActionButton(onPressed: () async{
                final pickwaliimage = await pick.pickImage(source: ImageSource.gallery);
                if (pickwaliimage != null) {
                  final pickedFileBytes = await pickwaliimage.readAsBytes();
                  if (kIsWeb) {
                    setState(()  {
                      web_image_file = pickedFileBytes;
                    });
                  }
                  else{
                    setState(() {
                    image_file = File(pickwaliimage.path);
                      
                    });
                  }
                }
            },
            child: Icon(Icons.upload_file),),
            Expanded(child:Container(
              width: 100,
              height: 100,
              child: (image_file == null || web_image_file == null) ? 
              Text("No File Selected",style: TextStyle(color: Colors.red)):
              kIsWeb ? Image.memory(web_image_file!) : Image.file(image_file!)
            )),
            Container(
              margin: EdgeInsets.all(10),
              child: ElevatedButton(onPressed: (){
                try {
                  FirebaseFirestore db = FirebaseFirestore.instance;
                var picname = DateTime.now().millisecondsSinceEpoch.toString();
                var storage_variable = FirebaseStorage.instance.ref().child("UserProfile/$picname.jpg");

                if (kIsWeb) {
                  storage_variable.putData(web_image_file!);
                }
                else{
                  storage_variable.putFile(image_file!);

                }
                  var url = storage_variable.getDownloadURL();
                db.collection("UserProfile").add({
                  "Name" : nametxt.text,
                  "ProfileImage" :url.toString()
                });
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Profile Created")));
                } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$e")));
                  
                }

              }, child: Text("Save Data")),
            )
          ],
        ),
       
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
