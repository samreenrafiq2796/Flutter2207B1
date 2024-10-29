import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
      debugShowCheckedModeBanner: false,
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
  // 1
  FirebaseFirestore db = FirebaseFirestore.instance;
  List<String> cate_name = [];
  String? Dropdown_select_item;
  TextEditingController pname= TextEditingController();
  TextEditingController pprice= TextEditingController();

// 2
 Future<List<String>> fetch_List() async{
    QuerySnapshot datauthao = await db.collection("Category").get();
    return datauthao.docs.map((a)=>a["Name"] as String).toList();
  }

// 3
  Future<void> fetch_category_name() async{
    List<String> a =await fetch_List();
    setState(() {
      cate_name = a;
    });
  }
// 4
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetch_category_name();

  }
  void Textbox_cleaer(){
    pname.clear();
    pprice.clear();

  }

   void save_product(){
    try {
      if (pname.text.isEmpty || pprice.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("All Fields are Required"), backgroundColor: Colors.red,));
      }
      else{
        db.collection("Product").add({
          "Name":pname.text,
          "Price":int.parse(pprice.text) ,
          "categoryname" : Dropdown_select_item
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Product Added in $Dropdown_select_item Category"), backgroundColor: Colors.greenAccent,));
        Textbox_cleaer();
      }
    } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$e"), backgroundColor: Colors.red,));
      
    }
   }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),




      body: Center(
        child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.all(10),
            constraints: BoxConstraints(maxWidth: 300),
            child: TextField(
            controller: pname,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter Name",
                  suffixIcon: Icon(Icons.person)),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            constraints: BoxConstraints(maxWidth: 300),
            child: TextField(
      controller: pprice,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter Price",
                  suffixIcon: Icon(Icons.email)),
            ),
          ),
          // 5
          Container(
           child: DropdownButton<String>(
            hint: Text("Select Category"),
            value: Dropdown_select_item,
            items: cate_name.map((items){
              return DropdownMenuItem(
                value:items,
                child: Text(items));
            }).toList(), 
            onChanged: (String? a){
              setState(() {
                Dropdown_select_item = a!;
              });
            }),
          ),
          OutlinedButton(onPressed:save_product, child: Text("Save Product"))
        ],
      )
       ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
