import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:user_authentication_authorization/Dashboard.dart';
import 'package:user_authentication_authorization/Signin.dart';
import 'package:user_authentication_authorization/Signup.dart';
import 'package:user_authentication_authorization/firebase_options.dart';

void main() async{
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
 

TextEditingController b = TextEditingController();
TextEditingController c = TextEditingController();

void login_func() async{
    try {
        FirebaseAuth auth = FirebaseAuth.instance;
      UserCredential ca = await auth.signInWithEmailAndPassword(
        email: b.text, 
        password: c.text);
        Navigator.push(context, MaterialPageRoute(builder: (a)=>Dash()));
      
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
            

            ElevatedButton.icon(onPressed: login_func, 
            label: Text("Login"),
            icon: Icon(Icons.login),
            iconAlignment: IconAlignment.end,),
            Container(
              margin: EdgeInsets.all(10),
              child: TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (builder)=>Signup()));
              }, child: Text("Don't have account",
              style: TextStyle(color: Colors.blue),),)
            )
          ],
        )
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
