import 'package:flutter/material.dart';
import 'package:flutter_bloc/home_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}




class MyHomePage extends StatefulWidget { 

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final model=HomeModel();
  


  @override
  void initState() { 

    model.getListData();
    super.initState();
    
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter BLoC Demo'),
      ),
      body:StreamBuilder(
        stream: model.homeState ,
        builder: (context,snapshot){
          
          if(snapshot.hasError){
            return displayInfoMessage(snapshot.error);
          }


          if(!snapshot.hasData|| snapshot.data==HomeViewState.Busy){
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if(snapshot.data==HomeViewState.Busy){
            return displayInfoMessage('There is no data for you, please add some one');
          }
          return ListView.builder(
            itemBuilder: (context,index)=>oneItemUI(index),
            itemCount: model.items.length,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          model.getListData();
        },
        child: Icon(Icons.refresh),
      ),
    );
  }

 
   Widget oneItemUI(int index) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(child: Text(model.items[index])),
      ),
      color: Colors.amber,
      margin: EdgeInsets.all(5),
      
    );
  }

  Widget displayInfoMessage(String msg){
    return Center(
      child: Text(
        msg,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.w900,
          color: Colors.red
        ),
      ),
    );
  }
}

