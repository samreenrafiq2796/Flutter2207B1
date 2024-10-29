import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:revision_firebase_add/main.dart';
import 'firebase_options.dart';
void main() async{
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const Show());
}

class Show extends StatelessWidget {
  const Show({super.key});

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


FirebaseFirestore db  = FirebaseFirestore.instance;

void db_update(String i, String n , String e){
  try {
    db.collection("Person").doc(i).update({
      "Name": n,
      "Email":e
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Record Updated")));
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$e")));
    
  }
}



void update_ka_dialog_box(BuildContext con, String id , String name, String email){
  TextEditingController name_con = TextEditingController(text: name);
  TextEditingController email_con = TextEditingController(text: email);

  showDialog(context: con, 
  builder: (builder)=>AlertDialog(
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          constraints: BoxConstraints(maxWidth: 200),
          margin: EdgeInsets.all(10),
          child: TextField(
            controller: name_con,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: name,
              suffixIcon: Icon(Icons.person)
            ),
          ),
        ),
         Container(
          constraints: BoxConstraints(maxWidth: 200),
          margin: EdgeInsets.all(10),
          child: TextField(
            controller: email_con,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: email,
              suffixIcon: Icon(Icons.email)
            ),
          ),
        ),

       
      ],
    ),


    actions: [
      IconButton(onPressed: (){
          db_update(id, name_con.text, email_con.text);
          Navigator.of(con,rootNavigator: true).pop();

      }, icon: Icon(Icons.edit)),
      IconButton(onPressed: (){
        Navigator.of(con,rootNavigator: true).pop();
      }, icon: Icon(Icons.close)),

    ],
  ));

}


void db_delete(String i)
{
  try {
    db.collection("Person").doc(i).delete();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Record Deleted")));

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
      body:StreamBuilder<QuerySnapshot>(
        stream: db.collection("Person").snapshots(), 
        builder: (context, snapshot){
          var fetchdata= snapshot.data!.docs;
          if (snapshot.data!.docs.isEmpty || !snapshot.hasData) {
            return Center(child:Text("No Data Found"));
          }
          if (snapshot.connectionState ==  ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: fetchdata.length,
            itemBuilder: (context,index){
              String u_id = fetchdata[index].id;
              var person_data = fetchdata[index].data() as Map<String, dynamic>;
              return Card(
                child: ListTile(
                  leading: Icon(Icons.recommend_rounded),
                  title: Text(person_data["Name"]?? "Not Found"),
                  subtitle: Text(person_data["Email"] ?? "Not Found"),
                  trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(onPressed: (){
                        showDialog(context: context, 
                        builder: (builder)=>AlertDialog(
                          title: Text("Delete"),
                          content: Text("Are you Sure you want to delete?"),
                          actions: [
                            IconButton(onPressed: (){
                                db_delete(u_id);
                                Navigator.of(context,rootNavigator: true).pop();

                            }, icon:Icon(Icons.delete) ),
                             IconButton(onPressed: (){
                                Navigator.of(context,rootNavigator: true).pop();
                            }, icon:Icon(Icons.close) )
                          ],
                        ));

                      }, icon: Icon(Icons.delete, color:Colors.red, size: 12,)),
                      IconButton(onPressed: (){
                        update_ka_dialog_box(context, u_id, person_data["Name"], person_data["Email"]);
                      }, icon: Icon(Icons.edit, size:12)),

                    ],
                  ),
                ),
              );
            });
        }),
      floatingActionButton: FloatingActionButton
      (onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (builder)=>MyApp()));
      },
      child: Icon(Icons.add),), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
