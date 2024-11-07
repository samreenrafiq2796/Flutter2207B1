import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:user_authentication_authorization/Signin.dart';
import 'package:user_authentication_authorization/firebase_options.dart';

void main() async{
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const Signup());
}

class Signup extends StatelessWidget {
  const Signup({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowMaterialGrid: false,

      title: 'Flutter Demo',
      theme: ThemeData(
       

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 
TextEditingController a = TextEditingController();
TextEditingController b = TextEditingController();
TextEditingController c = TextEditingController();
TextEditingController d = TextEditingController();


    void register_func() async{
    try {
        FirebaseFirestore db = FirebaseFirestore.instance;
      FirebaseAuth auth = FirebaseAuth.instance;

      // Auth ka kaam
      UserCredential user = await auth.createUserWithEmailAndPassword(
        email: b.text, 
        password: c.text).whenComplete((){ // Firestore me data bhejne ka
          db.collection("User").add({
            "Name":a.text,
            "Email":b.text,
            "Phone" : d.text
          });
          if (auth.currentUser != null) {
            auth.currentUser?.sendEmailVerification();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("User Register Successfully"), backgroundColor: Colors.greenAccent,));

          }
        });

    } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$e"), backgroundColor: Colors.red,));
      
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
              constraints: BoxConstraints(maxWidth: 300),
              margin: EdgeInsets.all(10),
              child: TextField(
                controller: a,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "enter name",
                  suffixIcon: Icon(Icons.person)
                ),
              ),
            ),
            Container(
              constraints: BoxConstraints(maxWidth: 300),
              margin: EdgeInsets.all(10),
              child: TextField(
                controller: b,

                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "enter Email",
                  suffixIcon: Icon(Icons.email)
                ),
              ),
            ),
            Container(
              constraints: BoxConstraints(maxWidth: 300),
              margin: EdgeInsets.all(10),
              child: TextField(
                controller: c,

                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "enter password",
                  suffixIcon: Icon(Icons.password)
                ),
              ),
            ),
            Container(
              constraints: BoxConstraints(maxWidth: 300),
              margin: EdgeInsets.all(10),
              child: TextField(
                controller: d,

                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "enter Phone Number",
                  suffixIcon: Icon(Icons.person)
                ),
              ),
            ),

            ElevatedButton.icon(onPressed: register_func, 
            label: Text("Register"),
            icon: Icon(Icons.app_registration),
            iconAlignment: IconAlignment.end,),

            Container(
              margin: EdgeInsets.all(10),
              child: TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (builder)=>Signin()));
              }, child: Text("Already have Account",
              style: TextStyle(color: Colors.green),),)
            )
          ],
        )
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
