import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:revision_firebase_add/ShowData.dart';
import 'package:revision_firebase_add/Signin.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const AddData());
}

class AddData extends StatelessWidget {
  const AddData({super.key});


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
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pswd = TextEditingController();
  TextEditingController age = TextEditingController();



  void save_data() {

    try {
      int u_age = int.parse(age.text);
      FirebaseFirestore db = FirebaseFirestore.instance;
      if (name.text == "" || email.text == "" || pswd.text == "" || age.text == "") {
              ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("All Fields are required")));
      }
      if (u_age < 1 ) {
        ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Invalid Age")));
      
      }
      db.collection("Person").add({
        "Name": name.text,
        "Email": email.text,
        "Password": pswd.text,
        "Age": int.parse(age.text),
      });
      name.clear();
      email.clear();
      pswd.clear();
      age.clear();

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Data Saved Successfully")));
    } catch (e) {
      print("$e");
    }
  }
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(""),
        actions: [
          IconButton(onPressed: (){
            auth.signOut();
        Navigator.push(context, MaterialPageRoute(builder: (builder)=> AddData()));

          }, icon: Icon(Icons.logout))
        ],
      ),
      body: Center(
          child: Column(
        children: [
          // Text(auth.currentUser?.email)
          Container(
            margin: EdgeInsets.all(10),
            constraints: BoxConstraints(maxWidth: 300),
            child: TextField(
              controller: name,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter Name",
                  labelText: "Enter Name",
                  suffixIcon: Icon(Icons.person)),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            constraints: BoxConstraints(maxWidth: 300),
            child: TextField(
              controller: age,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter age",
                  labelText: "Enter Age",
                  suffixIcon: Icon(Icons.cake)),
            ),
          ),
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
            onPressed: save_data,
            label: Text("Submit"),
            icon: Icon(Icons.app_registration),
          )
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (builder) => Show()));
        },
        child: Icon(Icons.show_chart),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
