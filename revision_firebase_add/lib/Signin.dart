import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:revision_firebase_add/AddData.dart';
import 'package:revision_firebase_add/ShowData.dart';
import 'package:revision_firebase_add/Signup.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';


void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Signin());
}

class Signin extends StatelessWidget {
  const Signin({super.key});

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
      home: const MyHomePage(title: 'Signin'),
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
 
  TextEditingController email = TextEditingController();
  TextEditingController pswd = TextEditingController();
 
void register()async{
 try {
    FirebaseAuth auth = FirebaseAuth.instance;
    UserCredential u = await auth.signInWithEmailAndPassword(
      email: email.text,
       password: pswd.text).whenComplete((){
        Navigator.push(context, MaterialPageRoute(builder: (builder)=> AddData()));
       });
 } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$e")));
   
 }
 }
  

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
            margin: EdgeInsets.all(10),
            constraints: BoxConstraints(maxWidth: 300),
            child: TextField(
              controller: email,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter Email",
                  labelText: "Enter Email",
                  suffixIcon: Icon(Icons.email)),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            constraints: BoxConstraints(maxWidth: 300),
            child: TextField(
              controller: pswd,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter Password",
                  labelText: "Enter Password",
                  suffixIcon: Icon(Icons.remove_red_eye)),
            ),
          ),
          OutlinedButton.icon(
            onPressed: register,
            label: Text("Submit"),
            icon: Icon(Icons.app_registration),
          ),
          TextButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (builder) => Signup()));
          }, child: Text("Create your  account"))
        ],
      )),
     // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
